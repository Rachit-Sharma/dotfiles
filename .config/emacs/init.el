;;Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;;Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;;Used for :diminish
(use-package diminish)

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
(desktop-save-mode 1)

;; (load-theme 'tango-dark)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; You must run (all-the-icons-install-fonts)
;; once after installing this package!
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom((doom-modeline-height 15)))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.4))

(use-package swiper)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Counsel is installed as part of ivy anyway but some configuration is needed
(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; By default, end of a sentence is period followed by two spaces
(setq sentence-end-double-space nil)

;; helps use u and C-r for undo-redo. refer evil-undo-system below
(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-undo-system 'undo-tree)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-evil-windows (:timeout 4)
  "evil window management"
  ("h" evil-window-left "move left")
  ("j" evil-window-down "move down")
  ("k" evil-window-up "move up")
  ("l" evil-window-right "move right")
  ("H" evil-window-decrease-width "decrease width")
  ("J" evil-window-increase-height "increase height")
  ("K" evil-window-decrease-height "decrease height")
  ("L" evil-window-increase-width "increase width")
  ("c" evil-window-delete "delete")
  ("SPC" nil "done" :exit t))

(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer rachit/leader-keys
    :states '(normal emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (rachit/leader-keys
    "g" '(:ignore t :which-key "git")
    "gs" '(magit-status :which-key "magit status")
    "w" '(hydra-evil-windows/body :which-key "evil window management")
    "b" '(ibuffer :which-key "ibuffer")))

(defun rachit/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :hook (org-mode . rachit/org-mode-setup)
  :config
  (setq org-ellipsis " ⏷")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Hello.org"
          "/mnt/B8D2174BD2170D6E/Infosys/asset-return.org"))

  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face))))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;;(defun rachit/org-mode-visual-fill ()
;;  (setq visual-fill-column-width 100
;;	visual-fill-column-center-text t)
;;  (visual-fill-column-mode 1))

;;doesn't work well with desktop-save-mode

;;(use-package visual-fill-column
;;  :hook (org-mode . rachit/org-mode-visual-fill))

;;This is needed as of Org 9.2
;;(require 'org-tempo)

;;(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((emacs-lisp . t)
;;   (python . t)))

;;(push '("conf-unix" . conf-unix) org-src-lang-modes)

;;Automatically tangle our Emacs.org config file when we save it
;;(defun rachit/org-babel-tangle-config ()
;;  (when (string-equal (buffer-file-name)
;;                      (expand-file-name "~/.dotfiles/emacs.org"))
;;    Dynamic scoping to the rescue
;;    (let ((org-confirm-babel-evaluate nil))
;;      (org-babel-tangle))))

;;(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'rachit/org-babel-tangle-config)))

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Workspace")
    (setq projectile-project-search-path '("~/Workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit)

(use-package evil-magit
  :after magit)

(use-package rainbow-delimiters
	     :hook (prog-mode . rainbow-delimiters-mode))
