(load-library "smtpmail")

(bbdb-initialize 'gnus 'message)

(setq gnus-select-method '(nnml "Work")
      mail-sources '((file :path "/home/user/Mail/team")
		     (file :path "/home/user/Mail/others")
		     (file :path "/home/user/Mail/bcast")))

(require 'ifile-gnus)
(setq ifile-classification-mode 'full-classification)

(setq nnmail-split-fancy
      '(|    
	(:ifile-recommend)))

(setq nnmail-split-methods
      'nnmail-split-fancy)

;; (setq smtpmail-smtp-service 25
;;       smtpmail-smtp-server "localhost"
;;       smtpmail-debug-info t)

;; ;; (setq gnus-select-method '(nnml "private")
;; ;;       mail-sources '((file :path "/home/userr/Mail/mail/misc/new/*")
;; ;; 		     (file :path "/home/userr/Mail/mail/droid/new/*")
;; ;; 		     (file :path "/home/userr/Mail/mail/misc/*")))

;; ;; (setq gnus-select-method '(nnml "private")
;; ;;       mail-sources '((file :path "/home/userr/Mail/mail.bckup")
;; ;; 		     (file :path "/home/userr/Mail/mail.all")))

;; (setq gnus-select-method '(nnml "Not")
;;       mail-sources '((file :path "/home/userr/Mail/team")
;; 		     (file :pathp "/home/userr/Mail/bcast")))

;; ;; (setq gnus-secondary-select-method '(nnml "private")
;; ;;       mail-sources
;; ;;       '((file :path "/home/userr/Mail/team")
;; ;; 	))

;; (require 'ifile-gnus)

;; (setq ifile-classification-mode 'full-classification)

(setq auth-sources '((:source "~/.authinfo")))
(setq smtpmail-smtp-service 25
      smtpmail-smtp-server "mail.hcoop.net"
      smtpmail-debug-info t)

;; (setq smptpmail-auth-credentials 
;;       '(("mail.hcoop.com" "25" "user@marirs.net.in" "@nbes1v@m")))

(setq user-mail-address "$mailid"
      user-full-name    "Crocked Finger"
      message-sendmail-f-is-evil t
      message-send-mail-function 'smtpmail-send-it
      gnus-summary-line-format "%U%R%z%(%[%6L: %-18,18f%]% %-32,32B %-60,60S\n"
      nnrss-use-local t
      mml-insert-mime-headers-always t)

(require 'message)
(add-hook 'message-send-hook 'ispell-message)
(add-hook 'message-mode-hook '(lambda () (define-key message-mode-map (kbd "C-'") 'bbdb-complete-name)))
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (add-hook 'mail-setup-hook 'fortune-to-signature)

(bbdb-insinuate-message)
;; (add-hook 'message-send-hook 'add-mp t)

(set-language-environment "UTF-8")
(when window-system
  (setq gnus-sum-thread-tree-root "* "
	gnus-sum-thread-tree-single-indent "* "
	gnus-sum-thread-tree-leaf-with-other "├─+"
	gnus-sum-thread-tree-vertical "│ "
	gnus-sum-thread-tree-single-leaf "└─┬+"
	gnus-sum-thread-tree-false-root "~*"))

(defun my-sig ()
  (let ((my-sig-str ""))
    (save-excursion
    (fortune-in-buffer t fortune-file)
    (set-buffer fortune-buffer-name)
    (goto-char (point-min))
    (goto-char (point-min))
    (insert-file-contents "~/.signature")
    (setq my-sig-str (buffer-string)))
  my-sig-str))

(setq mail-signature 'my-sig)
(setq message-signature 'my-sig)

(setq gnus-message-archive-method 
      '(nnfolder "archive"
		 (nnfolder-directory   "~/Mail/archive")
		 (nnfolder-get-new-mail nil)
		 (nnfolder-inhibit-expiry t)))

(setq gnus-message-archive-group "archive")
