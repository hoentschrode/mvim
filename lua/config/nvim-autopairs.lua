local autopairs = require('nvim-autopairs')
 
autopairs.setup {
  check_ts = true,
}

autopairs.add_rules(require "nvim-autopairs.rules.endwise-lua")

