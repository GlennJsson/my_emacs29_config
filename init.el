;; inhibit splash screen
(setq inhibit-splash-screen t)

;; change the font
(set-face-attribute 'default nil :font "Cousine-14")

;; maximize screen at startup
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; disable menu on startup
(menu-bar-mode -1)

;; disable toolbar on startup
;;(tool-bar-mode -1)

;; disable scrollbar on startup
;;(scroll-bar-mode -1)

;; set GNU style indenting for C
(setq c-default-style "linux"
      c-basic-offset 2)

;; turn on electric pair mode
(electric-pair-mode 1)

;; set transparency
(add-to-list 'default-frame-alist '(alpha-background . 90))

(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit company yasnippet go-mode dracula-theme gruvbox-theme material-theme atom-one-dark-theme prettier web-mode markdown-mode js2-mode emmet-mode)))
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

;; misc
;; absolute/relative linenumbers
(setq display-line-numbers-type 'absolute)
(global-display-line-numbers-mode)

