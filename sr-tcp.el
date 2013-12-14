(load "tcp-client")
(load "record-type")

(defun tcp-connect-failed(buffer server port error)
  "Failed to connect"
  (save-excursion
    (set-buffer buffer)
    (insert (format "[error] %s:%i -- %s\n" server port error))))

(defun tcp-connect-success(buffer server port)
  "Success to connect"
  (save-excursion
    (set-buffer buffer)
    (insert (format "[Success] :%i -- %s\n" server port))))


(defun tcp-connect-close(buffer server port)
  (save-excursion
    (set-buffer buffer)
    (insert (format "[error] %s:%i -- Abort connection\n" server port))))

(defun sentinel(process event)
  (save-excursion
    (set-buffer (process-buffer process))
    (insert (format "[event] Process: %s had the event -- %s" process event))))

(defun filter(process message)
  (save-excursion
    (set-buffer (process-buffer process))
    (insert (format "[got] %s" message))))

(tcp-connect "*ok*"
	     (make-new-tcp-connection :server "127.0.0.1" :port 8888)
	     (make-new-tcp-hooks 
	      :connection-failed-handler 'tcp-connect-failed
	      :connection-established-handler 'tcp-connect-success
	      :connection-abort-handler 'tcp-connect-close
	      :filter-handler 'filter
	      :sentinel-handler 'sentinel
	      )
	     )
