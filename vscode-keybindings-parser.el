;; from https://github.com/codebling/vs-code-default-keybindings
(setq vscode-mode-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.keybindings.json")
(setq vscode-mode-negative-keybindings-json-file "/var/lib/myfrdcsa/sandbox/vs-code-default-keybindings-20210707/vs-code-default-keybindings-20210707/windows.negative.keybindings.json")

;; from https://github.com/whitphx/vscode-emacs-mcx/blob/7e81757ec668f0aa0d3fb59f4c700fe432d59bc9/package.json
(setq vscode-mode-reverse-keybindings-json-file "/var/lib/myfrdcsa/collaborative/git/vscode-mode/data/keybindings.reverse.json")
(setq vscode-mode-negative-reverse-keybindings-json-file "/var/lib/myfrdcsa/collaborative/git/vscode-mode/data/keybindings.negative.reverse.json")

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


;; (vscode-minor-mode-parse-keybindings-json-file vscode-mode-keybindings-json-file)
;; (vscode-minor-mode-parse-keybindings-json-file vscode-mode-negative-keybindings-json-file)
;; 
;; (vscode-minor-mode-parse-keybindings-json-file-debug vscode-mode-reverse-keybindings-json-file)

(defun compute-reverse-keybindings-inverse ()
 ""
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
 (let ((key (vscode-mode-convert-vscode-style-key-sequence-to-emacs-style-key-sequence (cdr (assoc 'key item))))
       (command (cdr (assoc 'command item)))
       (when (cdr (assoc 'when item)))
       (args (cdr (assoc 'args item))))
  (if (not (string= emacs-style-key-sequence "%"))
   (join " "
    (mapcar
     (lambda (key-combination)
      (join "-"
       (mapcar
	(lambda (individual-key)
	 (or (cdr (assoc individual-key vscode-mode-vscode-style-key-to-emacs-style-key-mapping-alist)) individual-key))
	key-combination)))
     (mapcar (lambda (key) (split-string key "+" nil nil))
      (split-string emacs-style-key-sequence " " nil nil))))
   nil)))
 
;; (compute-reverse-keybindings-inverse)

;; ("ctrl+u" "0" "0" "1" "1" "2" "2" "3" "3" "4" "4" "5" "5" "6" "6" "7" "7" "8" "8" "9" "9" "!" "\"" "#" "$" nil "&" "’" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_" "‘" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~" "space" "enter" "backspace" "right" "ctrl+f" "right" "ctrl+f" "right" "ctrl+f" "left" "ctrl+b" "left" "ctrl+b" "left" "ctrl+b" "up" "ctrl+p" "up" "ctrl+p" "up" "ctrl+p" "up" "ctrl+p" "up" "ctrl+p" "down" "ctrl+n" "down" "ctrl+n" "down" "ctrl+n" "down" "ctrl+n" "down" "ctrl+n" "home" "ctrl+a" "home" "ctrl+a" "home" "ctrl+a" "end" "ctrl+e" "end" "ctrl+e" "end" "ctrl+e" "alt+f" "alt+f" "escape f" "ctrl+[ f" "alt+f" "alt+f" "escape f" "ctrl+[ f" "alt+b" "alt+b" "escape b" "ctrl+[ b" "alt+b" "alt+b" "escape b" "ctrl+[ b" "alt+m" "alt+m" "escape m" "ctrl+[ m" "alt+m" "alt+m" "escape m" "ctrl+[ m" "pagedown" "ctrl+v" "pagedown" "ctrl+v" "pageup" "alt+v" "alt+v" "escape v" "ctrl+[ v" "pageup" "alt+v" "alt+v" "escape v" "ctrl+[ v" "alt+shift+[" "alt+shift+[" "escape shift+[" "ctrl+[ shift+[" "alt+shift+]" "alt+shift+]" "escape shift+]" "ctrl+[ shift+]" "alt+shift+." "alt+shift+." "escape shift+." "ctrl+[ shift+." "alt+shift+." "alt+shift+." "escape shift+." "ctrl+[ shift+." "alt+shift+," "alt+shift+," "escape shift+," "ctrl+[ shift+," "alt+shift+," "alt+shift+," "escape shift+," "ctrl+[ shift+," "alt+g alt+g" "alt+g alt+g" "alt+g g" "alt+g g" "alt+g alt+g" "alt+g alt+g" "alt+g g" "alt+g g" "escape g" "alt+g n" "alt+g n" "alt+g alt+n" "alt+g alt+n" "ctrl+x ‘" "alt+g p" "alt+g p" "alt+g alt+p" "alt+g alt+p" "ctrl+l" "ctrl+s" "ctrl+s" "ctrl+r" "ctrl+r" "alt+shift+5" "alt+shift+5" "escape shift+5" "ctrl+[ shift+5" "ctrl+f" "ctrl+b" "ctrl+p" "ctrl+n" "ctrl+a" "ctrl+e" "alt+f" "alt+b" "alt+m" "ctrl+d" "ctrl+h" "alt+d" "ctrl+k" "ctrl+w" "alt+w" "ctrl+y" "alt+y" "ctrl+m" "ctrl+j" "alt+l" "alt+u" "alt+backspace" "ctrl+f" "ctrl+b" "ctrl+p" "ctrl+n" "ctrl+a" "ctrl+e" "alt+f" "alt+b" "alt+m" "ctrl+d" "ctrl+h" "alt+d" "ctrl+k" "ctrl+w" "alt+w" "ctrl+y" "alt+y" "ctrl+m" "ctrl+j" "alt+l" "alt+u" "alt+backspace" "ctrl+alt+n" "ctrl+alt+n" "escape ctrl+n" "ctrl+[ ctrl+n" "ctrl+alt+p" "ctrl+alt+p" "escape ctrl+p" "ctrl+[ ctrl+p" "ctrl+d" "ctrl+h" "alt+d" "alt+d" "escape d" "ctrl+[ d" "alt+backspace" "alt+backspace" "escape backspace" "ctrl+[ backspace" "ctrl+k" "ctrl+shift+backspace" "ctrl+w" "ctrl+w" "alt+w" "alt+w" "escape w" "ctrl+[ w" "alt+w" "alt+w" "escape w" "ctrl+[ w" "ctrl+y" "ctrl+y" "alt+y" "alt+y" "escape y" "ctrl+[ y" "alt+y" "alt+y" "escape y" "ctrl+[ y" "ctrl+o" "ctrl+o" "ctrl+m" "ctrl+m" "ctrl+j" "ctrl+j" "ctrl+x ctrl+o" "ctrl+x ctrl+o" "ctrl+x h" "ctrl+x h" "ctrl+x u" "ctrl+/" "ctrl+shift+-" "ctrl+x u" "ctrl+/" "ctrl+shift+-" "ctrl+;" "ctrl+;" "alt+;" "alt+;" "escape ;" "ctrl+[ ;" "alt+;" "alt+;" "escape ;" "ctrl+[ ;" "ctrl+x ctrl+l" "alt+l" "alt+l" "escape l" "ctrl+[ l" "ctrl+x ctrl+u" "alt+u" "alt+u" "escape u" "ctrl+[ u" "alt+c" "alt+c" "escape c" "ctrl+[ c" "alt+shift+6" "alt+shift+6" "escape shift+6" "ctrl+[ shift+6" "escape" "escape" "ctrl+g" "ctrl+g" "enter" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+g" "ctrl+space" "ctrl+shift+2" "escape space" "ctrl+x ctrl+x" "ctrl+x space" "ctrl+x r" "k" "y" "d" "alt+w" "alt+w" "escape w" "ctrl+[ w" "o" "c" " " "!" "\"" "#" "$" nil "&" "’" "(" ")" "*" "+" "," "-" "." "/" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ":" ";" "<" "=" ">" "?" "@" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_" "‘" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~" "ctrl+’" "ctrl+’" "alt+/" "alt+/" "escape /" "ctrl+[ /" "alt+/" "alt+/" "escape /" "ctrl+[ /" "alt+x" "alt+x" "escape x" "ctrl+[ x" "ctrl+alt+space" "ctrl+alt+space" "escape ctrl+space" "ctrl+[ ctrl+space" "ctrl+x ctrl+c" "ctrl+x z" "ctrl+x ctrl+f" "ctrl+x ctrl+s" "ctrl+x ctrl+w" "ctrl+x s" "ctrl+x ctrl+n" "ctrl+x b" "ctrl+x k" "ctrl+x ctrl-k" "ctrl+x 0" "ctrl+x 1" "ctrl+x 2" "ctrl+x 3" "ctrl+x 4" "ctrl+x o" "ctrl+alt+f" "ctrl+alt+f" "escape ctrl+f" "ctrl+[ ctrl+f" "ctrl+alt+b" "ctrl+alt+b" "escape ctrl+b" "ctrl+[ ctrl+b" "ctrl+alt+k" "ctrl+alt+k" "escape ctrl+k" "ctrl+[ ctrl+k" "ctrl+p" "ctrl+n" "ctrl+p" "ctrl+n" "ctrl+m" "ctrl+shift+’" "ctrl+x j" "ctrl+i")

;; VVVVV

;; ("C-u" "0" "0" "1" "1" "2" "2" "3" "3" "4" "4" "5" "5" "6" "6" "7" "7" "8" "8" "9" "9" "!" "\"" "#" "$" nil "&" "’" "(" ")" "*" "-" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_" "‘" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~" "SPC" "RET" "DEL" "right" "C-f" "right" "C-f" "right" "C-f" "left" "C-b" "left" "C-b" "left" "C-b" "<up>" "C-p" "<up>" "C-p" "<up>" "C-p" "<up>" "C-p" "<up>" "C-p" "<down>" "C-n" "<down>" "C-n" "<down>" "C-n" "<down>" "C-n" "<down>" "C-n" "home" "C-a" "home" "C-a" "home" "C-a" "end" "C-e" "end" "C-e" "end" "C-e" "M-f" "M-f" "ESC f" "C-[ f" "M-f" "M-f" "ESC f" "C-[ f" "M-b" "M-b" "ESC b" "C-[ b" "M-b" "M-b" "ESC b" "C-[ b" "M-m" "M-m" "ESC m" "C-[ m" "M-m" "M-m" "ESC m" "C-[ m" "" "C-v" "" "C-v" "" "M-v" "M-v" "ESC v" "C-[ v" "" "M-v" "M-v" "ESC v" "C-[ v" "M-S-[" "M-S-[" "ESC S-[" "C-[ S-[" "M-S-]" "M-S-]" "ESC S-]" "C-[ S-]" "M-S-." "M-S-." "ESC S-." "C-[ S-." "M-S-." "M-S-." "ESC S-." "C-[ S-." "M-S-," "M-S-," "ESC S-," "C-[ S-," "M-S-," "M-S-," "ESC S-," "C-[ S-," "M-g M-g" "M-g M-g" "M-g g" "M-g g" "M-g M-g" "M-g M-g" "M-g g" "M-g g" "ESC g" "M-g n" "M-g n" "M-g M-n" "M-g M-n" "C-x ‘" "M-g p" "M-g p" "M-g M-p" "M-g M-p" "C-l" "C-s" "C-s" "C-r" "C-r" "M-S-5" "M-S-5" "ESC S-5" "C-[ S-5" "C-f" "C-b" "C-p" "C-n" "C-a" "C-e" "M-f" "M-b" "M-m" "C-d" "C-h" "M-d" "C-k" "C-w" "M-w" "C-y" "M-y" "C-m" "C-j" "M-l" "M-u" "M-DEL" "C-f" "C-b" "C-p" "C-n" "C-a" "C-e" "M-f" "M-b" "M-m" "C-d" "C-h" "M-d" "C-k" "C-w" "M-w" "C-y" "M-y" "C-m" "C-j" "M-l" "M-u" "M-DEL" "C-M-n" "C-M-n" "ESC C-n" "C-[ C-n" "C-M-p" "C-M-p" "ESC C-p" "C-[ C-p" "C-d" "C-h" "M-d" "M-d" "ESC d" "C-[ d" "M-DEL" "M-DEL" "ESC DEL" "C-[ DEL" "C-k" "C-S-DEL" "C-w" "C-w" "M-w" "M-w" "ESC w" "C-[ w" "M-w" "M-w" "ESC w" "C-[ w" "C-y" "C-y" "M-y" "M-y" "ESC y" "C-[ y" "M-y" "M-y" "ESC y" "C-[ y" "C-o" "C-o" "C-m" "C-m" "C-j" "C-j" "C-x C-o" "C-x C-o" "C-x h" "C-x h" "C-x u" "C-/" "C-S--" "C-x u" "C-/" "C-S--" "C-;" "C-;" "M-;" "M-;" "ESC ;" "C-[ ;" "M-;" "M-;" "ESC ;" "C-[ ;" "C-x C-l" "M-l" "M-l" "ESC l" "C-[ l" "C-x C-u" "M-u" "M-u" "ESC u" "C-[ u" "M-c" "M-c" "ESC c" "C-[ c" "M-S-6" "M-S-6" "ESC S-6" "C-[ S-6" "ESC" "ESC" "C-g" "C-g" "RET" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-g" "C-SPC" "C-S-2" "ESC SPC" "C-x C-x" "C-x SPC" "C-x r" "k" "y" "d" "M-w" "M-w" "ESC w" "C-[ w" "o" "c" " " "!" "\"" "#" "$" nil "&" "’" "(" ")" "*" "-" "," "-" "." "/" "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ":" ";" "<" "=" ">" "?" "@" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_" "‘" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~" "C-’" "C-’" "M-/" "M-/" "ESC /" "C-[ /" "M-/" "M-/" "ESC /" "C-[ /" "M-x" "M-x" "ESC x" "C-[ x" "C-M-SPC" "C-M-SPC" "ESC C-SPC" "C-[ C-SPC" "C-x C-c" "C-x z" "C-x C-f" "C-x C-s" "C-x C-w" "C-x s" "C-x C-n" "C-x b" "C-x k" "C-x ctrl-k" "C-x 0" "C-x 1" "C-x 2" "C-x 3" "C-x 4" "C-x o" "C-M-f" "C-M-f" "ESC C-f" "C-[ C-f" "C-M-b" "C-M-b" "ESC C-b" "C-[ C-b" "C-M-k" "C-M-k" "ESC C-k" "C-[ C-k" "C-p" "C-n" "C-p" "C-n" "C-m" "C-S-’" "C-x j" "C-i")

(defun vscode-mode-convert-vscode-style-key-sequence-to-emacs-style-key-sequence (key-sequence)
 key-sequence)

(provide 'vscode-keybindings-parser)
