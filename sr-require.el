;;;(load "request")
;; (defun error-msg()"Error")

(defun json-read(data)
  "Read Json")

(request
 "http://10.100.112.64/Wrk/config.json"
 ;; "http://search.twitter.com/search.json"
 :params '((q . "emacs awesome"))
 :parser 'json-read
 :success (function*
           (lambda (data)
	     (message "Data is %s" data))))
	     
