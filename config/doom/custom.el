(put 'customize-group 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style
      '((c-mode . "cc-mode")
           (c++-mode . "cc-mode")
           (java-mode . "java")
           (awk-mode . "awk")
           (other . "doom")))
 '(cdlatex-auto-help-delay 1)
 '(cdlatex-math-modify-alist '((66 "\\mathbb" nil t nil nil)))
 '(cdlatex-sub-super-scripts-outside-math-mode nil)
 '(cdlatex-takeover-subsuperscript t)
 '(cdlatex-use-dollar-to-ensure-math nil)
 '(custom-safe-themes
      '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" default))
 '(exec-path
      '("/Users/guoshengwei/.elan/bin/" "/Users/guoshengwei/.pyenv/shims" "/opt/riscv/bin" "/opt/homebrew/opt/libgit2@1.7/bin" "/Users/guoshengwei/.cargo/bin" "/opt/riscv/bin" "/opt/homebrew/opt/libgit2@1.7/bin" "/Users/guoshengwei/.cargo/bin" "/opt/riscv/bin" "/opt/homebrew/opt/libgit2@1.7/bin" "/Users/guoshengwei/.cargo/bin" "/opt/riscv/bin" "/opt/homebrew/opt/libgit2@1.7/bin" "/Users/guoshengwei/.cargo/bin" "/opt/riscv/bin" "/opt/homebrew/opt/libgit2@1.7/bin" "/Users/guoshengwei/.nvm/versions/node/v22.14.0/bin" "/Users/guoshengwei/.cargo/bin" "/opt/local/bin" "/opt/local/sbin" "/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/bin" "/System/Cryptexes/App/usr/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin" "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin" "/opt/X11/bin" "/Library/Apple/usr/bin" "/Library/TeX/texbin" "/Applications/iTerm.app/Contents/Resources/utilities" "/Users/guoshengwei/.local/bin" "/Users/guoshengwei/.orbstack/bin" "/Users/guoshengwei/.rvm/bin" "/opt/homebrew/Cellar/emacs-plus@29/29.4/libexec/emacs/29.4/aarch64-apple-darwin24.3.0/"))
 '(gptel-default-mode 'org-mode)
 '(ibuffer-saved-filter-groups
      '(("cs-sys"
            ("Project: hostexporter"
                (projectile-root "hostexporter" . "/Users/guoshengwei/CSIT/system/hostexporter/"))
            ("Project: guoshengwei"
                (projectile-root "guoshengwei" . "/Users/guoshengwei/")))))
 '(ibuffer-saved-filters
      '(("programming"
            (or
                (derived-mode . prog-mode)
                (mode . ess-mode)
                (mode . compilation-mode)))
           ("text document"
               (and
                   (derived-mode . text-mode)
                   (not
                       (starred-name))))
           ("TeX"
               (or
                   (derived-mode . tex-mode)
                   (mode . latex-mode)
                   (mode . context-mode)
                   (mode . ams-tex-mode)
                   (mode . bibtex-mode)))
           ("web"
               (or
                   (derived-mode . sgml-mode)
                   (derived-mode . css-mode)
                   (mode . javascript-mode)
                   (mode . js2-mode)
                   (mode . scss-mode)
                   (derived-mode . haml-mode)
                   (mode . sass-mode)))
           ("gnus"
               (or
                   (mode . message-mode)
                   (mode . mail-mode)
                   (mode . gnus-group-mode)
                   (mode . gnus-summary-mode)
                   (mode . gnus-article-mode)))))
 '(lsp-auto-register-remote-clients nil)
 '(lsp-idle-delay 0.1)
 '(lsp-insert-final-newline nil)
 '(org-agenda-files
      '("~/Desktop/NYCU/Physic/note/Chapter19-20.org" "/Users/guoshengwei/Desktop/NYCU/Todo/CSIT/mail.org" "/Users/guoshengwei/org/todo.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/CCNA.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/Cryptography.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/Discrete-Mathematics.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/Information-Theory.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/NA.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/OOP.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/computer-architecture.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/digital-system.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/numeric-method.org" "/Users/guoshengwei/Desktop/NYCU/Todo/Courses/physics.org" "/Users/guoshengwei/Desktop/NYCU/Todo/todo.org"))
 '(org-attach-dir-relative t)
 '(org-export-with-broken-links 'mark)
 '(org-hide-macro-markers t)
 '(org-image-actual-width '(300))
 '(org-latex-default-packages-alist
      '(("" "amsmath" t
            ("lualatex" "xetex"))
           ("" "fontspec" t
               ("lualatex" "xetex"))
           ("AUTO" "inputenc" t
               ("pdflatex"))
           ("T1" "fontenc" t
               ("pdflatex"))
           ("" "amsmath" t
               ("pdflatex"))
           ("" "amssymb" t
               ("pdflatex"))
           ("" "capt-of" nil nil)
           ("" "hyperref" nil nil)
           ("" "xlop" nil nil)))
 '(org-latex-hyperref-template
      "\\hypersetup{\12 pdfauthor={%a},\12 pdftitle={%t},\12 pdfkeywords={%k},\12 pdfsubject={%d},\12 pdfcreator={%c},\12 pdflang={%L},\12colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue}\12")
 '(org-latex-packages-alist '(("" "pgfplots" t nil) ("" "tikz" t nil)))
 '(org-latex-preview-appearance-options
      '(:foreground auto :background "Transparent" :scale 1.5 :zoom 1.0 :page-width 0.6 :matchers
           ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-latex-preview-live '(inline block edit-special))
 '(org-latex-preview-live-debounce 0.1)
 '(org-latex-preview-live-display-type 'buffer)
 '(org-latex-preview-numbered nil)
 '(org-safe-remote-resources
      '("\\`https://fniessen\\.github\\.io/org-html-thetheme-readtheorg\\.setup\\'" "\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(org-startup-with-latex-preview nil)
 '(org-todo-keywords
      '((sequence "TODO(t!)" "PROJ(p@/!)" "LOOP(r@/!)" "STRT(s@/!)" "WAIT(w@/!)" "HOLD(h@/!)" "IDEA(i@/!)" "DOC(D@/!)" "|" "DONE(d!)" "KILL(k@/!)")
           (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
           (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))
 '(org-yank-image-save-method "")
 '(package-selected-packages
      '(gptel lsp-docker org-cite-overlay exec-path-from-shell citeproc-org citeproc org-contrib format-all copilot docker-tramp kubernetes ob-sagemath org-inline-anim))
 '(projectile-project-search-path '(("~/Desktop/NYCU/" . 4)))
 '(recentf-keep '("file-remote-p" recentf-keep-default-predicate))
 '(require-final-newline nil)
 '(safe-local-variable-values
      '((org-latex-src-block-backend . lstlisting)
           (org-latex-hyperref-template . "\\hypersetup{\12 pdfauthor={%a},\12 pdftitle={%t},\12 pdfkeywords={%k},\12 pdfsubject={%d},\12 pdfcreator={%c},\12 pdflang={%L},\12 hidelinks=true}\12")
           (eval setq flycheck-clang-include-path
               (list
                   (expand-file-name "include"
                       (projectile-project-root))))
           (eval let
               ((root
                    (projectile-project-root)))
               (setq-local flycheck-clang-include-path
                   (list
                       (concat root "include"))))
           (eval let
               ((root
                    (projectile-project-root)))
               (setq-local company-clang-arguments
                   (list
                       (concat "-I" root "/include")))
               (setq-local flycheck-clang-include-path
                   (list
                       (concat root "/include"))))
           (eval let
               ((root
                    (projectile-project-root)))
               (setq-local company-clang-arguments
                   (list
                       (concat "-I" root "include")))
               (setq-local flycheck-clang-include-path
                   (list
                       (concat root "include"))))))
 '(sage-shell:use-prompt-toolkit nil)
 '(sage-shell:use-simple-prompt t)
 '(tramp-terminal-type "dumb")
 '(verilog-indent-level-directive 2)
 '(vterm-shell "/bin/zsh"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'list-timers 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'magit-clean 'disabled nil)
