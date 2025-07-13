;;; publish_setup/common-config.el -*- lexical-binding: t; -*-

;; common-config.el
(setq my-org-html-common
      '(:base-extension "org"
        :recursive t
        :headline-levels 4
        :section-numbers nil
        :with-toc t
        :html-link-home "./"
        :html-link-up "./"))

(setq my-static-common
      '(:base-extension "css\\|js\\|png\\|jpg\\|gif"
        :recursive t
        :publishing-function org-publish-attachment))

(provide 'common-config)
