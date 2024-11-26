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
vim.opt.cc = "80";              -- Max line width indicator

--
-- netrw
--
vim.g.netrw_liststyle = 3       -- tree style
vim.g.netrw_banner = 0          -- remove banner

--
-- Remaps
--

-- Esc to move from terminal to normal mode
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", {noremap=true})

-- Move between splits using CTRL+H,J,K,L
vim.api.nvim_set_keymap("n", "<C-h>", "<C-W><C-H>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-W><C-J>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-W><C-K>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-W><C-L>", {noremap=true})

--
-- Utilities

-- Get Platform
local binaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
local platform = ""
if binaryFormat == "dll" then
    platform = "win"
elseif binaryFormat == "so" then
    platform = "linux"
elseif binaryFormat == "dylib" then
    platform = "macos"
end

-- Find project root
local root = string.gsub(
        vim.fn.system("git rev-parse --show-toplevel"), "\n", ""
    )
if vim.v.shell_error == 0 then
    print("Found project root at", root)
else
    root = vim.loop.cwd()
    print("Didn't find project root, using", root);
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

    -- Fuzzy Finder (Telescope)
    {"nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {"nvim-lua/plenary.nvim"}
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

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim"
    },

    -- Markdown
    {
        'MeanderingProgrammer/markdown.nvim',
        main = "render-markdown",
        opts = {},
        -- name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
}

-- Init lazy
require("lazy").setup(plugins)

--
-- Theme Configuration
--
vim.opt.termguicolors = true
local osaka_config = {
    transparent = false,
}
require("solarized-osaka").setup(osaka_config)
vim.cmd.colorscheme('solarized-osaka')

--
-- LSP Zero
--
local lsp_zero = require("lsp-zero")
local lsp_config = require("lspconfig")
local configs = require("lspconfig/configs")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)
--lsp_config.intelephense.setup({})

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "jdtls",
        "lua_ls",
        "svelte",
    },
    handlers = {
        -- Default Handler
        lsp_zero.default_setup,

        -- Lua Handler
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        emmet_ls = function()
            local emmet_opts = {
                capabilities = capabilities,
                filetypes = {"css", "html"}
            }
            require("lspconfig").emmet_ls.setup(emmet_opts)
        end,
    }
})

-- LSP autocompletion
-- TODO: Familiarize myself with this section
-- copied from https://lsp-zero.netlify.app/v3.x/blog/theprimeagens-config-from-2022.html
--
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format({details = false}),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

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
    "markdown_inline"
    --"rust",
    --"javascript",
    --"html",
    --"css",
    --"typescript",
    --"svelte",
    --"java",
    --"json",
    --"python",
    },
    highlight = {
        enable = true,
        },
    auto_install = true,
    }
require("nvim-treesitter.configs").setup(treesitter_config)

--
-- Telescope
--
local telescope_config = {

}
require("telescope").setup(telescope_config)
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff',
    function() builtin.find_files({cwd = root}) end, {}
)
vim.keymap.set('n', '<leader>fg',
    function() builtin.live_grep({cwd = root}) end, {}
)
vim.keymap.set('n', '<leader>fb',
    function() builtin.buffers({cwd = root}) end, {}
)
vim.keymap.set('n', '<leader>fh',
    function() builtin.help_tags({cwd = root}) end, {}
)

--
-- Comment
--
require("Comment").setup()

--
-- Lua Line 
--
local lualine_config = {}
require("lualine").setup(lualine_config)

--
-- Gitsigns
--
require("gitsigns").setup()

--
-- Markdown 
--
require("render-markdown").setup()
