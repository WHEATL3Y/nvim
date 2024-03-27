# nvim
Neovim Configuration

# Install
- Install Neovim 
- Clone this repo into
    - `~/AppData/Local/` (Windows)
    - `~/.config/` (Linux)

# Remaps

# Installed Plugins
- Plugin Manager - Lazy 
    - https://github.com/folke/lazy.nvim
- Syntax Highlighting - nvim-treesitter
    - https://github.com/nvim-treesitter/nvim-treesitter
- LSP - LSP-Zero/Mason
    - https://github.com/VonHeikemen/lsp-zero.nvim
    - https://github.com/williamboman/mason.nvim
- Fuzzy Finder - Telescope
    - https://github.com/nvim-telescope/telescope.nvim
- Status Line - LuaLine
     - https://github.com/nvim-lualine/lualine.nvim
- Bracket Completion - Auto Pairs 
    - https://github.com/jiangmiao/auto-pairs
- Inteligent Commenting - nvim-comment
    -  https://github.com/terrortylor/nvim-comment
- Themes
    - Soloarized Osaka (Default) - https://github.com/craftzdog/solarized-osaka.nvim

# Common Issues and Fixes
Treesitter cc1plus error
```
nvim-treesitter[python]: Error during compilation
cc: fatal error: cannot execute ‘cc1plus’: execvp: No such file or directory
compilation terminated.
```
Solution

https://stackoverflow.com/questions/39455741/gcc-error-trying-to-exec-cc1plus-execvp-no-such-file-or-directory</br>
Install g++

`sudo dnf install g++`

---
Installing C compiler in Windows

This is required for tree-sitter to work. Similar to issue above but more of a pain in the ass.
Use the following link to download and install Windows C/C++ build tools
[Installing VS Build Tools](https://notes.jacobchristensen.me:443/s/31a3f53c-8005-468c-b66f-dc943dc04034)
