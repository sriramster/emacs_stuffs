;; Standard stuff
(require 'ibuffer)
(require 'cl)
;; (require 'emacs-wiki) 
(require 'bbdb)
(require 'fortune)

;; Some Settings
(cond (window-system (mwheel-install)))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq fortune-file "/usr/share/games/fortunes/"
      global-font-lock-mode t
      make-backup-files nil
      next-line-add-newlines nil
      require-final-newline t
      scroll-conservatively 5
      transient-mark-mode t
      x-select-enable-clipboard t)

(toggle-case-fold-search)
(tool-bar-mode 0)

;; Automode list
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))
(add-to-list 'auto-mode-alist '("\\.wsdl\\|.xsd" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.rc\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.mak" . makefile-mode))
;(add-to-list 'auto-mode-alist '("\\.muse" . muse-mode))
(add-to-list 'auto-mode-alist '("\\.bin" . hexl-mode))
(add-to-list 'auto-mode-alist '("\\.pl" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.py" . python-mode))
(add-to-list 'auto-mode-alist '("\\.db" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.js" . js-mode))
(add-to-list 'auto-mode-alist '("\\.html" . html-mode))
(add-to-list 'auto-mode-alist '("\\.css" . css-mode))

;; Ispell
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))

;; Global Keys
(global-set-key [delete] 'delete-char)
(global-set-key (kbd "C-c C-b") 'ibuffer)
(global-set-key (kbd "C-x n") 'goto-line)
(global-set-key (kbd "C-x ,") 'cvs-examine)
(global-set-key (kbd "C-x /") 'replace-regexp)
(global-set-key (kbd "C-x |") 'setnu-mode)
(global-set-key [kp-delete] 'delete-char)
(global-set-key (kbd "C-x 9") 'flip-xclip-behaviour)
(global-set-key (kbd "C-c d d") '(lambda () (interactive) (dict (word-at-point))))
											      
;; Set-NU mode
(defface line-number-face 
  '((((type x)) (:foreground "gray" :background "black")))
  "Line numbers font coloring"
  :group 'basic-faces)
(setq setnu-line-number-face 'line-number-face)

;; No audio bell for some commands
(setq ring-bell-function 
      (lambda ()
	(unless (memq this-command '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))

;; Generic simple modes for some not-frequently-edited files.
(setq generic-define-unix-modes t)
(require 'generic-x)

;; Org-mode stuff.
(setq org-directory "~/src/notes/")
(setq org-agenda-files (quote ("~/src/notes/")))


(defun get-env()
  (interactive)
  "Hello World")


