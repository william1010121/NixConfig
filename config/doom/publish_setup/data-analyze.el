;; org-publish-data-analyze.el

(setq org-publish-project-alist
    (append
        '(
             ("org-data-ana-notes"
                 :base-extension "org"
                 :recursive t
                 :headline-levels 4
                 :section-numbers nil
                 :with-toc t
                 :html-link-home "./"
                 :html-link-up "./"
                 :base-directory "~/Desktop/NYCU/Data analzye/"  ; ensure this path is correct
                 :publishing-directory "~/Desktop/NYCU/publish_html/Numeric"
                 :publishing-function org-html-publish-to-html
                 :completion-function (lambda (project)
                                          (shell-command "rsync -av ~/Desktop/NYCU/publish_html/Numeric/ guosw@linux1.cs.nycu.edu.tw:~/public_html/Numeric")))

             ("org-data-ana-static"
                 :base-directory "~/Desktop/NYCU/Data analzzye/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif"
                 :recursive t
                 :publishing-function org-publish-attachment
                 :publishing-directory "~/Desktop/NYCU/publish_html/Numeric")

             ("org-data-all"
                 :components ("org-data-ana-notes" "org-data-ana-static"))
             )
        org-publish-project-alist))
