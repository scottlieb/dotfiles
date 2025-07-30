;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ######
;; GLOBAL
;; ######

(setq
   user-full-name "Amitai Gottlieb"
   user-mail-address "amitaig@hailo.ai"
)

;; #############
;; LOOK AND FEEL
;; #############

;; Sexy DOOM Dashboard!
(defun doom-dashboard-custom-look ()
  (interactive)
  (face-remap-add-relative 'doom-dashboard-banner '(:foreground "black"))
  (make-local-variable 'evil-normal-state-cursor)
  (setq mode-line-format nil)
  (setq evil-normal-state-cursor '("#fbf1c6" 'bar))
)

(add-hook '+doom-dashboard-functions #'doom-dashboard-custom-look)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-loaded)
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-footer)

;; Theme
(setq doom-theme 'gruvbox-light-medium)
(setq doom-font (font-spec :family "JetBrainsMono NF" :size 15))
(custom-theme-set-faces! 'gruvbox-light-medium '(mode-line :background "#ebdbb2"))
(custom-theme-set-faces! 'gruvbox-light-medium '(line-number :foreground "#666666" :background "#fbf1c7"))

;; Mood line (super-minimalist mode-line)
(use-package! mood-line :config (mood-line-mode))

;; ######
;; EDITOR
;; ######

;; Relative Numbers
(setq display-line-numbers-type 'relative)

;; Scrolloff
(setq scroll-step 1)
(setq scroll-margin 15)

;; Ruler at 120 (we aren't in the 80's anymore)
(setq-default fill-column 120)
(global-display-fill-column-indicator-mode 1)

(add-hook 'vterm-mode-hook
  #'(lambda () (display-fill-column-indicator-mode -1))
)

;; Make word selection like vim
(add-hook 'after-change-major-mode-hook
  #'(lambda () (modify-syntax-entry ?_ "w"))
)

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
    (setopt vc-ignore-dir-regexp locate-dominating-stop-dir-regexp)
  )
)

;; Tramp settings
(after! tramp
  ;; https://github.com/doomemacs/doomemacs/issues/6502
  (setq tramp-auto-save-directory nil)
  ;; projectectile is slow AF over ssh.
  (projectile-mode -1)
  ;; Use rsync to sync remote files; faster on large files.
  (setq tramp-default-method "rsync")
)

;; ################
;; CUSTOM FUNCTIONS
;; ################

(defun my/replace-symbol (to-string)
  (interactive "sReplace symbol with :")
  (let ((from-string (symbol-at-point)))
    (save-excursion
      (goto-char (point-min))
      (while (search-forward (symbol-name from-string) nil t)
        (replace-match to-string)
      )
    )
  )
)

(defvar my/ssh-projectects nil
  "List of SSH projectects to open (using `SPC o s`)"
)

(setq-default my/ssh-projectects '(
  ("10.41.75.37" . "/local/users/amitaig/platform-sw")
  ("10.41.75.37" . "/local/users/amitaig/scu-fw")
))

(defun my/ssh--project-to-string (project)
  "Internal: map (<project> . <dir>) to tramp-readable string"
  (concat "/ssh:" (car project) ":" (cdr project))
)

(defun my/open-ssh ()
  "Search for and open an SSH projectect listed in my/ssh-projectects"
  (interactive)
  (let ((project (completing-read "Known SSH projects: " (mapcar 'my/ssh--project-to-string my/ssh-projectects))))
    (find-file project)
  )
)

;; ############
;; KEY-MAPPINGS
;; ############

(map! :desc "Switch between source/header file" "M-o" #'lsp-clangd-find-other-file)

(map! :desc "Clear search highlight" "C-l" #'evil-ex-nohighlight)

(map! :map evil-motion-state-map
  :desc "Go to References" "gr" #'+lookup/references
  :desc "Go to Definition" "gd" #'+lookup/definition
)

(unbind-key "C-/")
(map! :v :Desc "Comment lines" "C-/" #'evilnc-comment-operator)
(map! :n :Desc "Comment line"  "C-/" #'comment-line)

;; my/
(map! :nv :Desc "Search-and-replace in buffer for symbol at point" "C-*" #'my/replace-symbol)
(map! :nv :Desc "Open new ssh connection" :leader "os" #'my/open-ssh)
