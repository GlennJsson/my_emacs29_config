# my_emacs29_config
## Development environment
OS: Linux or MAC OS X.  
Editor: emacs  
Languages: C/C++, Golang, Python, ZIG, HTML/Javascript/CSS/SASS.  
Environment: Docker  
Embedded environment: IDF ESP32, STM32.  
Compilers: CLANG, GCC, zig compiler.  

### Emacs version 29
Package installer: ELPA/MELPA.  
Installed packages:
- magit
- company
- yasnippet
- go-mode
- web-mode
- markdown-mode
- js2-mode
- emmet-mode
- prettier

Themes:
- dracula-theme
- gruvbox-theme
- material-theme
- atom-one-dark-theme

### On first startup
Run `M-x package-refresh-contents`  
Run `M-x package-install-selected-packages`  
  
### Golang
Install go and gopls.  
URL: https://pkg.go.dev/golang.org/x/tools/gopls  
URL: https://cs.opensource.google/go/x/tools/+/refs/tags/gopls/v0.15.3:gopls/doc/emacs.md  
`GO111MODULE=on go install golang.org/x/tools/gopls@latest`  
In bashrc or zshrc:  
`export GOPATH="$(go env GOPATH)"`  
`export PATH="${PATH}:${GOPATH}/bin"`  

### Python
Install python and python-lsp-server.  
On MAC: `brew install python-lsp-server`  

### C/C++ (clang/clangd)
Install clang and clang tools extra (for clangd).  
`dnf install clang-tools-extra`  

### ZIG and ZLS (LSP)
Install ZIG.  
`dnf install zig`  

### HTML/Javascript/CSS/JSON
Install vscode-langservers:  
`npm i -g vscode-langservers-extracted`  


