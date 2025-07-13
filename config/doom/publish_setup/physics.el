;; org-publish-physics.el

(setq org-publish-project-alist
    (append
        '(
             ("org-physics-notes"
                 :base-extension "org"
                 :recursive t
                 :headline-levels 4
                 :section-numbers nil
                 :with-toc t
                 :html-link-home "./"
                 :html-link-up "./"
                 :base-directory "~/Desktop/NYCU/Physic/"  ; ensure this path is correct
                 :publishing-directory "~/Desktop/NYCU/publish_html/Physic"
                 :publishing-function org-html-publish-to-html
                 :completion-function (lambda (project)
                                          (shell-command "rsync -av ~/Desktop/NYCU/publish_html/Physic/ guosw@linux1.cs.nycu.edu.tw:~/public_html/Physic")))

             ("org-physics-static"
                 :base-directory "~/Desktop/NYCU/Physic/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif"
                 :recursive t
                 :publishing-function org-publish-attachment
                 :publishing-directory "~/Desktop/NYCU/publish_html/Physic")

             ("org-physics-all"
                 :components ("org-physics-notes" "org-physics-static"))
             )
        org-publish-project-alist))
