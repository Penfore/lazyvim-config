return {
  -- Configure the Lualine status line
  -- Purpose: Provides a customized status line with mode indicator, diagnostics, and file information
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    return {
      options = {
        theme = "auto",                -- Use colorscheme-based theme
        globalstatus = true,           -- Use a single statusline for all windows
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { 
          {
            "mode",                    -- Shows the current mode (NORMAL, INSERT, VISUAL, etc.)
          }
        },
        lualine_b = { "branch" },      -- Shows git branch information
        lualine_c = {
          {
            "diagnostics",             -- Shows LSP diagnostics
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
          -- Shows filetype icon
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- Shows filename with path and modification indicators
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
          "encoding",                  -- Shows file encoding
          "fileformat",                -- Shows file format (unix, dos, mac)
          "filetype",                  -- Shows filetype
        },
        lualine_y = {
          -- Shows progress through the file
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          -- Shows current line and column position
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R") -- Shows current time
          end,
        },
      },
    }
  end,
}