;;; publish_setup/computer-architecture.el -*- lexical-binding: t; -*-

(setq org-publish-project-alist
    (append
        '(
             ("org-computer-arch-notes"
                 :base-extension "org"
                 :recursive t
                 :headline-levels 4
                 :section-numbers nil
                 :with-toc t
                 :html-link-home "./"
                 :html-link-up "./"
                 :base-directory "~/Desktop/NYCU/computer architecture/"  ; ensure this path is correct
                 :publishing-directory "~/Desktop/NYCU/publish_html/computer_architecture/"
                 :publishing-function org-html-publish-to-html
                 :completion-function (lambda (project)
                                          (shell-command "rsync -av ~/Desktop/NYCU/publish_html/computer_architecture/ guosw@linux1.cs.nycu.edu.tw:~/public_html/computer_architecture")))

             ("org-computer-arch-static"
                 :base-directory "~/Desktop/NYCU/computer architecture/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif"
                 :recursive t
                 :publishing-function org-publish-attachment
                 :publishing-directory "~/Desktop/NYCU/publish_html/computer_architecture")

             ("org-computer-arch-all"
                 :components ("org-computer-arch-notes" "org-computer-arch-static"))
             )
        org-publish-project-alist))
