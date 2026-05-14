-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  transparency = true,

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
M.ui = {
  -- cmp = {
  --   lspkind_text = true,
  --   style = "default",    -- default/flat_light/flat_dark/atom/atom_colored
  --   format_colors = {
  --     lsp = true,
  --   },
  -- },

  telescope = { style = "borderless" }, -- borderless / bordered

  statusline = {
    enabled = true,
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "block",
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    -- treeOffsetFt = "NvimTree",
    -- order = { "treeOffset", "buffers", "tabs", "btns" },
    order = { "buffers", "tabs" },
    modules = nil,
    bufwidth = 21,
  },

}

return M
