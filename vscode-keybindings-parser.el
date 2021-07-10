;; from https://github.com/codebling/vs-code-default-keybindings
(setq vscode-mode-forward-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.keybindings.json")
(setq vscode-mode-forward-negative-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.negative.keybindings.json")

;; from https://github.com/whitphx/vscode-emacs-mcx/blob/7e81757ec668f0aa0d3fb59f4c700fe432d59bc9/package.json
(setq vscode-mode-reverse-keybindings-json-file "/var/lib/myfrdcsa/collaborative/git/vscode-mode/data/keybindings.reverse.json")
(setq vscode-mode-reverse-negative-keybindings-json-file "/var/lib/myfrdcsa/collaborative/git/vscode-mode/data/keybindings.negative.reverse.json")

;; forward VSCode Keybindings -> VSCode Commands
;; reverse Emacs Keybindings -> VSCode Commands

(defvar vscode-mode-forward-keybindings-json-parse nil "")
(defvar vscode-mode-reverse-keybindings-json-parse nil "")

;; (require 'json)
(load "/usr/share/emacs/26.1/lisp/json.el.gz")

(defun vscode-minor-mode-parse-keybindings-json-file-debug (file)
 ""
 (let ((json (get-string-from-file file)))
  (kmax-edit-temp-file)
  (insert json)
  (insert "\n")
  (beginning-of-buffer)
  (json-read)))



(defun vscode-minor-mode-parse-key-sequences-json-file (file)
 ""
 (let ((json (get-string-from-file file)))
  (json-read-from-string (concat json "\n"))))

(defun compute-forward-keybindings ()
 ""
 (see-if "Start" 0.0)
 (setq vscode-mode-forward-keybindings-json-parse
  (vscode-minor-mode-parse-key-sequences-json-file vscode-mode-forward-keybindings-json-file))
 (see (mapcar (lambda (item) (vscode-mode-reverse-key-sequence item)) vscode-mode-forward-keybindings-json-parse)))

(defun compute-reverse-keybindings ()
 ""
 (see-if "Start" 0.0)
 (setq vscode-mode-reverse-keybindings-json-parse
  (vscode-minor-mode-parse-key-sequences-json-file vscode-mode-reverse-keybindings-json-file))
 (see (mapcar (lambda (item) (vscode-mode-reverse-key-sequence item)) vscode-mode-reverse-keybindings-json-parse)))

;; (defvar vscode-mode-vscode-style-key-to-emacs-style-key-mapping-alist
(setq vscode-mode-vscode-style-key-to-emacs-style-key-mapping-alist
 '(
   ("ctrl" . "C")
   ("alt" . "M")
   ("shift" . "S")
   ("backspace" . "DEL")
   ("escape" . "ESC")
   ("pageup" . "")
   ("pagedown" . "")
   ("enter" . "RET")
   ("space" . "SPC")
   ;; ("tab" . "TAB")
   ("up" . "<up>")
   ("down" . "<down>")
   ))

(defun vscode-mode-reverse-key-sequence (item)
 ""
 ;; (see key-sequence)
 (let ((key (cdr (assoc 'key item)))
       (command (cdr (assoc 'command item)))
       (when (cdr (assoc 'when item)))
       (args (cdr (assoc 'args item))))
  (if (not (string= key "%"))
   (list
    (cons
     (vscode-mode-parse-vscode-style-key key)
     (list
      (cons
       'command
       (vscode-mode-parse-vscode-style-command command))
      (cons 'when-orig when)
      (cons 'when 
       (vscode-mode-parse-vscode-style-when when)))))      
   nil)))
 
(defun vscode-mode-parse-vscode-style-key (key)
 ""
 (join " "
     (mapcar
      (lambda (key-combination)
       (join "-"
	(mapcar
	 (lambda (individual-key)
	  (or (cdr (assoc individual-key vscode-mode-vscode-style-key-to-emacs-style-key-mapping-alist)) individual-key))
	 key-combination)))
      (mapcar (lambda (key) (split-string key "+" nil nil))
       (split-string key " " nil nil)))))

(defun vscode-mode-parse-vscode-style-command (command)
 (if command
  (list (make-symbol (concat "vscode-mode-command/" command)))))

(defun vscode-mode-parse-vscode-style-when (when)
 ""
 (if when
  (vscode-mode-parse-vscode-style-when-or when)
  nil))

;; (defun vscode-mode-parse-vscode-style-when-or (disjuncts)
;;  ""
;;  (if disjuncts
;;   (let ((result (mapcar #'vscode-mode-parse-vscode-style-when-and (kmax-split-string disjuncts " \|\| "))))
;;    (cons 'or result))))

;; (defun vscode-mode-parse-vscode-style-when-and (conjuncts)
;;  ""
;;  (if conjuncts
;;   (let ((result (mapcar #'vscode-mode-parse-vscode-style-when-expr (kmax-split-string conjuncts " \&\& "))))
;;    (cons 'and result))))

(defun vscode-mode-parse-vscode-style-when-or (disjuncts)
 ""
 (if disjuncts
  (let ((result (mapcar #'vscode-mode-parse-vscode-style-when-and (kmax-split-string disjuncts " \|\| "))))
   (if (= (length result) 1) (car result) (cons 'or result)))))

(defun vscode-mode-parse-vscode-style-when-and (conjuncts)
 ""
 (if conjuncts
  (let ((result (mapcar #'vscode-mode-parse-vscode-style-when-expr (kmax-split-string conjuncts " \&\& "))))
   (if (= (length result) 1) result (cons 'and result)))))

(setq do-see nil)
;; (setq do-see t)

(defun see-if (item &optional duration)
 ""
 (if do-see (progn (see item (if duration duration 0.0)) item) item))

(defun vscode-mode-parse-vscode-style-when-expr (expr)
 ""
 (if expr
  (progn
   (if (not (kmax-string-match-p " =~ " expr)) (see-if (concat "Expr: " expr) 0.0))
   (see-if 0 0.0)
   (see-if
    (or
     ;; empty quotation
     (and (kmax-string-match-p "^'\\(.*\\)'$" expr) (progn (see-if 1 0.0) (match-string 1 expr)))

     ;; literal
     (and (kmax-string-match-p "^[-0-9a-zA-Z\\.]+$" expr) (progn (see-if 2 0.0) (vscode-mode-parse-vscode-style-when-literal expr)))

     ;; not
     (and (kmax-string-match-p "^\\!\\([-0-9a-zA-Z\\.]+\\)$" expr) (list 'not (vscode-mode-parse-vscode-style-when-literal (progn (see-if 3 0.0) (match-string 1 expr)))))

     ;; regex
     (and (kmax-string-match-p " =~ " expr) (cons 'string-match (car (mapcar (lambda (my-list) (progn (see-if 4 0.0) (list (vscode-mode-parse-vscode-style-when-expr (car my-list)) (vscode-mode-parse-vscode-style-when-regex (cadr my-list)) nil nil))) (list (kmax-split-string expr " =~ "))))))

     ;; equals
     (and (kmax-string-match-p " == " expr) (cons 'equal (car (mapcar (lambda (my-list) (progn (see-if 5 0.0) (list (vscode-mode-parse-vscode-style-when-expr (car my-list)) (vscode-mode-parse-vscode-style-when-expr (cadr my-list))))) (list (kmax-split-string expr " == "))))))

     ;; not equals
     (and (kmax-string-match-p " != " expr) (list 'not (cons 'equal (car (mapcar (lambda (my-list) (progn (see-if 6 0.0) (list (vscode-mode-parse-vscode-style-when-expr (car my-list)) (vscode-mode-parse-vscode-style-when-expr (cadr my-list))))) (list (kmax-split-string expr " != ")))))))

     nil
     )
    0.0))))

(defun vscode-mode-parse-vscode-style-when-literal (literal)
 ""
 (if literal
  (list (make-symbol (concat "vscode-mode-cond/" literal)))))

(setq x 0)

(defun vscode-mode-parse-vscode-style-when-regex (regex)
 (kmax-string-match-p "^/\\(.+\\)/$" regex)
 (setq x (+ x 1))
 (let ((chars (split-string regex "" nil nil)))
  (pop chars)
  (shift chars)
  (join "" chars)))

(defun vscode-mode-keybindings-parser-test ()
 ""
 (interactive)
 (progn (kmax-pp-string (prin1-to-string (compute-forward-keybindings))) (emacs-lisp-mode)))

;; (vscode-mode-keybindings-parser-test)

;; now compute 
(defun vscode-mode-compute-vscode-style-keybindings ()
 ""
 (let ((forward-keybindings (compute-forward-keybindings))
       (reverse-keybindings (compute-reverse-keybindings))))
 )

(provide 'vscode-keybindings-parser)
