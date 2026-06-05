return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>em", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua", -- Lua 格式化
        "shfmt",  -- Shell 格式化
      },
    },
    -- @param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")

      -- 安装完包后触发 FileType 事件，让新 LSP server 立即在当前 buffer 生效
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      -- 刷新 registry 后自动安装缺失的工具
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    -- 桥接：mason 安装 → lspconfig 自动启用
    -- 具体配置在 nvim-lspconfig.lua 中完成
    lazy = true,
  },
}
