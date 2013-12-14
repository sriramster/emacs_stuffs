;;; My elisp functions in startup

;; Toggle 
(defun flip-xclip-behaviour () 
  "Toggle between X window clipboard behaviour"
  "One of the states clipboard is shared between (xterm/aterm/rxvt) and emacs"
  "and the other has gtk and newer clients in place of *terms"
  (interactive) 
  (setq x-select-enable-clipboard (not x-select-enable-clipboard))
  (let ((bang "")) 
    (if x-select-enable-clipboard (setq bang "true") (setq bang "false"))
    (message "x-select-enable-clipboard set to %s" bang)))

;; Functions for this and that
(defun kill-after-client-close ()
  "Kill Buffer after closing emacs client connection"
  (interactive)
  (progn (setq bogie (current-buffer))
	 (if (and (boundp 'server-buffer-clients)
		  server-buffer-clients)
	     (server-edit))
	 (kill-buffer bogie)))

;; Add multi-part
(defun add-mp () 
  "Duplicate the message to add html version as alternative"
  (interactive)
  (let ((sig-empty-line message-signature-insert-empty-line) (body-start (point-min)))
    (message-goto-body)
    (setq body-start (point))
    (message-goto-signature)
    (unless (eobp)
      (forward-line -1))
    (unless (= body-start (point))
      (setq body-str (buffer-substring-no-properties body-start (point)))
      (setq message-signature-insert-empty-line nil)
      (message-goto-body)
      (delete-region (point) (point-max))
      (insert "<#multipart type=alternative>\n"
	      "<#part type=text/plain>\n"
	      body-str)
      (message-insert-signature)
      (insert "\n<#part type=text/html>\n"
	      "<pre style=\"margin: 0px;\">\n"
	      body-str
	      "</pre><pre style=\"color:gray; margin: 0px;\">")
      (message-insert-signature)
      (insert "\n</pre>\n<#/multipart>"))
    (setq message-signature-insert-empty-line sig-empty-line)))
