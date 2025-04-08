-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Add a VS Code-like replacement functionality for multiple replacements
-- Works in normal mode (word under cursor) and visual mode (selected text)
vim.keymap.set("n", "<leader>r", function()
  -- Get the word under cursor
  local cword = vim.fn.expand("<cword>")
  local new_text = vim.fn.input("Replace '" .. cword .. "' with: ")
  if new_text ~= "" then
    local cmd = "normal! *Ncgn" .. new_text
    vim.cmd(cmd)
  end
end, { desc = "Replace word under cursor (like VS Code Ctrl+D)" })

vim.keymap.set("v", "<leader>r", function()
  -- Save the current selection to the z register
  vim.cmd('noau normal! "zy')
  local selected_text = vim.fn.getreg("z")
  -- Escape special characters for search
  selected_text = selected_text:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "\\%1")
  
  local new_text = vim.fn.input("Replace '" .. selected_text .. "' with: ")
  if new_text ~= "" then
    -- Exit visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
    -- Search for the selected text
    vim.fn.setreg("/", selected_text)
    -- Replace the first occurrence
    local cmd = "normal! Ncgn" .. new_text
    vim.cmd(cmd)
  end
end, { desc = "Replace selected text (like VS Code Ctrl+D)" })
