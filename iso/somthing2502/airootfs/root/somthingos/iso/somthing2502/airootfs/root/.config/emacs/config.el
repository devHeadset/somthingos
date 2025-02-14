(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :height 110)
(set-face-attribute 'variable-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 120)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrainsMono Nerd Font"
  :height 110)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

;; init packages sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
  (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))
  (use-package evil-tutor)

(use-package general
          :config
          (general-evil-setup)

          ;; set up 'SPC' as the global leader key
          (general-create-definer ht/leader-keys
            :states '(normal insert visual emacs)
            :keymaps 'override
            :prefix "SPC" ;; set leader
            :global-prefix "M-SPC") ;; access leader in insert mode

          (ht/leader-keys
            "b" '(:ignore t :wk "buffer")
            "bb" '(switch-to-buffer :wk "Switch buffer")
            "bk" '(kill-this-buffer :wk "Kill this buffer")
            "bn" '(next-buffer :wk "Next buffer")
            "bp" '(previous-buffer :wk "Previous buffer")
            "br" '(revert-buffer :wk "Reload buffer"))
            "bi"  '(ibuffer :wk "Ibuffer")
 (ht/leader-keys
  "." '(find-file :wk "Find file")
  "f c" '((lambda () (interactive) (find-file "~/.emacs.d/config.org")) :wk "Edit emacs config")
  "TAB TAB" '(comment-line :wk "Comment lines"))



 (ht/leader-keys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable")
  ;;"h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config"))
  "h r r" '(reload-init-file :wk "Reload emacs config"))

 (ht/leader-keys
  "t" '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t t" '(visual-line-mode :wk "Toggle truncated lines")
  "t e" '(term :wk "Terminal"))


 (ht/leader-keys
  "h" '(:ignore t :wk "Help")
  "h f" '(describe-function :wk "Describe function")
  "h v" '(describe-variable :wk "Describe variable")
  "h r r" '(reload-init-file :wk "Reload emacs config"))

 (ht/leader-keys
  "t" '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t t" '(visual-line-mode :wk "Toggle truncated lines"))


)

(use-package catppuccin-theme)
  (load-theme 'catppuccin :no-confirm)
(use-package doom-themes)

(use-package toc-org
      :commands toc-org-enable
      :init (add-hook 'org-mode-hook 'toc-org-enable))

  (add-hook 'org-mode-hook 'org-indent-mode)
  (use-package org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(electric-indent-mode -1)
(require `org-tempo)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package dashboard
:ensure t 
:init
(setq initial-buffer-choice 'dashboard-open)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
(setq dashboard-center-content nil) ;; set to 't' for centered content
(setq dashboard-items '((recents . 5)
                        (agenda . 5 )
                        (bookmarks . 3)
                        (projects . 3)
                        (registers . 3)))
:custom
(dashboard-modify-heading-icons '((recents . "file-text")
                                  (bookmarks . "book")))
:config
(dashboard-setup-startup-hook))
