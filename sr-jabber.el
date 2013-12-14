;;; (setq jabber-account-list '(JID :'srirragh@cisco.com/wbxconnect'))
;;;  WebEx Connect presents a self-signed certificate so don't try to
;;;  verify it.
(custom-set-variables
 '(jabber-invalid-certificate-servers (quote ("cisco.com"))))
(require 'jabber)
(defadvice jabber-connect
  (around jabber-connect-around)
  "Set GnuTLS priority string for jabber-connect"
  (require 'gnutls)
  (let ((old-gnutls-algorithm-priority gnutls-algorithm-priority))
    (setq gnutls-algorithm-priority "normal:-vers-tls-all:+vers-ssl3.0")
    (message (concat "Saved gnutls-algorithm-priority."
                     " Executing jabber-connect-around advice"
                     " with gnutls-algorithm-priority: "
                     gnutls-algorithm-priority))
    ad-do-it
    ;; Wait for authentication to succeed.
    (sleep-for 2)
    (setq gnutls-algorithm-priority old-gnutls-algorithm-priority)
    (message "Restored gnutls-algorithm-priority.")))
(ad-activate 'jabber-connect)
