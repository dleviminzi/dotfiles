local Remap = require("minzi.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

require('dap-go').setup()
require('nvim-dap-virtual-text').setup()

nnoremap("<F5>", function() require('dap').continue() end)
nnoremap("<F10>", function() require('dap').step_over()end)
nnoremap("<F11>", function() require('dap').step_into()end)
nnoremap("<F3>", function() require('dap').step_out()end)
nnoremap("<F9>", function() require('dap').toggle_breakpoint()end)
nnoremap("<leader>B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
nnoremap("<leader>lp", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
nnoremap("<leader>dt", function() require('dap-go').debug_test() end)

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  -- expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        "repl",
        -- "breakpoints",
        "console",
        "stacks",
      },
      size = 40, 
      position = "right",
    },
    {
      elements = {
        "scopes",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
