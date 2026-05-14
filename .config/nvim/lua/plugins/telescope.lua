-- vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#2e2e2e', fg = '#ebdbb2' })
-- vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = '#EA6962' })

local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<M-j>"] = actions.move_selection_next,
        ["<M-k>"] = actions.move_selection_previous,
      }
    }
  },
}
