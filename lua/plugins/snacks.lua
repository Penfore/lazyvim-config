return {
  -- Configure snacks.nvim to show hidden files
  -- Purpose: Customizes the file explorer to display hidden files (dot files)
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          exclude = { ".git", ".angular" },
        },
        files = {
          hidden = true,
          ignored = true,
          exclude = { ".git", ".angular", "node_modules" },
        },
      },
    },
  },
}
