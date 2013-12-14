;;; Simple Tcp Sock 

(defvar listen-port 80)
(defvar listen-address "127.0.0.1")

(defun listen-start nil
  "Listen Start"
  (interactive)
  (make-network-process :name "listen" :buffer "*listen*" :family 'ipv4 :host listen-address :service listen-port :filter 'listen-filter :sentinel 'listen-sentinel))

(defun listen-filter(proc string)
  "Listen filter "
  (message string))

(defun listen-sentinel (proc msg)
  (when (string= msg "connection broken by remote peer\n")
    (message (format "client %s has quit" proc))))

(defun listen-stop nil 
  "Stop Emacs listen"
  (interactive)
  (delete-process "listen"))

(listen-start)
(sleep-for 10)
(listen-stop)
