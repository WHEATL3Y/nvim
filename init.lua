require("plugins")
-- VIM Configuration
vim.opt.guicursor = ""			-- Wide Cursor
vim.opt.number = true			-- Line Numbers
vim.opt.relativenumber = true	-- Relative Line Numbers

vim.opt.tabstop = 4			    -- 4 space tabs
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true		-- Replace tabs with 4 spaces

-- Remaps
-- Neovim Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)	-- Return to net_rw

-- Telescope Remaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Themes
-- https://github.com/folke/tokyonight.nvim
require("tokyonight").setup({
	-- Styles: night, storm, day, moon
	style = "night",
	light_style = "day"
})
vim.cmd[[colorscheme tokyonight]]

-- Treesitter Config
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "javascript", "rust", "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
  },
}

-- LSP-Zero Config
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
