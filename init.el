;; Don't show startup screen 
(setq inhibit-startup-screen t)

;; Don't show scratch message
(setq initial-scratch-message nil)

;; Turn off tool and scroll bars
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Alert by flashing the screen instead of making noise 
(setq visible-bell t)

;; Tabs are replaced by spaces when indenting
(setq-default indent-tabs-mode nil)

;; Display line numbers in programming language files
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Don't create lock and backup files
(setq create-lockfiles nil)
(setq make-backup-files nil)

;; Saves all buffers when you Alt+tab 
(add-hook 'focus-out-hook (lambda () (save-some-buffers t)))

;; Update open buffers when corresponding files change on disk
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode)

;; Paste via 'Ctrl-v' in the minibuffer
(define-key minibuffer-local-map (kbd "C-v") 'clipboard-yank)

;; Install modern package manager https://github.com/raxod502/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package will install packages by default using straight
(setq straight-use-package-by-default t)

;; https://github.com/jwiegley/use-package
;; Allow to add and configure packages
(straight-use-package 'use-package)

(use-package evil
  :demand
  :config
  (evil-mode 1)
  :bind
  (:map evil-insert-state-map
        ("C-v" . clipboard-yank)))

(use-package undo-tree
  :demand
  :after evil
  :config
  (global-undo-tree-mode)
  :custom
  (evil-undo-system 'undo-tree))

(use-package elpy
  :init
  (elpy-enable))
