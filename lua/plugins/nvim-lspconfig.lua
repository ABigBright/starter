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
        -- servers — LSP server 配置
        -- server = true   → 启用，全部默认
        -- server = false  → 禁用
        -- server = {...}  → 启用，使用自定义配置
        -- mason = false   → 不用 mason 管理此 server
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
      -- 7. 应用 ["*"] 全局默认配置
      -- ================================================================
      if opts.servers["*"] then
        local star = vim.deepcopy(opts.servers["*"])
        star.capabilities = vim.tbl_deep_extend("force", make_capabilities(), star.capabilities or {})
        vim.lsp.config("*", star)
      end

      -- ================================================================
      -- 8. 逐个 server 初始化
      -- ================================================================

      -- 尝试加载 mason-lspconfig（pcall 防止插件不存在时报错）
      -- have_mason: 是否成功加载（true = 装了该插件）
      -- mason_lsp: mason-lspconfig 模块引用，后续用它调用 .setup()
      local have_mason, mason_lsp = pcall(require, "mason-lspconfig")

      -- mason_all: mason 能安装的 LSP server 名称列表
      -- 格式: {"bashls", "cssls", "gopls", "lua_ls", "pyright", "rust_analyzer", "tsserver", ...}
      -- 数据来源: mason-lspconfig 内置的 lspconfig_to_package 映射表
      -- 用途: 判断某个 server 是否在 mason 管理范围内
      local mason_all = {}
      if have_mason then
        local ok, map = pcall(function()
          -- get_mason_map() 返回整个映射表（含 lspconfig_to_package、package_to_lspconfig 等）
          -- lspconfig_to_package: { lua_ls = "lua-language-server", pyright = "pyright", ... }
          -- vim.tbl_keys() 取其 key → server 名列表
          return mason_lsp.mappings.get_mason_map().lspconfig_to_package
        end)
        if ok then
          mason_all = vim.tbl_keys(map)
        end
      end

      -- mason_exclude: 告诉 mason 不要自动启用这些 server
      -- 内容来源:
      --   1. enabled = false 的 server（用户显式禁用）
      --   2. 被 opts.setup 自定义函数接管的 server（返回 true 表示"我自己管"）
      -- 最终传给 mason-lspconfig 的 automatic_enable.exclude
      local mason_exclude = {}

      -- ----------------------------------------------------------------
      -- configure(server) — 处理单个 LSP server 的配置和启动逻辑
      --   @param server string  server 名称（来自 opts.servers 的 key）
      --   @return boolean?      true = 归 mason 管理（保留到 install 列表）
      --                            nil = 不归 mason 管（已禁用 / setup 拦截 / mason 不支持）
      --
      -- sopts 的三种简写语义（对应 opts.servers[server] 的三种写法）:
      --   server = true   → sopts = {}                    (启用，全部用默认配置)
      --   server = false  → sopts = { enabled = false }   (禁用，不启动)
      --   server = nil    → sopts = { enabled = false }   (未定义也视为禁用)
      --   server = {...}  → sopts 保持不变                (启用，使用自定义配置)
      --
      -- sopts.mason ~= false (~= 是 Lua 的不等于操作符):
      --   除非显式写 mason = false（用系统安装版本），默认允许 mason 管理
      --
      -- #mason_exclude 是 Lua 长度操作符，等价于 table.insert:
      --   mason_exclude[#mason_exclude + 1] = server  追加到数组末尾
      -- ----------------------------------------------------------------
      local function configure(server)
        -- "*" 不是真实 server，跳过（它是全局默认配置，已在上一步 vim.lsp.config("*") 处理）
        if server == "*" then
          return false
        end

        local sopts = opts.servers[server]
        sopts = sopts == true and {}           -- true → 空 table，全部用默认
          or (not sopts) and { enabled = false } -- false/nil → 标记为禁用
          or sopts                                -- table → 保持不变

        -- 如果 server 标记为禁用（enabled = false）:
        --   1. 加入 mason 排除列表，阻止 mason 自动启用
        --   2. return 提前退出，不调 vim.lsp.config / vim.lsp.enable
        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        -- use_mason: 这个 server 是否交给 mason 管理
        -- 两个条件同时满足:
        --   ① sopts.mason ~= false  → 用户没显式禁用 mason
        --   ② vim.tbl_contains(mason_all, server) → mason 能安装这个 server
        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)

        -- 合并 cmp-like capabilities 到 server 配置
        -- deepcopy 防止污染 opts 原值，后续对同一 server 多次调用不受影响
        sopts = vim.deepcopy(sopts)
        sopts.capabilities = vim.tbl_deep_extend("force", make_capabilities(), sopts.capabilities or {})

        -- 检查是否有自定义 setup 函数
        -- 优先找 server 专属 setup（如 opts.setup.tsserver）
        -- 找不到退回到 ["*"] 兜底（如 opts.setup["*"]）
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          -- setup 返回 true = 用户自己接管了，加入排除列表，跳过默认流程
          mason_exclude[#mason_exclude + 1] = server
        else
          -- 默认流程: 写入配置到 Neovim 内置 LSP 系统
          vim.lsp.config(server, sopts)
          if not use_mason then
            -- 不归 mason 管的 server（如系统安装的），直接调用 Neovim 内置方式启动
            -- 归 mason 管的则等 mason-lspconfig 统一调用 automatic_enable 启动
            vim.lsp.enable(server)
          end
        end
        return use_mason -- 返回 true 才能被 vim.tbl_filter 保留到 install 列表
      end

      -- vim.tbl_filter: 对 opts.servers 的每个 key 调用 configure(server)
      -- 只保留 configure 返回 true 的项 → 即 mason 能安装的 server
      -- 例如默认配置下:
      --   "*"     → configure 第一行就 return false，过滤掉
      --   "lua_ls" → mason 支持，configure 返回 true，保留
      -- 结果 install = {"lua_ls"}
      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

      -- 交给 mason-lspconfig 统一处理安装和自动启用
      -- ensure_installed: mason 确保这些 LSP server 已安装（自动下载）
      -- automatic_enable.exclude: 装归装，但这些 server 不要自动启动
      --   （包括 enabled=false 的、被 opts.setup 自定义函数接管的）
      -- 注意: 只有当安装了 mason-lspconfig 且 install 列表非空时才调用
      if have_mason and #install > 0 then
        mason_lsp.setup({
          ensure_installed = install,
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end,
  },
}
