;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ######
;; GLOBAL
;; ######

(setq user-full-name "Amitai Gottlieb"
      user-mail-address "amitaig@hailo.ai")

;; ###########
;; KEYBINDINGS
;; ###########

;; Alt-o to swtich between header/source files
(map! "M-o" #'lsp-clangd-find-other-file)

(map! "C-l" #'evil-ex-nohighlight)

(map! :nv "g r" #'+lookup/references)

;; #############
;; LOOK AND FEEL
;; #############

;; Theme
(setq doom-theme 'gruvbox-light-medium)
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 15))
(custom-theme-set-faces! 'gruvbox-light-medium '(mode-line :background "#ebdbb2"))
(custom-theme-set-faces! 'gruvbox-light-medium '(line-number :foreground "#666666" :background "#fbf1c7"))

;; Sexy DOOM splash-screen
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

;; Relative Numbers
(setq display-line-numbers-type 'relative)

;; Scrolloff
(setq scroll-step 1)
(setq scroll-margin 15)

;; Ruler at 120
(setq-default fill-column 120)
(global-display-fill-column-indicator-mode 1)

;; Mood line (super-minimalist mode-line)
(use-package! mood-line
  :config
  (mood-line-mode))

;; Use tree-sitter for better syntax-highlighting
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; #############################
;; FILES, AUTO-SAVES AND BACKUPS
;; #############################

;; Fast auto-save, always
(auto-save-mode +1)
(setq auto-save-visited-interval 1)
(auto-save-visited-mode +1)

;; No backup files, please
(setq make-backup-files nil)

;; ##############
;; REMOTE EDITING
;; ##############

;; To fix vc-gutter over ssh
(use-package! diff-hl
  :hook (doom-first-file . global-diff-hl-mode)
  :config
  ;; Fix Doom disabling vc in remote buffers
  (after! tramp
    (setopt vc-ignore-dir-regexp locate-dominating-stop-dir-regexp)))

;; Tramp settings
(after! tramp
  ;; https://github.com/doomemacs/doomemacs/issues/6502
  (setq tramp-auto-save-directory nil)
  ;; Use rsync to sync remote files; faster on large files.
  (setq tramp-default-method "rsync"))
