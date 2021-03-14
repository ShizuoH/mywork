(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; theme
(load-theme 'zenburn t)
(tool-bar-mode 0)

; C-zをundo
(define-key global-map (kbd "C-z") 'undo)

;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)

;; ???
(keyboard-translate ?\C-h ?\C-?)

;;;;;;;;;; mode ;;;;;;;;;;
;;python-mode
(add-hook 'python-mode-hook
      '(lambda()
         (setq indent-tabs-mode nil)
         (setq indent-level 2)
         (setq python-indent 2)
         (setq tab-width 2)))


;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

