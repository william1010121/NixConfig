;;; publish_setup/org-publish-digital-system.el -*- lexical-binding: t; -*-
;; org-publish-digital-system.el
(setq org-publish-project-alist
    (append
        '(
             ("org-digital-sys-notes"
                 :recursive t
                 :headline-levels 4
                 :section-numbers nil
                 :with-toc t
                 :html-link-home "./"
                 :html-link-up "./"
                 :base-directory "~/Desktop/NYCU/digital_system/"  ; ensure this path is correct
                 :publishing-directory "~/Desktop/NYCU/publish_html/digital_system"
                 :publishing-function org-html-publish-to-html
                 :completion-function (lambda (project)
                                          (shell-command "rsync -av ~/Desktop/NYCU/publish_html/digital_system/ guosw@linux1.cs.nycu.edu.tw:~/public_html/digital_system")))

             ("org-digital-sys-static"
                 :base-directory "~/Desktop/NYCU/digital_system/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif"
                 :recursive t
                 :publishing-function org-publish-attachment
                 :publishing-directory "~/Desktop/NYCU/publish_html/digital_system")

             ("org-digital-all"
                 :components ("org-digital-sys-notes" "org-digital-sys-static"))
             )
        org-publish-project-alist))
