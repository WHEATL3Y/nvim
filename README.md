# nvim
Neovim Linux Configuration

# Install
* Ensure Neovim is installed
* Clone this repo into `~/.config/`
* Open nvim and run `:PackerSync` 

# Remaps

# Installed Plugins

# Common Issues and Fixes
Treesitter cc1plus error
```
nvim-treesitter[python]: Error during compilation
cc: fatal error: cannot execute ‘cc1plus’: execvp: No such file or directory
compilation terminated.
```
Solution

https://stackoverflow.com/questions/39455741/gcc-error-trying-to-exec-cc1plus-execvp-no-such-file-or-directory
Install g++

`sudo dnf install g++`
