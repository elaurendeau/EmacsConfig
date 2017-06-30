(require 'package)

(prefer-coding-system 'utf-8)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))



(setq package-enable-at-startup nil)

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" default)))
 '(package-selected-packages
   (quote
    (jedi elpy nlinum-relative evil-jumper evil-mode linum-relative linum-mode use-package helm evil-visual-mark-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum-relative-current-face ((t (:inherit linum :weight bold :reverse t)))))



;; Package manager

(unless (package-installed-p 'use-package)

  (package-refresh-contents)

  (package-install 'use-package))



(eval-when-compile

  (require 'use-package))



;; EVIL-MODE -- VIM keybinds

(use-package evil

  :ensure t

  :config
  (evil-mode 1)



  (use-package evil-leader

    :ensure t

    :config

    (global-evil-leader-mode))



  (use-package evil-jumper

    :ensure t

    :config

    (global-evil-jumper-mode))



  (use-package evil-surround

    :ensure t

    :config

    (global-evil-surround-mode))



  (use-package evil-indent-textobject

    :ensure t))



;; RELATIVE LINE NUMBERS

(use-package linum-relative

  :ensure t

  :config

  ;; something else you want

  (setq linum-relative-current-symbol "->")

  (global-linum-mode 1)

  (linum-relative-mode 1))



;; POWERLINE FOR VIM MODE

(use-package powerline

	:ensure t

  :config (powerline-center-evil-theme))



;; COLOR THEMES

(use-package airline-themes

		:ensure t

		:config

		(load-theme 'airline-light))



(setq color-themes '())

(use-package zenburn-theme

  :ensure t

  :config

  (load-theme 'zenburn t))



;; FILE TREE EXPLORER

(use-package neotree

	:ensure t)

;; ----- PYTHON SUPPORT ------
(use-package jedi

(use-package elpy
  :ensure t
  :defer 2
  :config
  (progn
    ;; Use Flycheck instead of Flymake
    (when (require 'flycheck nil t)
      (remove-hook 'elpy-modules 'elpy-module-flymake)
      (remove-hook 'elpy-modules 'elpy-module-yasnippet)
      (remove-hook 'elpy-mode-hook 'elpy-module-highlight-indentation)
      (add-hook 'elpy-mode-hook 'flycheck-mode))
    (elpy-enable)
    ;; jedi is great
    (setq elpy-rpc-backend "jedi")))

;; package to try a package without installing it
(use-package try
  :ensure t)

;; which key to help with navigation
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; KEY MAPPING

;; FILE TREE TOGGLE
(require 'neotree)
(global-unset-key (kbd "M-1"))
(global-set-key (kbd "M-1") 'neotree-toggle)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)

;; Keybind for Ctrl U to go up with evil mode
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))
