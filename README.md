# nvim
Neovim Linux Configuration

# Install
* Ensure Neovim is installed
* Clone this repo into `~/AppData/Local/`

# Remaps

# Installed Plugins
- Plugin Manager - Lazy 
    - https://github.com/folke/lazy.nvim
- Fuzzy Finder - Telescope
    - https://github.com/nvim-telescope/telescope.nvim
- LSP - LSP-Zero
    - https://github.com/VonHeikemen/lsp-zero.nvim
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
