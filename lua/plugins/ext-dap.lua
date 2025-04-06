return {
  -- Configure .NET Core debugging for macOS ARM64
  -- Purpose: Adds debugging support for .NET applications on Apple Silicon Macs
  {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    dependencies = { "mfussenegger/nvim-dap" },
    -- Only load on macOS ARM64 systems
    cond = vim.fn.has("macunix") == 1 and vim.fn.system("uname -m"):find("arm64") ~= nil,
    init = function()
      -- Set up the debugger adapter
      require("netcoredbg-macOS-arm64").setup(require("dap"))
    end,
  },

  -- Configure .NET Core debugging for Linux x86_64
  -- Purpose: Adds debugging support for .NET applications on Linux x86_64 systems
  {
    "samsung/netcoredbg",
    dependencies = { "mfussenegger/nvim-dap" },
    -- Only load on Linux x86_64 systems
    cond = vim.fn.has("unix") == 1 and vim.fn.has("macunix") == 0 and vim.fn.system("uname -m"):find("x86_64") ~= nil,
    init = function()
      local dap = require("dap")
      -- Configure the netcoredbg adapter
      dap.adapters.netcoredbg = {
        type = "executable",
        command = vim.fn.exepath("netcoredbg"),
        args = {"--interpreter=vscode"}
      }
      -- Set up debug configurations for C# files
      dap.configurations.cs = {
        {
          type = "netcoredbg",
          name = "launch - netcoredbg",
          request = "launch",
          -- Prompt for the path to the .NET assembly to debug
          program = function()
            return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
          end,
        },
      }
    end,
  },
}
