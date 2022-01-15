;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun rachit/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'rachit/display-startup-time)

;;Initialize package sources
(require 'package)

(setq package-archives '(("melpa stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
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
;; Used to check package loading during startup
;; (setq use-package-verbose t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  :config
  (auto-package-update-maybe) ;;If emacs is run fresh
  (auto-package-update-at-time "09:00")) ;;If emacs is left running

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 10)
;; Saving session using perspective.el instead
;; (desktop-save-mode 1)

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

(use-package default-text-scale
  :config
  (default-text-scale-mode 1))

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
  (set-face-attribute 'line-number nil :foreground "#808080")
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
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
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
  :after ivy
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

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  (prescient-sort-length-enable nil)
  :config
  ;; Comment the following line to not have sorting remembered across sessions
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun rachit/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(use-package org
  :commands (org-capture org-agenda)
  :hook (org-mode . rachit/org-mode-setup)
  :config
  (setq org-ellipsis " ⏷")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files '("~/Org/Tasks.org"))

  (setq org-refile-targets '(("~/Org/Archive.org" :maxlevel . 2)
                             ("~/Org/Tasks.org" :maxlevel . 2)))
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

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

(with-eval-after-load 'org
  ;;This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

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
  :after (counsel projectile)
  :config (counsel-projectile-mode))

(use-package treemacs-projectile
  :after (treemacs projectile))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package rainbow-delimiters
	     :hook (prog-mode . rainbow-delimiters-mode))

(add-hook 'prog-mode-hook 'electric-pair-mode)

;; Ensuring that breadcrumbs appear
(defun rachit/lsp-mode-setup()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode)
  (setq gc-cons-threshold (* 100 1000 1000))
  (setq read-process-output-max (* 5 1024 1024))) ;; 3mb

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((prog-mode . lsp-deferred)
         (lsp-mode . rachit/lsp-mode-setup))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after (lsp ivy))

(use-package dap-mode
  :commands dap-debug
  :after (lsp general)
  :config
  (require 'dap-mode)
  (dap-node-setup)
  (general-define-key
   :keymaps 'lsp-mode-map
   :prefix lsp-keymap-prefix
   "d" '(dap-hydra t :wk "debugger"))) ;; Automatically installs Node debug adapter if needed

(defun rachit/underscore-in-word ()
  (modify-syntax-entry ?_ "w"))

(use-package yaml-mode
  :mode (("\\.yaml\\'" . yaml-mode)
         ("\\.yml\\'" . yaml-mode)))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(defun rachit/emmet-set-jsx-classname ()
  (setq emmet-expand-jsx-className? t))

(use-package rjsx-mode
  :mode (("\\.js\\'" . rjsx-mode)
         ("\\.jsx\\'" . rjsx-mode))
  :hook ((rjsx-mode . lsp-deferred)
         (rjsx-mode . rachit/underscore-in-word)
         (rjsx-mode . rachit/emmet-set-jsx-classname))
  :custom
  (js-indent-level 2))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :custom
  (typescript-indent-level 2))

(defun rachit/setup-tide-mode ()
  (interactive)
  (tide-setup)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (setq tide-format-options '(:indentSize 2)))

(use-package web-mode
  :mode "\\.tsx\\'"
  :hook (web-mode . lsp-deferred))

(use-package tide
  :after (web-mode)
  :hook (web-mode . rachit/setup-tide-mode))

(use-package add-node-modules-path
  :after (rjsx-mode)
  :hook (rjsx-mode . add-node-modules-path))

(defun rachit/emmet-reset-jsx-classname ()
  (setq emmet-expand-jsx-className? nil))

(use-package emmet-mode
  :hook ((sgml-mode . emmet-mode)
         (css-mode . emmet-mode)
         (sgml-mode . rachit/emmet-reset-jsx-classname)
         (css-mode . rachit/emmet-reset-jsx-classname))
  :config
  (setq emmet-move-cursor-between-quotes t))

(use-package prettier-js
  :after (rjsx-mode add-node-modules-path)
  :hook ((rjsx-mode . prettier-js-mode)
         (css-mode . prettier-js-mode)
         (web-mode . prettier-js-mode))
  :custom
  (prettier-js-args '(
                      "--config-precedence" "prefer-file"
                      "--trailing-comma" "none"
                      "--arrow-parens" "avoid")))

(use-package json-mode
  :mode "\\.json\\'")

(use-package lsp-dart
  :hook (dart-mode . lsp-deferred))

(use-package lsp-java
  :custom
  (lsp-java-vmargs '("-noverify"
                     "-Xmx1G"
                     "-XX:+UseG1GC"
                     "-XX:+UseStringDeduplication"
                     "-javaagent:/home/rachit/.m2/repository/org/projectlombok/lombok/1.18.22/lombok-1.18.22.jar")))

;; We need to add $PATH for node to run
(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil)
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package lsp-origami
  :hook (lsp-mode . lsp-origami-try-enable)
  :config
  (global-origami-mode))

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-responsive 'top))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
              ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common)
        ("C-c y" . company-yasnippet))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;;Disabled until https://github.com/sebastiencs/company-box/issues/158 is resolved
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package company-prescient
  :after company
  :custom
  (company-prescient-sort-length-enable nil)
  :config
  (prescient-persist-mode 1)
  (company-prescient-mode 1))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package yasnippet
  :after company
  :config
  (yas-global-mode)
  :custom
  (lsp-enable-snippet t))

(use-package yasnippet-snippets)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package dired-single
  :after (dired evil-collection)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package perspective
  :hook (persp-mode . persp-state-load)
  :bind (("C-x b" . persp-counsel-switch-buffer)
         ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-state-default-file "~/.emacs.d/auto-save-list/perspectives")
  :config
  (add-hook 'kill-emacs-hook #'persp-state-save)
  :init
  ;; Running `persp-mode' multiple times resets the perspective list...
  (unless (equal persp-mode t)
    (persp-mode)))

(use-package treemacs-perspective
  :after (treemacs perspective)
  :config (treemacs-set-scope-type 'Perspectives))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; By default, end of a sentence is period followed by two spaces
(setq sentence-end-double-space nil)

;; helps use u and C-r for undo-redo. refer evil-undo-system below
(use-package undo-tree
  :init
  (global-undo-tree-mode 1))

(use-package evil
  :after undo-tree
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

(use-package treemacs-evil
  :after (treemacs evil))

(modify-syntax-entry ?_ "w")

(use-package hydra
  :defer t)

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

(defhydra hydra-switch-perspectives (:timeout 4)
  "switch perspectives"
  ("h" persp-prev "move left")
  ("l" persp-next "move right")
  ("SPC" nil "done" :exit t))

(use-package general
  :after evil
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
    "s" '(hydra-switch-perspectives/body :which-key "switch perspectives")
    "b" '(persp-ibuffer :which-key "persp-ibuffer")
    "p" '(:keymap projectile-command-map :package projectile :which-key "projectile")
    "l" '(:keymap lsp-command-map :package lsp-mode :which-key "lsp")
    "x" '(:keymap perspective-map :package perspective :which-key "perspective")))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
