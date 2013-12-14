;;; Handling init-developmental mode stuffs

(defvar devel-file-extension-map
  '(("c" c-mode)
    ("html" html-mode)
    ("py" python-mode)
    ("pl" perl-mode)
    ("php" php-mode)
    ("scm" scheme-mode)
    ("java" java-mode)
    ("js" js-mode)))

(defun init-dev-mode (filename)
  (interactive)
  (setq mode (cdr (assoc (elt (split-string filename "[.]") 1) devel-file-extension-map)))
  (find-file-noselect filename t)
  (with-temp-buffer 
    (insert (format (cdr (assoc (elt (split-string filename "[.]") 1) devel-mode-data-map))))
    (write-region (point-min) (point-max) filename))
  (find-file filename)
  (indent-according-to-mode))

;; (init-dev-mode "/tmp/test2.c")

(defvar devel-mode-data-map
  '(("c" .  "
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
int c = 0;
printf(\"\n hello world\");
return 0;
}
")
    ("html" . "<html>
<title>Test</title>
<head>
<link type=\"text/css\" rel=\"stylesheet\" href=\"css/style.css\" />
<script type=\"text/javascript\" src=\"scripts/main.js\"></script>
</head>
<body>
</body>")
    ("py" . "
import os
import sys

class TestMyAss():
def test(self):
print \"hello World\"

c = new TestMyAss()
")
    ("js".  "
function one() {
console.log('Test');
}

function two() {
var loc = window.location;
console.log('Location = ',loc.origin);
}	  
")
    ("pl".  "
#!/usr/bin/perl -w

function test() {
print 'Hello World'
}
")
    ("php" .   "
<?php
$a = 1;
$b = 1;

$result = echo \"Sum \" $a + $b;
?>
")
    ("scm" . "
\(define (sum a b)
  (+ a b)
)
\(define (diff a b)
\(- a b)
)
")
    ("java" . "
import java.io;
import java.io.*;

public class ChangeThisToFileName() {
public:
int a;
ChangeThisToFileName() {
a=0;
}
private: 


public int sum(int a, int b) {
return a+b;
}
}
")))

