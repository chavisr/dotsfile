-- v2
-- local cmp = require('blink.cmp')
-- cmp.build():wait(60000)
-- cmp.setup()

-- v1
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<A-k>'] = { 'select_prev', 'fallback' },
    ['<A-j>'] = { 'select_next', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false },
    list = { selection = { preselect = false, auto_insert = true } },
  },
  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = false } },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  signature = { enabled = true },
})
