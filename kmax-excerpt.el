(defun kmax-split-string (string separator)
 (split-string string separator nil nil))

(defun kmax-pp-string (string)
 ""
 (kmax-edit-temp-file)
 (insert string)
 (pp-buffer)
 (buffer-substring-no-properties)
 (kill-buffer))

(defun kmax-string-match-p (regexp string)
 (string-match-p regexp string))

(defun kmax-edit-temp-file ()
 ""
 (interactive)
 (ffap (make-temp-file "/tmp/kmax-tmp-file-")))
