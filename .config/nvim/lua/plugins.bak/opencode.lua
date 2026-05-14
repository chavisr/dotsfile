-- return {
--   "NickvanDyke/opencode.nvim",
--   dependencies = {
--     -- Recommended for `ask()` and `select()`.
--     -- Required for default `toggle()` implementation.
--     { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
--   },
--   config = function()
--     ---@type opencode.Opts
--     vim.g.opencode_opts = {
--       -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
--     }
--
--     -- Required for `opts.auto_reload`.
--     vim.o.autoread = true
--
--     -- Recommended/example keymaps.
--     vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
--       { desc = "Ask opencode" })
--     vim.keymap.set({ "n", "x" }, "<leader>oA", function() require("opencode").ask("", { submit = true }) end,
--       { desc = "Ask opencode" })
--     vim.keymap.set({ "n", "x" }, "<leader>ox", function() require("opencode").select() end,
--       { desc = "Execute opencode action…" })
--     vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add to opencode" })
--     vim.keymap.set({ "n", "t" }, "<leader>oo", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
--     vim.keymap.set({ "n", "t" }, "<leader>ot", function() require("opencode").command("agent.cycle") end,
--       { desc = "Cycle agent" })
--     vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
--       { desc = "opencode half page up" })
--     vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
--       { desc = "opencode half page down" })
--     -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
--     -- vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
--     -- vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
--
--     -- Listen for `opencode` events
--     vim.api.nvim_create_autocmd("User", {
--       pattern = "OpencodeEvent",
--       callback = function(args)
--         -- See the available event types and their properties
--         -- vim.notify(vim.inspect(args.data.event))
--         -- Do something useful
--         if args.data.event.type == "session.idle" then
--           vim.notify("`opencode` finished responding")
--         end
--       end,
--     })
--   end,
-- }

return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = {  -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
        terminal = {}, -- Enables the `snacks` provider
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
      { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
      { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
      { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
      { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
