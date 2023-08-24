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
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)	 -- Return to net_rw
vim.keymap.set("n", "<C-d>", ":noh<CR>")         -- unhighlight
vim.keymap.set("i", "<C-h>", "<Left>")           -- Insert mode left
vim.keymap.set("i", "<C-j>", "<Down>")           -- Insert mode down 
vim.keymap.set("i", "<C-k>", "<Up>")             -- Insert mode up 
vim.keymap.set("i", "<C-l>", "<Right>")          -- Insert mode right 

vim.keymap.set({"n", "t"}, "<Tab>", "<C-W>w")
vim.opt.splitbelow = true                                          -- Set splits to open below editor
vim.keymap.set({"n", "i"}, "<C-s>", ":15 split term://bash<CR>i")  -- Open Terminal
-- TODO: This only works in insert, find a way around this
vim.keymap.set("t", "<C-s>", "<C-\\><C-N>:q<CR>")               -- Close Terminal
vim.keymap.set("t", "<ESC>", "<C-\\><C-N>")                     -- Exit insert in terminal
vim.keymap.set({"t", "i", "n"}, "<A-Up>", "<C-W>+")
vim.keymap.set({"t", "i", "n"}, "<A-Down>", "<C-W>-")
vim.keymap.set({"t", "i", "n"}, "<A-Right>", "<C-W>>")
vim.keymap.set({"t", "i", "n"}, "<A-Left>", "<C-W><")

-- netrw config
vim.g.netrw_liststyle = 3       -- tree style listing
vim.g.netrw_banner = 0          -- remove banner
vim.g.netrw_winsize = 15
vim.g.netrw_altv = 1
vim.keymap.set('n', '<C-b>', ':Lex<CR>')    -- ctrl+b open netrw

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

-- vim.cmd("colorscheme leaf");

--nvim_comment
require('nvim_comment').setup()

-- Treesitter Config
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "python", "javascript", "typescript", "rust", "c", "lua", "vim", "vimdoc", "query", "html" },

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
