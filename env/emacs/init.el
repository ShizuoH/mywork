;; backspace

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(keyboard-translate ?\C-h ?\C-?)

;;python-mode
(add-hook 'python-mode-hook
      '(lambda()
         (setq indent-tabs-mode nil)
         (setq indent-level 2)
         (setq python-indent 2)
         (setq tab-width 2)))

;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)


;;
(require 'cask "~/.cask/cask.el")


