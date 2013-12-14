;;; File I/O examples.. 

(defun write-data-to-file (data filepath)
  (with-temp-buffer 
    (insert data)
    (write-region (point-min) (point-max) filepath)))

(write-data-to-file "Hello World" "/home/sriram/tmp/test")
