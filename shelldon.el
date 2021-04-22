(defvar shelldon-nth 0)
(defvar shelldon-hist '())
(defun shelldon (command &optional output-buffer error-buffer)
  (interactive "sEnter command: ")
  (setq output-buffer (concat " *" (number-to-string shelldon-nth) ":" command "*"))
  (setq shelldon-nth (+ shelldon-nth 1))
  (add-to-list 'shelldon-hist `(,(concat (number-to-string shelldon-nth) ":" command) . ,output-buffer))
  (shell-command command output-buffer error-buffer)
  (with-current-buffer output-buffer (buffer-string)))

(defun shelldon-loop ()
  (interactive)
  (call-interactively 'shelldon)
  (call-interactively 'shelldon-loop))

(defun shelldon-hist ()
  (interactive)
  (switch-to-buffer (cdr (assoc (completing-read ">> " shelldon-hist) shelldon-hist))))

(provide 'shelldon)
