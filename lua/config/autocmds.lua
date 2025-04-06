-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- This autocmd automatically configures tab settings based on LSP configuration
-- It runs whenever an LSP server attaches to a buffer
-- Purpose: Ensures consistent indentation based on the LSP server's recommended settings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Check if the LSP client has editor settings configured
    if client and client.config and client.config.settings then
      local settings = client.config.settings
      -- Apply tab settings from the LSP configuration if available
      if settings.editor and settings.editor.tabSize then
        local ts = settings.editor.tabSize
        -- Set buffer-local options for consistent indentation
        vim.api.nvim_buf_set_option(bufnr, "tabstop", ts)      -- Width of a tab character
        vim.api.nvim_buf_set_option(bufnr, "shiftwidth", ts)   -- Size of an indent
        vim.api.nvim_buf_set_option(bufnr, "softtabstop", ts)  -- Number of spaces a tab counts for when editing
        vim.api.nvim_buf_set_option(bufnr, "expandtab", true)  -- Use spaces instead of tabs
      end
    end
  end,
})
