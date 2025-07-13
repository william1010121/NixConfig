;;; publish_setup/org-publish-digital-system.el -*- lexical-binding: t; -*-
;; org-publish-digital-system.el
(setq org-publish-project-alist
    (append
        '(
             ("org-information-theory-notes"
                 :recursive t
                 :headline-levels 4
                 :section-numbers nil
                 :with-toc t
                 :html-link-home "./"
                 :html-link-up "./"
                 :base-directory "~/Desktop/NYCU/Information Theory/"  ; ensure this path is correct
                 :publishing-directory "~/Desktop/NYCU/publish_html/Information_Theory"
                 :publishing-function org-html-publish-to-html
                 :completion-function (lambda (project)
                                          (shell-command "rsync -av ~/Desktop/NYCU/publish_html/Information_Theory/ guosw@linux1.cs.nycu.edu.tw:~/public_html/Information_Theory")))

             ("org-information-theory-static"
                 :base-directory "~/Desktop/NYCU/Information Theory/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg"
                 :recursive t
                 :publishing-function org-publish-attachment
                 :publishing-directory "~/Desktop/NYCU/publish_html/Information_Theory")

             ("org-information-all"
                 :components ("org-information-theory-notes" "org-information-theory-static"))
             )
        org-publish-project-alist))
