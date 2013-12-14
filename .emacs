;;; The main .emacs file

(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))
(defvar running-win32 (string-match "mingw\\|nt" (emacs-version)) "Are we running win32")
(defvar sr-config-dir "~/.emacs-config")
(add-to-list 'load-path "/home/sriram/Downloads/bbdb-2.35/lisp/")
(add-to-list 'load-path "/home/sriram/Downloads/color-theme/")
(add-to-list 'load-path "/home/sriram/Downloads/muse-3.20/muse")
(add-to-list 'load-path "/home/sriram/Downloads/ifile-gnus-el/")
(add-to-list 'load-path "/usr/share/emacs23/site-lisp/emacs-goodies-el/")
;; (add-to-list 'load-path "/home/sriram/Downloads/planner-3.42/")
(add-to-list 'load-path sr-config-dir)

;; Global Key Binding stuffs

(global-set-key (kbd "C-c C-b") 'bbdb-create)
(global-set-key (kbd "\C-x C-b") 'ibuffer)
(global-set-key (kbd "\C-cl") 'org-store-link)
(global-set-key (kbd "\C-cc") 'org-capture)
(global-set-key (kbd "\C-ca") 'org-agenda)
(global-set-key (kbd "\C-cb") 'org-iswitchb)

(setq-default fill-column 80)

(setq debug-on-error 't)


;; You shall require 
;; (require 'id-utils)
(require 'php-mode)
(require 'project-buffer-mode)
(require 'ibuffer)
(require 'oddmuse)
(require 'color-theme)
;; (require 'jabber)

(scroll-bar-mode 0)
(menu-bar-mode 0)
;;; the loading configs from .el's at .emacs-config
;;(load "coffee-mode")
(load "monokai-theme")
(load "sr-common")
(load "sr-dev")
(load "sr-funcs")
(load "sr-erc")
(load "sr-gnus")
;; (load "sr-muse-stuff")
(load "sr-custom")
;; (load "sr-jabber")
(load "org-publish")
;; (load "id-utils")
(load "gid")
(set-face-background 'region "darkgreen")
;; (color-theme-monokai)

;; my stuff in this.
;;(if (not running-win32) (load "akn-unix") (load "akn-win32"))
;; Org-mode stuffs
(autoload 'org-publish "org-publish" nil t)
(autoload 'org-publish "org-publish-all" nil t)
(autoload 'org-publish "org-publish-current-file" nil t)
(autoload 'org-publish "org-publish-current-project" nil t)

(setq org-publish-project-alist
      (list 
       '("Sqlite"
	 :base-directory "~/src/notes/"
	 :publishing-directory "~/pub_webs/Wrk/mm_map/sqlite/"
	 :section-numbers nil
	 :table-of-contents nil
	 :style "<link rel=\"stylesheet\"
                     href=\"/org.css\"
                     type=\"text/css\"/>")

       '("CompDev"
	 :base-directory "~/src/notes/"
	 :publishing-directory "~/pub_webs/Wrk/cd/"
	 :section-numbers nil
	 :table-of-contents nil
	 )
       ))

;;; Smooth Scroll Stuff
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)

;;; Oddmuse Mode 
(load "oddmuse-curl")
(oddmuse-mode-initialize)
(setq url-proxy-services '(("http" . "proxy.in.nds.com:8080")))

;;; notes Stuffs
(setq org-remember-templates
      '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?" "~/org/tasks.org" "Tasks")
        ("Journal"   ?j "** %^{Head Line} %U %^g\n%T%?"  "~/org/journal.org")
        ("Notes" ?p "\n\n* %^{Paper Title} %^g\n  %T\n** %?"
	 "~/Documents/org/paper-notes.org")))

(defun gtd ()
  (interactive)
  (find-file "~/org/tasks.org")
  )
(global-set-key (kbd "C-c g") 'gtd)

(defun open-journal ()
  (interactive)
  (find-file "~/org/journal.org")
  )
(global-set-key (kbd "C-c j") 'open-journal)

(defun paper-notes ()
  (interactive)
  (find-file "~/org/paper-notes.org")
  )
(global-set-key (kbd "C-c p") 'paper-notes)

;; Mostly ibuffer related stuffs
(setq ibuffer-saved-filter-groups
 (quote (("default"
	  ("dired"   (mode . dired-mode))
	  ("python"   (mode . python-mode))
	  ("perl"   (mode . perl-mode))
	  ("lisp"   (mode . elisp-mode))
	  ("org" (or 
		  (mode . org-mode)))
	  ("cdapp" (or
		    (mode . js-mode)
		    (mode . html-mode)
		    (mode . css-mode)
		    ))
	  ("love" (or
		    (mode . c-mode)
		    ))
	  ))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "k&r") (c++-mode . "k&r") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(ibuffer-display-summary nil)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 18 18 :left :elide) " " (size 9 -1 :right) " " (mode 16 16 :right :elide) " " filename) (mark " " (name 16 -1) " " filename))))
 '(ibuffer-saved-filter-groups nil)
 '(ibuffer-saved-filters (quote (("work" ((or (mode . c-mode) (mode . c++-mode) (mode . java-mode)))) ("irc" ((mode . erc-mode))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" (mode . c-mode)))))
 '(ibuffer-saved-limits (quote (("work" ((or (mode . java-mode) (mode . c-mode) (mode . c++-mode)))) ("gnus" ((or (mode . message-mode) (mode . mail-mode) (mode . gnus-group-mode) (mode . gnus-summary-mode) (mode . gnus-article-mode)))) ("programming" ((or (mode . emacs-lisp-mode) (mode . cperl-mode) (mode . c-mode) (mode . java-mode) (mode . idl-mode) (mode . lisp-mode)))))))
 '(jabber-invalid-certificate-servers (quote ("cisco.com")))
 '(send-mail-function (quote smtpmail-send-it))
 '(speedbar-default-position (quote auto)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "LemonChiffon" :foreground "black"))))
 '(erc-action-face ((t (:foreground "PaleGreen2" :weight bold))))
 '(erc-current-nick-face ((t (:foreground "Yellow" :weight bold))))
 '(erc-direct-msg-face ((t (:foreground "LemonChiffon"))))
 '(erc-input-face ((t (:foreground "snow2"))))
 '(erc-inverse-face ((t (:background "White" :foreground "Black"))))
 '(erc-nick-default-face ((t (:foreground "SteelBlue2" :weight bold))))
 '(erc-nick-msg-face ((t (:foreground "PaleTurquoise2" :weight bold))))
 '(erc-notice-face ((t (:foreground "SteelBlue1" :weight bold))))
 '(erc-timestamp-face ((t (:foreground "Green"))))
 '(fringe ((((class color) (background dark)) (:background "DarkSlateGray"))))
 '(gnus-group-mail-low-empty ((((class color) (background dark)) (:foreground "aquamarine4"))))
 '(gnus-header-content ((((class color) (background dark)) (:foreground "LightGoldenrod"))))
 '(gnus-header-newsgroups ((((class color) (background dark)) (:foreground "yellow"))))
 '(gnus-header-subject ((((class color) (background dark)) (:foreground "gold"))))
 '(gnus-signature ((t (:foreground "khaki" :slant normal))))
 '(ibuffer-deletion-face ((t (:foreground "Orange"))))
 '(info-menu-star ((((class color)) (:foreground "Orange"))))
 '(info-xref ((((class color) (background dark)) (:foreground "cyan"))))
 '(isearch ((((class color) (background dark)) (:background "PeachPuff" :foreground "DarkGreen"))))
 '(message-cited-text ((((class color) (background dark)) (:foreground "orange"))))
 '(message-header-cc ((t (:foreground "turquoise3" :weight bold))))
 '(message-header-name ((((class color) (background dark)) (:foreground "turquoise"))))
 '(message-header-other ((((class color) (background dark)) (:foreground "#ff8040"))))
 '(message-header-subject ((((class color) (background dark)) (:foreground "orange"))))
 '(message-header-to ((t (:foreground "turquoise1" :weight bold))))
 '(message-header-xheader ((((class color) (background dark)) (:foreground "skyblue1"))))
 '(message-mml ((((class color) (background dark)) (:foreground "khaki"))))
 '(message-separator ((((class color) (background dark)) (:foreground "skyblue3"))))
 '(planner-high-priority-task-face ((t (:foreground "tomato"))))
 '(planner-low-priority-task-face ((t (:foreground "Skyblue"))))
 '(region ((((class color) (background dark)) (:background "DarkGreen")))))
(put 'line-number-mode 'disabled nil)
