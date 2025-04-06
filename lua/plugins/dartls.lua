return {
  -- Configure the Dart Language Server
  -- Purpose: Adds LSP support for Dart/Flutter development
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Enable the dartls language server with default settings
        -- This provides code completion, diagnostics, and other LSP features for Dart files
        dartls = {},
      },
    },
  },
}
