local dap = require('dap')
local dapui = require('dapui')

-- Refer to https://github.com/sar/dap-ui.nvim

dapui.setup()

-- Show/hide DAP-UI automatially when DAP is invoked
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

