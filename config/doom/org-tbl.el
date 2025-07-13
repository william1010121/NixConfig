;;; orgtbl-latex-integration.el --- Easily use org tables in LaTeX matrices

;;; Commentary:
;; This package provides functions to easily create and manage org tables
;; that are automatically converted to LaTeX matrices.

;;; Code:
(require 'org)
(require 'org-table)

(defcustom orgtbl-latex-cache-file
  (expand-file-name ".tables-cache.org" default-directory)
  "File to store org tables for LaTeX matrices.
Will be stored as a hidden file in the current directory."
  :type 'file
  :group 'orgtbl-latex)

(defun orgtbl-latex-ensure-cache-file ()
  "Ensure the tables cache file exists in the current directory."
  ;; Update the cache file path to current directory
  (setq orgtbl-latex-cache-file (expand-file-name ".tables-cache.org" default-directory))
  (unless (file-exists-p orgtbl-latex-cache-file)
    (with-temp-file orgtbl-latex-cache-file
      (insert "#+TITLE: Org Tables Cache for LaTeX\n\n"))))

(defun orgtbl-latex-generate-id ()
  "Generate a random ID for a table."
  (format "tbl-%s" (format-time-string "%Y%m%d%H%M%S")))

(defun orgtbl-latex-insert-matrix (id)
  "Insert a LaTeX matrix environment with org table conversion for ID."
  (interactive "sEnter table ID (or leave empty for random ID): ")
  (let ((table-id (if (string-empty-p id) (orgtbl-latex-generate-id) id))
        (buf-name (buffer-name)))
    (insert (format "%%BEGIN RECEIVE ORGTBL %s\n\\begin{matrix}\n\\end{matrix}\n%%END RECEIVE ORGTBL %s"
                    table-id table-id))
    ;; Save buffer to ensure file exists when referenced in SEND directive
    (when (buffer-file-name)
      (save-buffer))
    (orgtbl-latex-edit-table table-id)))

(defun orgtbl-latex-setup-math-mode ()
  "Set up the buffer to enable math editing features."
  (when (featurep 'cdlatex)
    (cdlatex-mode 1))

  (when (featurep 'yasnippet)
    (yas-minor-mode 1))

  ;; Enable orgtbl-mode to ensure table editing works
  (orgtbl-mode 1)

  ;; Set a variable to indicate this is a LaTeX math context
  (setq-local orgtbl-latex-math-context t))

(defun orgtbl-latex-edit-table (id)
  "Edit or create an org table with ID in the cache file."
  (interactive "sEnter table ID to edit: ")
  (orgtbl-latex-ensure-cache-file)
  (let ((buffer (find-file-noselect orgtbl-latex-cache-file))
        (table-exists nil)
        (buffer-read-only nil)
        (source-buffer (current-buffer)))

    ;; Check if table already exists
    (with-current-buffer buffer
      (goto-char (point-min))
      (setq table-exists (re-search-forward (format "^#\\+ORGTBL: SEND %s " (regexp-quote id)) nil t)))

    ;; If table doesn't exist, create it
    (unless table-exists
      (with-current-buffer buffer
        (goto-char (point-max))
        (unless (bolp) (insert "\n"))
        (insert (format "\n#+ORGTBL: SEND %s orgtbl-to-latex :tstart \"\\\\begin{matrix}\" :tend \"\\\\end{matrix}\" :buffer \"%s\"\n"
                        id (buffer-name source-buffer)))
        (insert "| | | |\n|-+-+-|\n| | | |\n")))

    ;; Switch to the buffer and position cursor
    (switch-to-buffer buffer)

    ;; Enable math editing features
    (orgtbl-latex-setup-math-mode)

    ;; Position cursor at the table
    (goto-char (point-min))
    (re-search-forward (format "^#\\+ORGTBL: SEND %s " (regexp-quote id)) nil t)
    (forward-line 1)
    (org-table-goto-column 1)
    (message "Edit the table and press C-c C-c to update the LaTeX matrix. C-c t u to force update all tables.")))

(defun orgtbl-latex-find-matrix ()
  "Find the LaTeX matrix environment at point and extract its ID."
  (save-excursion
    (when (re-search-backward "%BEGIN RECEIVE ORGTBL \\([^ \t\n]+\\)" nil t)
      (match-string-no-properties 1))))

(defun orgtbl-latex-edit-current-matrix ()
  "Edit the org table corresponding to the LaTeX matrix at point."
  (interactive)
  (let ((id (orgtbl-latex-find-matrix)))
    (if id
        (orgtbl-latex-edit-table id)
      (message "No LaTeX matrix found at point."))))

(defun orgtbl-latex-quick-matrix ()
  "Quickly create a new matrix with a random ID."
  (interactive)
  (orgtbl-latex-insert-matrix ""))

(defun orgtbl-latex-apply-changes ()
  "Apply table changes to all matrices in the current buffer."
  (interactive)
  (save-buffer)
  (let ((original-buffer (current-buffer)))
    (with-current-buffer original-buffer
      (org-table-map-tables 'orgtbl-send-table))
    ;; Force update in all org buffers
    (orgtbl-latex-update-receive-locations)
    (message "All tables updated and sent to their destinations.")))

;; Fix for cross-buffer SEND/RECEIVE
(defun orgtbl-latex-update-receive-locations ()
  "Update all RECEIVE locations for tables in all open org buffers."
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'org-mode)
          (org-table-map-tables 'orgtbl-send-table)
          (org-ctrl-c-ctrl-c))))))

;; Define keybindings
(defvar orgtbl-latex-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c t i") 'orgtbl-latex-insert-matrix)
    (define-key map (kbd "C-c t e") 'orgtbl-latex-edit-current-matrix)
    (define-key map (kbd "C-c t n") 'orgtbl-latex-quick-matrix)
    (define-key map (kbd "C-c t a") 'orgtbl-latex-apply-changes)
    (define-key map (kbd "C-c t u") 'orgtbl-latex-update-receive-locations)
    map)
  "Keymap for orgtbl-latex-mode.")

;; Advice to enhance orgtbl-mode with math features when in our special buffer
(defun orgtbl-latex-maybe-enable-math (orig-fun &rest args)
  "Advice to enable math features in orgtbl when appropriate."
  (let ((result (apply orig-fun args)))
    (when (and (boundp 'orgtbl-latex-math-context) orgtbl-latex-math-context)
      (orgtbl-latex-setup-math-mode))
    result))

(advice-add 'orgtbl-mode :around #'orgtbl-latex-maybe-enable-math)

;;;###autoload
(define-minor-mode orgtbl-latex-mode
  "Minor mode for easily using org tables in LaTeX matrices."
  :lighter " OrgLaTeX"
  :keymap orgtbl-latex-mode-map
  (when orgtbl-latex-mode
    (message "OrgTbl LaTeX mode enabled. Use C-c t i to insert a matrix, C-c t e to edit, C-c t n for quick matrix, C-c t u to force update.")))

(provide 'orgtbl-latex-integration)
;;; orgtbl-latex-integration.el ends here
