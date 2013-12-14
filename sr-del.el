;;; Trying to develope a tool to query delicious, get data
;;; - Arrange the JSON reply.
;;; - Beatufiy the result.
;;; - And dont know yet.

;;; The variable are attached to the global scope[Not the javascript scope but emacs 'scope' ] so be careful with the naming conventions

;;; Essentials move below to move concrete config data structure. Something similar to (defvar delicious-config)
(defvar delicious-config "")

(defvar delicious-file-path "/home/user/tmp/test.xml")
(defvar delicious-name "uname")
(defvar delicious-password "password")
(defvar delicious-header "https://")

;; Url's Root
(defvar delicious-v1-url "@api.del.icio.us/v1/")


;;; delicious v1 url stuffs
(defvar delicious-post-url (concat delicious-v1-url "posts/"))
(defvar delicious-tags-url (concat delicious-v1-url "tags/"))

;;; Working with an explicit buffer, this could be avoided with a temp-buffer. Will try 
(defun delicious-buffer() (generate-new-buffer "*tmp*"))

(defvar delicious-type-map
  '((post-update . "update")
    (post-add . "add?")
    (post-delete . "delete?")
    (post-get .  "get?")
    (post-recent .  "recent?")
    (post-dates .  "dates?")
    (post-all . "all?")
    (post-tags .  "tags")))

(defvar request-url "")

(defun get-post-request-url (url &optional tags)
  (if (string-equal request-url "")
      (message "Nothing to be done")
    (setq request-url ""))
  (if (string-equal url "")
      (message "No URL")
    (setq request-url (concat delicious-header delicious-name ":" delicious-password delicious-post-url url tags))))

(defun get-tags-request-url (url &optional tags)
  (if (string-equal request-url "")
      (message "Nothing to be done")
    (setq request-url ""))
  (if (string-equal url "")
      (message "No URL")
    (setq request-url (concat delicious-header delicious-name ":" delicious-password delicious-tags-url url tags))))

;;; v1 request
(defun delicious-v1-request (type &optional tags)
  (if (string-equal type nil)
      (message "Wrong Type Argument")
    (get-request-url (cdr (assoc type delicious-type-map)))))

;; the Main technology

(defun delicious-request (url)
  (shell-command-on-region
   (point-min) (point-max) (concat "curl --silent --location " url) (delicious-buffer))
  (with-current-buffer (get-buffer-create "*tmp*")
    (write-region (point-min) (point-max) delicious-file-path)))

(defun delicious-user-requests (type)
  (if (string-equal type "")
      (message "No Type Specified")
    ((cdr (assoc 'type delicious-type-map))
     (if (string-equal type-url "")
	 (message "Type Mismatch")
       (delicious-v1-request type-url)))))

;;; User Level API's exposed to user

(defun delicious-update() (delicious-v1-request 'post-update))
(defun delicious-recent() (delicious-v1-request 'post-recent))
(defun delicious-get(&optional tags) (delicious-v1-request 'post-get))
(defun delicious-update() (delicious-v1-request 'post-update))

;;; v2 request [Delicious Specific API 'v2']
;; Seem's like the v2 API's have been decommissioned.
;; (defun delicious-v2-request(url count &optional type uname)
;;   (if (string-equal type "")
;;       (setq type "json")
;;     (if (string-equal uname "")
;; 	(setq uname delicious-test-name)
;;       (concat url type "/" uname))))

;; (defvar delicious-v2-url "http://feeds.delicious.com/v2/")

;; (defun test(type)
;;   (message "HEllo World" type)
;;   (setq url (cdr (assoc 'post-update delicious-type-map)))
;;   (message url))

;; (test "post-update")

;; (defun delicious-get-recent ()
;; (setq url (concat "https://" delicious-name ":" delicious-password delicious-post-url "recent"))
;; (delicious-request url))

;; http://www.cs.cmu.edu/~crary/819-f09/

;; (defun create-url (url)
;; (setq purl (concat "https://" delicious-name ":" delicious-password delicious-post-url "add?url=" url)))

;; (defun delicious-post (url)
;; (if (string-equal url nil)
;; (message "No URL")
;; (delicious-request (create-url url))))

;; (defun delicious-get-all-tags()
;; (setq turl (delicious-get-tags))
;; (if (string-equal turl nil)
;; (message "No Tag URL")
;; (delicious-post turl)))

;; (defun delicious-get-tags ()
;; (setq turl (concat "https://" delicious-name ":" delicious-password delicious-tags-url)))

;; (delicious-get-all-tags)
;; (delicious-post "http://www.google.com/")
;; (delicious-get-recent)
;; (delicious-create-request "http://feeds.delicious.com/v2/json/uname?count=2")
