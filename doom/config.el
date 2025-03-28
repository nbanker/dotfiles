;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
(setq
 doom-font                (font-spec :family "Hack Nerd Font" :size 16)
 doom-variable-pitch-font (font-spec :family "Hack Nerd Font")
 global-prettify-symbols-mode t)

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'frappe) ; or 'frappe 'latte, 'macchiato, or 'mocha
(load-theme 'catppuccin t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; source: https://nayak.io/posts/golang-development-doom-emacs/
;; golang formatting set up
;; use gofumpt
(after! lsp-mode
  (setq  lsp-go-use-gofumpt t)
  )
;; automatically organize imports
(add-hook 'go-mode-hook #'lsp-deferred)
;; Make sure you don't have other goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; enable all analyzers; not done by default
(after! lsp-mode
  (setq  lsp-go-analyses
         '((fieldalignment . t)
           (nilness . t)
           (shadow . t)
           (unusedparams . t)
           (unusedwrite . t)
           (useany . t)
           (unusedvariable . t)))
  )

;; set LLM
(setq
 gptel-model 'claude-3-5-sonnet-20241022	 ;  "https://github.com/anthropics/courses/blob/master/anthropic_api_fundamentals/03_models.ipynb
 gptel-backend (gptel-make-anthropic "Claude"
                 :stream t :key "${ADD_ANTHROPIC_KEY}"))

;; ;; config DevDocs
;; (use-package! devdocs
;;   :config
;;   (setq devdocs-data-dir (expand-file-name "devdocs" doom-core-dir))
;;   (add-hook 'python-mode-hook 'devdocs-install)
;;   (add-hook 'python-mode-hook 'devdocs-lookup-mode))


;; Configure Kubernetes
(use-package! kubernetes
  :commands (kubernetes-overview))
