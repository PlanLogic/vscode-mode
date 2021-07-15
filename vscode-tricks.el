;; ;; FROM: https://stackoverflow.com/questions/29165886/how-to-bind-ctrl-home-and-ctrl-end-to-beginning-end-of-buffer-in-emacs?rq=1

;; optional but gives a symbolic name which may be easier to work with
;; and allow modes which may already know about C-home to take advantage
;; of the binding
(if (not key-translation-map)
 (setq key-translation-map (make-sparse-keymap)))
(define-key key-translation-map "\e[1;5~" [C-home])

;; bind the key (or check before if the default binding isn't suitable)
(global-set-key [(control home)] 'beginning-of-buffer)

;;;;;;;;

(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)


;; ;; FROM: https://emacs.stackexchange.com/questions/10177/how-to-bind-ctrl-home-and-ctrl-end-to-beginning-end-of-buffer-in-emacs/10181#10181

;; Notes:
;; * PuTTY doesn't send control characters for CTRL-<home> or CTRL-<end> so there's
;;   no way to make those key combinations work in character mode Emacs launched from
;;   a PuTTY terminal.  Character mode Emacs will work if launched from an xterm
;;   though and X mode Emacs launched from PuTTY will work too.
;; * Also, PuTTY mis-maps the <end> key to <select>

;; Make CTRL-<home>/<end> work like in Windows.
;; X mode Emacs or character mode Emacs launched from xterm only.
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)     ;; Works in X, not in PuTTY 
(global-set-key (kbd "C-<select>") 'end-of-buffer)  ;; For PuTTY

;; Make <home>/<end> work like in Windows
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)         ;; Works in X, not in PuTTY
(global-set-key (kbd "<select>") 'end-of-line)      ;; For PuTTY


;; ;; FROM: https://stackoverflow.com/questions/4666510/emacs-keybind-questions?rq=1

;; FIXME


;; ;; FROM: https://stackoverflow.com/questions/4146574/how-to-properly-configure-ctrl-tab-in-emacs?rq=1

;; FIXME


;; ;; FROM: https://stackoverflow.com/questions/31251574/emacs-goto-line-quits-instead-of-going-to-a-line

;; FIXME


;; ;; FROM: https://emacs.stackexchange.com/questions/53461/specifying-a-binding-for-control-shift-tab

;; FIXME
