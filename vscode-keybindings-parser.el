;; from https://github.com/codebling/vs-code-default-keybindings
(setq vscode-mode-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.keybindings.json")
(setq vscode-mode-negative-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.negative.keybindings.json")

;; (require 'json)
(load "/usr/share/emacs/26.1/lisp/json.el.gz")

(defun vscode-minor-mode-parse-keybindings-json-file-debug ()
 ""
 (let ((json (get-string-from-file vscode-mode-keybindings-json-file)))
  (kmax-edit-temp-file)
  (insert json)
  (insert "\n")
  (beginning-of-buffer)
  (see (json-read))))

(defun vscode-minor-mode-parse-keybindings-json-file (file)
 ""
 (let ((json (get-string-from-file file)))
  (see (json-read-from-string (concat json "\n")))))

;; (vscode-minor-mode-parse-keybindings-json-file vscode-mode-keybindings-json-file)
;; (vscode-minor-mode-parse-keybindings-json-file vscode-mode-negative-keybindings-json-file)

(provide 'vscode-keybindings-parser)
