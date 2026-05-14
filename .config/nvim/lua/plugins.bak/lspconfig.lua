return {
  'neovim/nvim-lspconfig',
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- vim.lsp.enable({
    -- 	"bashls",
    -- 	"lua_ls",
    -- 	"zls",
    -- 	"pyright",
    --  "yamlls",
    --  "jsonls",
    -- })

    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
      fg = "#e06c75", -- text color
      undercurl = true,
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", {
      fg = "#e5c07b",
      undercurl = true,
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", {
      fg = "#56b6c2",
      undercurl = true,
    })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", {
      fg = "#c678dd",
      undercurl = true,
    })

    -- local ref_bg = "#2e2e2e"
    --
    -- vim.api.nvim_set_hl(0, "LspReferenceText", {
    --   bg = ref_bg,
    -- })
    --
    -- vim.api.nvim_set_hl(0, "LspReferenceRead", {
    --   bg = ref_bg,
    -- })
    --
    -- vim.api.nvim_set_hl(0, "LspReferenceWrite", {
    --   bg = ref_bg,
    -- })

    vim.diagnostic.config({
      -- virtual_lines = true,
      virtual_text = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        -- style = 'minimal',
        border = "rounded",
        -- source = true,
      },
    })
  end
}
