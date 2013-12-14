(load "http-get")

(defun create-buffer(buffer)
  (generate-new-buffer buffer))

(defun http-sentinel(process event)
  (save-excursion
    (set-buffer (process-buffer process))
    (insert (format "[event] Process: %s had the event -- %s" process event))))

(defun create-http-request(url buffer)
  (set-buffer (process-buffer process))
  (http-get(url 'http-sentinel buffer)))

(create-buffer "*tmp*")
(create-http-request "http://feeds.delicious.com/v2/json/user?count=2" "*tmp*")
