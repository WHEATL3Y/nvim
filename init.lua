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
      opts = {},},
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
