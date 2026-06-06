return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    opts_extend = { "servers.*.keys" },
    opts = function()
      local icons = require("config.init").icons

      local ret = {
        -- ================================================================
        -- diagnostics — 诊断信息显示方式
        -- ================================================================
        diagnostics = {
          underline = true,           -- 出错位置下划线
          update_in_insert = false,   -- 插入模式下不更新诊断
          virtual_text = {
            spacing = 4,              -- 虚拟文字距代码 4 列
            source = "if_many",       -- 多个来源时才显示来源名
            prefix = "icons",         -- "icons" = 根据 severity 使用 icons.diagnostics 图标
          },
          severity_sort = true,       -- 按严重程度排序
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            },
          },
        },

        -- ================================================================
        -- inlay_hints — 内联类型提示
        -- ================================================================
        inlay_hints = {
          enabled = true,
          exclude = {}, -- 排除的文件类型，如 { "vue" }
        },

        -- ================================================================
        -- codelens — 代码透镜（默认关闭，耗性能）
        -- ================================================================
        codelens = {
          enabled = false,
        },

        -- ================================================================
        -- folds — LSP 驱动的代码折叠
        -- ================================================================
        folds = {
          enabled = true,
        },

        -- ================================================================
        -- servers — LSP server 自定义配置
        -- server = {...}  → 自定义配置，覆盖默认值
        -- server = false  → 禁用（已安装也不会自动启动）
        -- mason = false   → 不用 mason 管理此 server（用系统已安装的）
        -- 无需 server = true：8d 段自动 enable 所有已安装的 mason server
        -- ================================================================
        servers = {
          -- ["*"] 全局默认配置，应用到所有 LSP server
          ["*"] = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true,
                  willRename = true,
                },
              },
            },
          },
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false, -- 不检查第三方库，避免卡顿
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },  -- 下划线开头视为私有
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
        },

        -- ================================================================
        -- setup — 自定义 server 初始化钩子
        -- 返回 true 阻止默认的 vim.lsp.config + vim.lsp.enable 流程
        -- ================================================================
        setup = {
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
        },
      }
      return ret
    end,

    ---@param opts table
    config = function(_, opts)
      -- ================================================================
      -- 1. 配置 diagnostics
      -- ================================================================
      -- "icons" prefix → 根据 severity 返回对应图标
      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        local icons = require("config.init").icons
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local map = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
          }
          return map[diagnostic.severity] or "●"
        end
      end
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- ================================================================
      -- 2. LSP keymaps — LspAttach 时注册到 buffer
      --    模式: n = normal, i = insert, v = visual, x = visual (exclusive)
      --    desc 字段同时给 which-key 提供中文分组显示
      --    <leader>e 开头 → which-key "lsp" 分组（与 which-key 预设一致）
      -- ================================================================
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          -- 通用 LSP 快捷键（标准键，不依赖特定 capability）
          -- gr 加 nowait，避免和 which-key 的等待延迟冲突
          local maps = {
            { "n", "K",          vim.lsp.buf.hover,              "Hover" },
            { "n", "gd",         vim.lsp.buf.definition,         "Goto Definition" },
            { "n", "gr",         vim.lsp.buf.references,         "References",              nowait = true },
            { "n", "gI",         vim.lsp.buf.implementation,     "Goto Implementation" },
            { "n", "gy",         vim.lsp.buf.type_definition,    "Goto Type Definition" },
            { "n", "gD",         vim.lsp.buf.declaration,        "Goto Declaration" },
            { "n", "gK",         vim.lsp.buf.signature_help,     "Signature Help" },
            { "n", "[[",         vim.diagnostic.goto_prev,       "Previous Diagnostic" },
            { "n", "]]",         vim.diagnostic.goto_next,       "Next Diagnostic" },
            { "n", "<leader>ea", vim.lsp.buf.code_action,        "Code Action",             mode = { "n", "v" } },
            { "n", "<leader>el", "<cmd>LspInfo<cr>",             "LSP Info" },
          }

          for _, m in ipairs(maps) do
            local opts = { buffer = buf, desc = m[4] }
            if m.nowait then
              opts.nowait = true -- 跳过 which-key 延迟，立即执行
            end
            vim.keymap.set(m.mode or m[1], m[2], m[3], opts)
          end

          -- signature help in insert mode（需要服务器支持 textDocument/signatureHelp）
          if client.supports_method("textDocument/signatureHelp") then
            vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = buf, desc = "Signature Help" })
          end

          -- rename（需要服务器支持 textDocument/rename）
          if client.supports_method("textDocument/rename") then
            vim.keymap.set("n", "<leader>er", vim.lsp.buf.rename, { buffer = buf, desc = "Rename Symbol" })
          end

          -- code lens: run + refresh（需要服务器支持 textDocument/codeLens + Neovim 0.10+ vim.lsp.codelens）
          if client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
            vim.keymap.set({ "n", "x" }, "<leader>ec", vim.lsp.codelens.run,     { buffer = buf, desc = "Run Codelens" })
            vim.keymap.set("n",           "<leader>eC", vim.lsp.codelens.refresh, { buffer = buf, desc = "Refresh Codelens" })
          end

          -- organize imports（过滤 code action，只执行 source.organizeImports）
          -- context.only 告诉服务器只返回这类 action，apply=true 直接执行不弹窗
          if client.supports_method("textDocument/codeAction") then
            vim.keymap.set("n", "<leader>eo", function()
              vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" } },
                apply = true,
              })
            end, { buffer = buf, desc = "Organize Imports" })

            -- source action（过滤 code action，只展示 source.* 类）
            vim.keymap.set("n", "<leader>eA", function()
              vim.lsp.buf.code_action({
                context = { only = { "source" } },
              })
            end, { buffer = buf, desc = "Source Action" })
          end
        end,
      })

      -- ================================================================
      -- 3. inlay hints
      -- ================================================================
      if opts.inlay_hints.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buf = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if
              client
              and client.supports_method("textDocument/inlayHint")
              and vim.bo[buf].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buf].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end
          end,
        })
      end

      -- ================================================================
      -- 4. LSP 驱动折叠
      -- ================================================================
      if opts.folds.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.supports_method("textDocument/foldingRange") then
              vim.opt.foldmethod = "expr"
              vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
            end
          end,
        })
      end

      -- ================================================================
      -- 5. code lens 自动刷新
      -- ================================================================
      if opts.codelens.enabled and vim.lsp.codelens then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.supports_method("textDocument/codeLens") then
              vim.lsp.codelens.refresh()
              vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = args.buf,
                callback = vim.lsp.codelens.refresh,
              })
            end
          end,
        })
      end

      -- ================================================================
      -- 6. 增强 capabilities（模拟 cmp_nvim_lsp.default_capabilities）
      -- ================================================================
      local function make_capabilities()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument = vim.tbl_deep_extend("force", capabilities.textDocument or {}, {
          completion = {
            completionItem = {
              snippetSupport = true,
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
            },
          },
        })
        return capabilities
      end

      -- ================================================================
      -- 6b. 加载 lspconfig 为某个 server 提供的默认配置
      --     nvim-lspconfig v2.9+ 的新格式在 lsp/<server>.lua
      --     旧格式在 lspconfig/configs/<server>.lua（已废弃但仍有效）
      --     返回 nil 表示找不到默认配置
      -- ================================================================
      local function get_lspconfig_default(server)
        -- nvim-lspconfig v2.9+ 新格式在插件根目录 lsp/<server>.lua（vim.lsp.Config 格式）
        -- 优点: root_markers 代替 root_dir，无旧格式的 vim.fs.find bug
        -- 由于 lsp/ 不在 lua/ 下，require 不可达，通过文件路径 + dofile 加载
        local lazy_root = vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig"
        local new_path = lazy_root .. "/lsp/" .. server .. ".lua"
        if vim.uv.fs_stat(new_path) then
          local ok, cfg = pcall(dofile, new_path)
          if ok and type(cfg) == "table" and cfg.cmd then
            return cfg
          end
        end
      end

      -- ================================================================
      -- 7. 应用 ["*"] 全局默认配置
      -- ================================================================
      if opts.servers["*"] then
        local star = vim.deepcopy(opts.servers["*"])
        star.capabilities = vim.tbl_deep_extend("force", make_capabilities(), star.capabilities or {})
        vim.lsp.config("*", star)
      end

      -- ================================================================
      -- 8. LSP server 配置与启动
      -- ================================================================

      -- 尝试加载 mason-lspconfig（pcall 防止插件不存在时报错）
      local have_mason, mason_lsp = pcall(require, "mason-lspconfig")

      -- ----------------------------------------------------------------
      -- 8a. 构建 mason 支持的所有 server 列表（从 filetype 映射收集去重）
      --     用于判断某 server 是否 mason 能安装
      --     直接用静态 filetype_mappings，避免 get_mappings() 触发
      --     get_mason_map() → cached_specs()，若 registry 未 refresh
      --     则缓存空结果，导致后续 ensure_installed 映射失败
      -- ----------------------------------------------------------------
      local mason_all = {}
      if have_mason then
        local ok, ft_mappings = pcall(require, "mason-lspconfig.filetype_mappings")
        if ok and type(ft_mappings) == "table" then
          local all = {}
          for _, servers in pairs(ft_mappings) do
            for _, server in ipairs(servers) do
              all[server] = true
            end
          end
          mason_all = vim.tbl_keys(all)
        end
      end

      local mason_exclude = {} -- 告诉 mason 不要自动启用这些 server

      -- ----------------------------------------------------------------
      -- 8c. FileType 时才按需加载配置并启用 LSP server
      --     不预加载所有 server 默认配置，只在第一次遇到某 filetype 时
      --     才 dofile 对应 1~3 个 server 的 lsp/*.lua
      -- formatter-only tools that appear in mason-lspconfig mappings
      -- but are not actual LSP servers — never attempt to enable
      local lsp_blacklist = {
        stylua = true,
      }

      -- ----------------------------------------------------------------
      do
        local ok_ft, ft_mappings = pcall(require, "mason-lspconfig.filetype_mappings")
        if ok_ft and type(ft_mappings) == "table" then
          vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
              local ft = vim.bo[args.buf].filetype
              local servers = ft_mappings[ft]
              if not servers then
                return
              end
              for _, server in ipairs(servers) do
                if
                  opts.servers[server] == nil
                  and not vim.lsp.is_enabled(server)
                  and not vim.tbl_contains(mason_exclude, server)
                  and not lsp_blacklist[server]
                then
                  local cfg = vim.lsp.config._configs[server]
                  if not cfg then
                    local defaults = get_lspconfig_default(server)
                    if defaults then
                      defaults.capabilities = vim.tbl_deep_extend(
                        "force", make_capabilities(), defaults.capabilities or {})
                      vim.lsp.config(server, defaults)
                      cfg = defaults
                    end
                  end
                  if cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1 then
                    vim.lsp._enabled_configs[server] = {}
                  end
                end
              end
            end,
          })
        end
      end

      -- ----------------------------------------------------------------
      -- 8d. 对 opts.servers 中声明的 server 进行配置
      --     server = true   → 标记为 ensure_installed，让 mason 自动安装
      --     server = false  → 加入 mason_exclude，禁止自动启用
      --     server = {...}  → 合并用户配置覆盖默认值，重新注册
      -- ----------------------------------------------------------------
      local function configure(server)
        if server == "*" then
          return false -- 不是真实 server，跳过
        end

        local sopts = opts.servers[server]
        -- 用户没在 servers 中声明的 → 跳过（已由 8b 预注册默认配置）
        -- 用户在 :Mason 手动安装的 server 仍会被 automatic_enable 启动
        if sopts == nil then
          return
        end

        -- 简写处理: true → 空 table（全部默认）| false → 禁用
        sopts = sopts == true and {}
          or (not sopts) and { enabled = false }
          or sopts

        -- 用户显式禁用 → 加入排除列表
        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          -- 清除已注册的默认配置（__newindex 验证 cfg 为 table，不能直接传 nil）
          vim.lsp.config._configs[server] = nil
          return
        end

        -- 加载默认配置，用用户 opts 覆盖（"keep": 保留用户已设置的值）
        local defaults = get_lspconfig_default(server)
        if defaults then
          sopts = vim.tbl_deep_extend("keep", sopts, defaults)
        end

        -- 合并 capabilities 并重新注册（覆盖 8b 中的纯默认配置）
        sopts = vim.deepcopy(sopts)
        sopts.capabilities = vim.tbl_deep_extend("force", make_capabilities(), sopts.capabilities or {})

        -- 自定义 setup 钩子（如 typescript.nvim 接管 tsserver）
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts)  -- 重新注册含用户覆盖的配置
          vim.lsp.enable(server)          -- 启动 server（idempotent）
        end

        -- 返回 true → server 加入 ensure_installed 列表，mason 确保安装
        return sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      end

      -- 只对 opts.servers 中显式声明的 server 调用 configure
      -- 未声明的 server 保留 8b 中注册的纯默认配置
      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

      -- 过滤已安装的 server：ensure_installed 依赖 lspconfig→mason 映射，
      -- 该映射可能尚未加载，导致 "not a valid entry" 告警。已安装的跳过即可。
      if have_mason and #install > 0 then
        local installed = {}
        for _, pkg in ipairs(require("mason-registry").get_installed_package_names()) do
          installed[pkg] = true
        end
        install = vim.tbl_filter(function(server)
          -- 直接包名匹配（pyright→pyright），少数不匹配的（lua_ls→lua-language-server）
          -- 回退到 _configs 里的 cmd 二进制名匹配
          local cfg = vim.lsp.config._configs[server]
          local bin = cfg and cfg.cmd and cfg.cmd[1]
          return not installed[server] and not (bin and installed[bin])
        end, install)
      end

      -- ----------------------------------------------------------------
      -- 8e. 设置 mason-lspconfig
      --     ensure_installed: 启动时确保这些 server 已通过 mason 安装
      --     automatic_enable.exclude: 禁止自动启用这些 server
      --     automatic_enable 在未来 :Mason 安装时自动 enable 新 server
      -- ----------------------------------------------------------------
      if have_mason then
        mason_lsp.setup({
          ensure_installed = install,
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end,
  },
}
