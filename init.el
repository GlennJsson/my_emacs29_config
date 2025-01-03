;; inhibit splash screen
(setq inhibit-splash-screen t)

;; change the font
(set-face-attribute 'default nil :font "Cousine-14")

;; maximize screen at startup
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; disable menu on startup
(menu-bar-mode -1)

;; disable toolbar on startup
(tool-bar-mode -1)

;; disable scrollbar on startup
(scroll-bar-mode -1)

;; Set transient mark mode
(transient-mark-mode 1)

;; Enable ORG mode
(require 'org)

;; Elixir mode
(require 'elixir-mode)

;; set GNU style indenting for C
(setq c-default-style "linux"
      c-basic-offset 2)

;; turn on electric pair mode
(electric-pair-mode 1)

;; set transparency
(add-to-list 'default-frame-alist '(alpha-background . 98))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(erlang-mode elixir-mode magit company yasnippet go-mode dracula-theme gruvbox-theme material-theme atom-one-dark-theme prettier web-mode markdown-mode js2-mode emmet-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Load theme
(load-theme 'dracula t)

;; require emmet-mode (html, css)
(require 'emmet-mode)

;; company mode
(add-hook 'after-init-hook 'global-company-mode)
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.3
	company-minimum-prefix-length 1))

;; project
(require 'project)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

;;
;; Optional: load other packages before eglot to enable eglot integrations.
(require 'company)
(require 'yasnippet)
(require 'zig-mode)
(require 'go-mode)
(require 'eglot)
(add-hook 'go-mode-hook 'eglot-ensure)

;; Optional: install eglot-format-buffer as a save hook.
;; The depth of -10 places this before eglot's willSave notification,
;; so that that notification reports the actual contents that will be saved.
(defun eglot-format-buffer-on-save ()
  (add-hook 'before-save-hook #'eglot-format-buffer -10 t))
(add-hook 'go-mode-hook #'eglot-format-buffer-on-save)

;; config gopls
(setq-default eglot-workspace-configuration
    '((:gopls .
        ((staticcheck . t)
         (matcher . "CaseSensitive")))))
(add-hook 'before-save-hook
    (lambda ()
        (call-interactively 'eglot-code-action-organize-imports))
    nil t)

;; eglot and python
(use-package eglot
    :ensure t
    :defer t
    :hook (python-mode . eglot-ensure))

;; ZIG
(add-hook 'zig-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(zig-mode . ("zls")))

;; Elixir
;; This is optional. It automatically runs `M-x eglot` for you whenever you are in `elixir-mode`:
(add-hook 'elixir-mode-hook 'eglot-ensure)

;; Be sure to edit the path appropriately; use the `.bat` script instead for Windows:
(add-to-list 'eglot-server-programs '(elixir-mode "/home/glenn/.config/elixir-lsp/language_server.sh"))


;; C/C++
(progn
    (customize-set-variable 'eglot-autoshutdown t)
    (customize-set-variable 'eglot-extend-to-xref t)
    (customize-set-variable 'eglot-ignored-server-capabilities
        (quote (:documentFormattingProvider :documentRangeFormattingProvider)))

        (with-eval-after-load 'eglot
        (setq completion-category-defaults nil)
        (add-to-list 'eglot-server-programs
            '((c++-mode c-mode) 
                 . ("clangd"
                       "-j=4"
                       "--malloc-trim"
                       "--log=error"
                       "--background-index"
                       "--clang-tidy"
                       "--cross-file-rename"
                       "--completion-style=detailed"
                       "--pch-storage=memory"
                       "--header-insertion=never"
                       "--header-insertion-decorators=0"))))

	(add-hook 'c-mode-hook 'eglot-ensure)
	(add-hook 'c++-mode-hook 'eglot-ensure)
	(add-hook 'rustic-mode-hook 'eglot-ensure))


;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
(setq web-mode-engines-alist
      '(("php"    . "\\.phtml\\'")
        ("blade"  . "\\.blade\\."))
      )
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'eglot-server-programs '(js-mode . ("vscode-eslint-language-server" "--stdio")))
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.


;; misc
;; absolute/relative linenumbers
(setq display-line-numbers-type 'absolute)
(global-display-line-numbers-mode)

