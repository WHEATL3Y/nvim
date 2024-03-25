--
-- Basics
--
vim.opt.guicursor = ""          -- Block cursor
vim.opt.number = true           -- Enable line numbers
vim.opt.relativenumber = true   -- Enable relative line numbers
vim.opt.tabstop = 4             -- Set tabstop
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true        -- Change tab into spaces
vim.g.mapleader = " "           -- Set leader key to space

--
-- netrw
--
vim.g.netrw_liststyle = 3   -- tree style
vim.g.netrw_banner = 0      -- remove banner

--
-- Remaps
--

-- Esc to move from terminal to normal mode
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", {noremap=true})

--
-- Get Platform
--

local binaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
local platform = ""
if binaryFormat == "dll" then
    platform = "win"
elseif binaryFormat == "so" then
    platform = "linux"
elseif binaryFormat == "dylib" then
    platform = "macos"
end

--
-- Package manager (lazy.nvim)
--

-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Define Plugins
local plugins = {
    -- Theme
    {"craftzdog/solarized-osaka.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },

    -- LSP Management (LSP Zero/Mason)
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",

    -- Syntax Highlight (TreeSitter)
    {"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",      
    },

    -- Bracket Compleation (Lexima)
    "cohama/lexima.vim",

    -- Comments
    {
        "numToStr/Comment.nvim",
        lazy = false,
    },

    -- Tabline/Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"},
    },
}

-- Init lazy
require("lazy").setup(plugins)

--
-- Theme Configuration
--
local osaka_config = {
    transparent = false,
}
require("solarized-osaka").setup(osaka_config)
vim.cmd[[colorscheme solarized-osaka]]

--
-- LSP Zero
--
local lsp_zero = require("lsp-zero");
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup({})
require("mason-lspconfig").setup({
ensure_installed = {},
handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
	local lua_opts = lsp_zero.nvim_lua_ls()
	require("lspconfig").lua_ls.setup(lua_opts)
    end,
}
})

-- 
-- Stuff that doesn't work on Windows
--
if not (platform == "win") then
	--
	-- TreeSitter
	--
	local treesitter_config = {
	    ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"rust",
		"javascript",
		"html", 
		"css",
		"typescript",
		"svelte",
		"java",
		"json",
		"python",
		},
		highlight = {enable = true},
		auto_install = true
	    }

	require("nvim-treesitter.configs").setup(treesitter_config)

	--
	-- Comment
	--

	require("Comment").setup()

end


--
-- Lua Line 
--
local lualine_config = {
    sections = {
        lualine_c = {"filename", "buffers"},
    }
}
require("lualine").setup(lualine_config)
