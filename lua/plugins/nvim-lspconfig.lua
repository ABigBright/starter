return {
  -- 使用方式：
  --   1. :Mason 安装需要的 LSP server（如 clangd、pyright 等）
  --   2. 重启 nvim 或 :LspRestart → server 自动启用，无需改配置
  --   3. 如果某个 server 需要自定义配置（如 lua_ls 关闭弹窗），在 servers 表中声明
  --   4. servers 表中声明的 server 会被 ensure_installed 自动安装
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many" },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        },
      },
      servers = {
        -- 只需要声明需要自定义配置的 server，
        -- 其余 server 由 Mason 安装后自动启用。
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        clangd = {
          root_markers = { ".root", ".git" },
          cmd = { "clangd", "--background-index" },
        },
      },
    },

    config = function(_, opts)
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- 基础 keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local m = { noremap = true, silent = true, buffer = buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, m)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, m)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, m)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, m)
          vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, m)
          vim.keymap.set("n", "<leader>l", "<cmd>LspInfo<cr>", m)
          if client.supports_method("textDocument/signatureHelp") then
            vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, m)
          end
        end,
      })

      -- 注册 servers 配置
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      for name, cfg in pairs(opts.servers) do
        cfg.capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities or {})
        vim.lsp.config(name, cfg)
      end

      -- Mason lspconfig：自动安装 + 自动启用已安装的 server
      local ok, ml = pcall(require, "mason-lspconfig")
      if ok then
        local install = vim.tbl_keys(opts.servers)
        ml.setup({
          ensure_installed = install,
          automatic_enable = true,
        })
      end
    end,
  },
}
