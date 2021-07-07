(global-set-key "\C-cv" 'global-vscode-mode)

(defun vscode-minor-mode-on ()
 ""
 (interactive)
 (vscode-minor-mode 1))

(defun vscode-minor-mode-off ()
 ""
 (interactive)
 (vscode-minor-mode 0))

(define-globalized-minor-mode global-vscode-mode vscode-minor-mode vscode-minor-mode-on)

(defvar vscode-minor-mode-map
 (let ((map (make-sparse-keymap)))
  ;; Toggle between text and image display or editing
  (define-key map "\C-z" 'undo)
  (define-key map [f1] 'help)
  (define-key map (kbd "M-<f4>") 'save-buffers-kill-terminal)
  (define-key map "\M-fx" 'save-buffers-kill-terminal)
  map)
 "Keymap used by `doc-minor-view-mode'.")

(define-minor-mode vscode-minor-mode
 "VSCode buffer local compatibility mode for using VSCode bindings in Emacs.
\\{vscode-mode-map}"
 nil " VSC" vscode-minor-mode-map
 :group 'vscode
 )

;; cua-mode

(provide 'vscode-mode)
