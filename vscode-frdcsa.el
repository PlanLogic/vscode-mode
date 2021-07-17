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

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
   (buffer-string)))

(defun see (data &optional duration)
 ""
 (interactive)
 (message (prin1-to-string data))
 (sit-for (if duration duration 2.0))
 data)

(defun non-nil (arg)
 (if (symbolp arg)
  (and (boundp arg)
   (not (equal arg nil)))
  t))

(defun join (separator list)
  "Same as Perl join"
  (setq value "")
  (let* ((first nil)
	 (value
	  (dolist (elt list value)
	    (setq value (concat value (if first separator "") elt))
	    (setq first t))))
    value))

(defmacro shift (place)
 "Remove and return the head of the list stored in PLACE.
Analogous to (prog1 (car PLACE) (setf PLACE (cdr PLACE))), though more
careful about evaluating each argument only once and in the right order.
PLACE may be a symbol, or any generalized variable allowed by `setf'."
 (if (symbolp place)
  (list 'car 
   (list 'prog1 
    (list 'reverse place) 
    (list 'setq place 
     (list 'reverse 
      (list 'cdr 
       (list 'reverse place))))))))
