;;; test.el -*- lexical-binding: t; -*-
;; Put this somewhere in your ~/.config/doom/config.el
(defun my/org-agenda-todo-count ()
  "Count all TODO items across your Org agenda files."
  (interactive)
  (let ((files org-agenda-files) ; Correct variable access
        (count 0))
    ;; Check if org-agenda-files is actually set before proceeding
    (if (listp files)
        (dolist (file files)
          (when (and file (stringp file) (file-exists-p file)) ; Add check file is string and exists
             (with-temp-buffer
               (ignore-errors ; Ignore errors from files that can't be read/parsed
                 (insert-file-contents file)
                 ;; Go to beginning of buffer to ensure search starts there
                 (goto-char (point-min))
                 ;; Use re-search-forward within a loop properly
                 (while (re-search-forward "^[ \t]*\\*+ +\\(TODO\\|NEXT\\|WAITING\\)" nil t)
                   (setq count (1+ count)))))))
      (message "Warning: org-agenda-files is not a list or is empty."))
    (message "Total TODO count: %d" count)
    count))
