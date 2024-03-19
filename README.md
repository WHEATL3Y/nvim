# nvim
Neovim Linux Configuration

# Install
- Ensure Neovim is installed
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
This doesn't solve a specific issue, it sovles almost every issue with Neovim and Windows
1. Run the following in powershell (Admin)
    1. `winget install llvm`
1. Start neovim in a refreshed environment (`refreshenv`)

---
Windows

The following plugins do not currently work on Windows, troubleshooting is ongoing
- LSP-Zero/Mason
- nvim-comment
