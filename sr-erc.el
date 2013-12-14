;;; ERC

(require 'erc)
(require 'erc-log)

(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof
                                       -CAfile /home/user/.private/certs/CAs.pem 
                                       -cert /home/user/.private/certs/user.pem" ))
(defun start-irc ()
  "Connect to IRC."
  (interactive)
  (erc-tls :server "irc.freenode.net" :port 6667
	   :nick "nick" :full-name "fullname")
  (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs"))))

;; (start-irc)


(setq erc-nick "nickname"
      erc-user-full-name "full name"
      erc-server "irc.freenode.net"
      erc-email-userid "emailaddress"
      erc-password 'password password)

(setq 
 erc-auto-query t
 erc-fill-mode t
 erc-fill-static-center 15
 erc-fill-column 100 
 erc-fill-function 'erc-fill-static
 erc-timestamp-only-if-changed-flag nil
 erc-timestamp-format "%H:%M "
 erc-fill-prefix "      "
 erc-log-channels-directory "~/.erc/logs/"
 erc-save-buffer-on-part t
 erc-log-insert-log-on-open nil
 erc-insert-timestamp-function 'erc-insert-timestamp-left)

;; (require 'erc-autojoin)
;; (erc-autojoin-mode 1)
;; (erc-timestamp-mode 1)
;; (setq erc-autojoin-channels-alist
;;       '(("freenode.net" "#emacs")))

;; Pool of colors to use when coloring IRC nicks.
(setq erc-colors-list '("green" "CadetBlue1" "red" "olive drab" 
			"chocolate1" "dark magenta" "maroon1" "khaki" 
			"light gray" "olive drab" "aquamarine" "thistle"))

;; special colors for some people
(setq erc-nick-color-alist '(("John" . "blue")
			     ("Bob" . "red")
			     ))

(defun erc-get-color-for-nick (nick)
  "Gets a color for NICK. If NICK is in erc-nick-color-alist, use that color, else hash the nick and use a random color from the pool"
  (or (cdr (assoc nick erc-nick-color-alist))
      (nth
       (mod (string-to-number
	     (substring (md5 nick) 0 6) 16)
	    (length erc-colors-list))
       erc-colors-list)))

(defun erc-put-color-on-nick ()
  "Modifies the color of nicks according to erc-get-color-for-nick"
  (save-excursion
    (goto-char (point-min))
    (if (looking-at "[0-9:\s]+<\\([^>]*\\)>.*$")
	(let ((nick (match-string 1)))
	  (put-text-property (match-beginning 1) (match-end 1) 'face
			     (cons 'foreground-color
				   (erc-get-color-for-nick nick)))))))

(add-hook 'erc-insert-modify-hook 'erc-put-color-on-nick)

