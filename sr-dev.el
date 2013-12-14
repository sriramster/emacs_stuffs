;;; C and other developmen env.

;; ID utils
(autoload 'gid "idutils")

;; Extras
(add-hook 'c-mode-hook '(lambda () (define-key c-mode-map (kbd "C-c C-v C-c") 'compile)))
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-hook 'auto-fill-mode)

;; Not used (setq global-senator-minor-mode t)

;; Mostly ibuffer related stuffs
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org"   (or 
			 (mode . org-mode)))
	       ("lisp"   (or 
			 (mode . emacs-lisp-mode)))
	       ("love"   (or 
			 (mode . c-mode)))
	       ("java"   (or 
			 (mode . java-mode)))
	       ("urbanbinge" (or
			 (mode . js-mode)
			 (mode . html-mode)
			 (mode . css-mode)
			 ))
	       ("perl" (or
			 (mode . perl-mode)))
	       ("python" (or
			 (mode . python-mode)))
	       ))))

(add-hook 'ibuffer-mode 'ibuffer-switch-to-saved-filter-groups "default")
