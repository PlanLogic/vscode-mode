;; (defvar global-vscode-mode-on nil)
;; (defvar vscode-mode-on nil)

;; (defun global-vscode ()
;;  ""
;;  (interactive)
;;  (if global-vscode-mode-on
;;   (if (not (derived-mode-p 'global-vscode-mode))
;;    (progn 
;;     (global-vscode-helper)))))

;; (defun global-vscode-helper (&optional arg-arg)
;;  ""
;;  (interactive)
;;  (let* ((arg (or arg-arg 1)))
;;   (if (= arg 1)
;;    (progn
;;     (setq global-vscode-mode-on t)
;;     (xterm-mouse-mode 1))
;;    (progn
;;     (setq global-vscode-mode-on nil)
;;     (xterm-mouse-mode 0)))))

(defun vscode-mode-on ()
 (interactive)
 (vscode-mode 1))

;; (defun global-vscode-mode-off ()
;;  (interactive)
;;  (global-vscode-helper 0))

;; (defun vscode ()
;;  ""
;;  (interactive)
;;  (if vscode-mode-on
;;   (if (derived-mode-p 'vscode-mode)
;;    (vscode-mode -1))
;;   (if (not (derived-mode-p 'vscode-mode))
;;    (progn 
;;     (vscode-mode)
;;     ))))

(define-globalized-minor-mode global-vscode-mode vscode-mode vscode-mode-on)

(define-derived-mode vscode-mode
 cua-mode "VSCode"
 "VSCode buffer local compatibility mode for using VSCode bindings in Emacs.
\\{vscode-mode-map}"
 (cond
  (vscode-mode
   (setq case-fold-search nil)
   (define-key vscode-mode-map "\C-z" 'undo)
   (define-key vscode-mode-map [f1] 'help)
   (define-key vscode-mode-map (kbd "M-<f4>") 'save-buffers-kill-terminal)
   (define-key vscode-mode-map "\M-fx" 'save-buffers-kill-terminal)
   )
  (nil
   (cua-mode 0)
   )))

;; (defun vscode-define-keys-for-mode (mode)
;;  (define-key mode "" 'vscode-mode-)
;;  )

(provide 'vscode-compat)

