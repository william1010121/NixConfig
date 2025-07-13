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
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

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
;; ~/.doom.d/config.el

;; Enable org-modern
(use-package org-modern
  :hook (org-mode . org-modern-mode))


;; Enable C++ in org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t) (dot . t) (python . t) (wolfram . t)
   (emacs-lisp . t) )) ;; Add other languages if needed



(setq mac-option-modifier 'meta)        ; Set the Option key as Meta
(setq mac-right-option-modifier 'meta)  ; Disable the right Option key

;; Add hook for org-latex-preview
(add-hook 'org-mode-hook (lambda () (org-latex-preview-auto-mode)))



;; Add CDLaTeX
(add-hook 'org-mode-hook #'turn-on-cdlatex)
(add-hook 'org-mode-hook #'org-special-block-extras-mode)


;; Add AUCTeX
(use-package auctex
  :defer t)

;; Add Laas
(setq org-highlight-latex-and-related '(native latex entities)) ;; LaTeX 高亮设置
(setq org-pretty-entities t) ;; LaTeX 代码的 prettify
(setq org-pretty-entities-include-sub-superscripts nil) ;; 不隐藏 LaTeX 的上下标更容易编

(after! ispell
  (setq ispell-dictionary "en_GB"  ; Primary language
        ispell-alternate-dictionary "es_US"  ; Secondary fallback
        ispell-personal-dictionary "~/.hunspell_personal"))


(after! org
  (setq org-startup-indented nil))



                                        ; Open PDF using zathura
(after! org
  (setq org-file-apps
        '((auto-mode . emacs)
          ("\\.pdf::\\([0-9]+\\)?\\'" . "zathura %s -P %1")
          ("\\.pdf\\'" . "zathura %s")
          (directory . emacs))))

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((C . t) (shell . t) (python . t)))  ;; Enable C++ support




;;(with-eval-after-load 'yasnippet
;; (define-key yas-minor-mode-map (kbd "C-f") #'yas-next-field-or-maybe-expand)
;;(define-key yas-minor-mode-map (kbd "C-b") #'yas-prev-field))
(after! cdlatex
  (map! :map cdlatex-mode-map
        "<tab>" #'cdlatex-tab))
;;(after! org
;;(after! company
;;  (set-company-backend! '(org-mode python-mode)
;;     '(company-dabbrev :with company-yasnippet yasnippet-capf))))
(setq-default tab-width 4)


(add-hook 'org-mode-hook #'org-inline-anim-mode)


;; disable smart parten
(with-eval-after-load 'smartparens
  (sp-local-pair 'org-mode "'" nil :actions nil))



;; publish html
;;
;; Publish HTML



;; yas tab
;;
;;;; fix some org-mode + yasnippet conflicts:
;;;; ;;https://stackoverflow.com/questions/9418148/conflicts-between-org-mode-and-yasnippet
                                        ; (eval-after-load 'yasnippet
                                        ;   '(progn
                                        ;      (defun yas/org-very-safe-expand ()
                                        ;        (let ((yas/fallback-behavior 'return-nil))
                                        ;          (yas/expand)))
                                        ;      ;; Optionally, bind the function to a key in org-mode:
                                        ;      ))
                                        ;
;;; fix some org-mode + yasnippet conflicts:
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (yas-minor-mode 1)
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas-next-field)))


                                        ;
;;(load! "org-tbl.el")

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))



;; sage math
;; Ob-sagemath supports only evaluating with a session.
;;(setq org-babel-default-header-args:sage '((:session . t)
;;                                          (:results . "output")))

;; C-c c for asynchronous evaluating (only for SageMath code blocks).
;;(with-eval-after-load "org"
;;  (define-key org-mode-map (kbd "C-c c") 'ob-sagemath-execute-async))

;; Do not confirm before evaluation
(setq org-confirm-babel-evaluate nil)

;; Do not evaluate code blocks when exporting.
(setq org-export-babel-evaluate nil)

;; Show images when opening a file.
(setq org-startup-with-inline-images t)

;; Show images after evaluating code blocks.
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)


(after! projectile
  (add-to-list 'projectile-ignored-projects (expand-file-name "~")))

;; Remap tab commands under ', t'
                                        ;(org-babel-load-file ("my_config.org" doom-user-dir))
(org-babel-load-file (expand-file-name "my_config.org" doom-user-dir))
