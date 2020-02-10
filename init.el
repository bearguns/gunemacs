; configure emacs to use the melpa package repository
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; install the use-package package so we can use use-package to install packages to use
;; i always fetch the archive contents on startup and during compilation, which is slow
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; require use-package so we can install packages later in this file
(require 'use-package)

;; don't create lockfiles (they can muddy up git repos)
(setq create-lockfiles nil)

;; don't create backup files (they can muddy up git repos)
(setq make-backup-files nil)

;; emacs ui elements are kinda ugly IMO
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; show me which parens match the one I'm on
(show-paren-mode 1)

;; match parens and braces
(electric-pair-mode)

;; be smart about indentation
(electric-indent-mode)

;; make tramp respect the shell of the remote system
(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; use a cool font that is easy to read when coding
(set-face-attribute 'default nil
		    :family "JetBrains Mono"
		    :height 130
		    :weight 'normal
		    :width 'normal)

;; use the BIC atom one dark theme
(use-package atom-one-dark-theme
  :ensure t
  :config (load-theme 'atom-one-dark t))

;; install editorconfig for consistent settings across projects
(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

;; install projectile for navigating through projects easily
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  :init
  (projectile-mode +1))

;; install counsel/ivy/swiper for help finding what you're looking for
(use-package counsel
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (global-set-key (kbd "C-s") 'swiper-isearch)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "<f2> j") 'counsel-set-variable)
  (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
  (global-set-key (kbd "C-c v") 'ivy-push-view)
  (global-set-key (kbd "C-c V") 'ivy-pop-view)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c L") 'counsel-git-log)
  (global-set-key (kbd "C-c k") 'counsel-rg)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "C-c b") 'counsel-bookmark)
  :init
  (ivy-mode 1)
  (counsel-mode 1))

;; install magit for magical git goodness
(use-package magit
  :ensure t)

;; make it easier to see block scope, current array, etc
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))


;; provide html element and property expansion
(use-package emmet-mode
  :ensure t
  :config (add-hook 'html-mode-hook #'emmet-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("669e02142a56f63861288cc585bee81643ded48a19e36bfdf02b66d745bcc626" default)))
 '(package-selected-packages
   (quote
    (atom-one-dark-theme emmet-mode emmet counsel projectile rainbow-delimiters rainbow-delimiters-mode doneburn-theme magit use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
