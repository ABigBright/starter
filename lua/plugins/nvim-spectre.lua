return {
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "replace in files (spectre)" },
    },
  },
}
