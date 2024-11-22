;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jason Shi"
      user-mail-address "orioncerberus@onionmail.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "sans" :size 16))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Restoring old Vim substitution behaviour on s/S
;; (remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; Stop auto pairs
(remove-hook 'doom-first-input-hook #'smartparens-global-mode)

;; Backup files
(setq auto-save-default t
      make-backup-files t)
(setq backup-directory-alist '(("." . "~/.emacsbkups")))

;; Exec Path From Shell Setup

(when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))

(when (daemonp)
    (exec-path-from-shell-initialize))

;; Case sensitive search/replace
(setq case-fold-search nil)
(smex-initialize)
;; (set-cursor-color "#d0c511")
;; (setq-default cursor-type '(box . 1))
;; (setq-default cursor-type '(hbar . 1))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "C-x C-a") 'accent-menu)

;; Duplicate Lines
(global-set-key (kbd "C-S-d") 'duplicate-line)

;; Multiple Cursors
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Ace Window
;; (global-set-key (kbd "M-o") #'ace-window)

;; Goto Line
(global-set-key (kbd "M-g M-g") 'goto-line)

;; Other window settings
(global-set-key (kbd "C-}") #'enlarge-window-horizontally)
(global-set-key (kbd "C-{") #'shrink-window-horizontally)
(global-set-key (kbd "C-^") #'enlarge-window)
(global-set-key (kbd "C-%") #'shrink-window)
(global-set-key (kbd "C-+") #'balance-windows)

;; EDITOR
;; (setq evil-normal-state-cursor '(box "light blue")
;;      evil-insert-state-cursor '(bar "medium sea green")
;;      evil-visual-state-cursor '(hollow "orange"))
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)
(setq god-mode-enable-function-key-translation nil)
;;(global-set-key (kbd "<escape>") #'god-local-mode)
(global-set-key (kbd "s-c") #'god-local-mode)
(global-set-key (kbd "<f1>") #'god-local-mode)
(global-set-key (kbd "C-<f1>") #'god-local-mode)
;; (global-set-key (kbd "<f2>") #'evil-mode)
;; (global-set-key (kbd "C-<f2>") #'evil-mode)
;; (evil-mode 0)
(god-mode-all -1)

;; Mortal mode
; This mortal mode is designed to allow temporary departures from god mode
; The idea is that within god-mode, you can hit shift-i, type in a few characters
; and then hit enter to return to god-mode. To avoid clobbering the previous bindings,
; we wrap up this behavior in a minor-mode.
(define-minor-mode mortal-mode
  "Allow temporary departures from god-mode."
  :lighter " mortal"
  :keymap '(([return] . (lambda ()
                          "Exit mortal-mode and resume god mode." (interactive)
                          (god-local-mode-resume)
                          (mortal-mode 0))))
  (when mortal-mode
   (god-local-mode-pause)))

(define-key god-local-mode-map (kbd "I") 'mortal-mode)

;; EVIL GOD STATE
;; (evil-define-key 'normal global-map "," 'evil-execute-in-god-state)
;; (add-hook 'evil-god-state-entry-hook (lambda () (diminish 'god-local-mode)))
;; (add-hook 'evil-god-state-exit-hook (lambda () (diminish-undo 'god-local-mode)))
;; (evil-define-key 'god global-map [escape] 'evil-god-state-bail)
