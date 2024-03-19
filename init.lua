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
<<<<<<< HEAD
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
=======
-- Neovim Remaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)	 -- Return to net_rw
vim.keymap.set("n", "<C-d>", ":noh<CR>")         -- unhighlight
vim.keymap.set("i", "<C-h>", "<Left>")           -- Insert mode left
vim.keymap.set("i", "<C-j>", "<Down>")           -- Insert mode down 
vim.keymap.set("i", "<C-k>", "<Up>")             -- Insert mode up 
vim.keymap.set("i", "<C-l>", "<Right>")          -- Insert mode right 
vim.keymap.set("i", "<C-a>", "<C-o>_")           -- Move to beginning of line (Insert)
vim.keymap.set("i", "<C-e>", "<C-o>$")           -- Move to end of line (Insert)
vim.keymap.set("i", "<C-a>", "_")                -- Move to beginning of line (Normal)
vim.keymap.set("i", "<C-e>", "$")                -- Move to end of line (Normal)

vim.keymap.set("n", "<Tab>", "<C-W>w")
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

--
-- Themes
--
-- Tokyonight
-- require("tokyonight").setup({
-- 	-- Styles: night, storm, day, moon
-- 	style = "night",
-- 	light_style = "day"
-- })
-- vim.cmd[[colorscheme tokyonight]]

-- gruvbox
require("gruvbox")
vim.cmd("colorscheme gruvbox")

-- nordic
-- require("nordic")
-- vim.cmd("colorscheme nordic")

-- paper color
-- require("PaperColor")
-- vim.cmd("colorscheme PaperColor")

-- nvim_comment
require('nvim_comment').setup()

-- Treesitter Config
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
      "c",
      "html",
      "java",
      "javascript",
      "lua",
      "python",
      "query",
      "rust",
      "typescript",
      "vim",
      "vimdoc",
  },
>>>>>>> b6481bdb394234927b6d4a80c181488c49bb3932

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

<<<<<<< HEAD
-- Init lazy
require("lazy").setup(plugins)
=======
-- Lualine config
require("lualine").setup{
    options = {
        icons_enable = true,
    }
}
-- LSP-Zero Config
local lsp = require('lsp-zero').preset({})
>>>>>>> b6481bdb394234927b6d4a80c181488c49bb3932

--
-- Theme Configuration
--
local osaka_config = {
    transparent = false,
}
require("solarized-osaka").setup(osaka_config)
vim.cmd[[colorscheme solarized-osaka]]

-- 
-- Stuff that doesn't work on Windows
--
if not platform == "win" then
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
            "java",
            "json",
            "python",
            },
            highlight = {enable = true},
            auto_install = true;
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
