(require 'muse)
(require 'muse-mode)
(require 'muse-colors)
(require 'muse-project)
(require 'muse-book)
(require 'muse-html)
(require 'muse-message)
(require 'muse-blosxom)
(require 'muse-texinfo)
(require 'muse-wiki)
(require 'muse-latex)

(setq my-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"css/style.css\" />")

(muse-derive-style "my-html" "html"
                   :header "~/src/muse/source/templates/header.html"
                   :footer "~/src/muse/source/templates/footer.html"
                   :style-sheet my-style-sheet)

;;; Hooks to enable flyspell and footnote

(defun my-muse-hooks ()
  (flyspell-mode 1)
  (footnote-mode 1)
  )

(add-hook 'muse-mode-hook 'my-muse-hooks)

(setq muse-project-alist 
      '(
	("Home" ("~/src/muse/source/" :defualt "index"
		 :force-publish ("WikiIndex")
		 )
	 (:base "html" 
		:path "~/src/muse/public_html"
		:base-url "http://marirs.net.in/"))

	("Blog" ("~/src/muse/source/blogs/" 
		 :default "blog" 
		 :force-publish ("WikiIndex"))
	 (:base "my-html" :path "~/src/muse/public_html/blogs/"))

	("Programming" ("~/src/muse/source/programming/" 
			:default "pindex" 
			:force-publish ("WikiIndex"))
	 (:base "my-html" 
		:path "~/src/muse/public_html/programming/"))

	("Life" ("~/src/muse/source/life/" 
		 :default "life" 
		 :force-publish ("WikiIndex"))
	 (:base "my-html" :path "~/src/muse/public_html/life/"))
	
	("Mathematics" ("~/src/muse/source/math/" 
		 :default "math" )
	 (:base "latex" :path "~/src/muse/public_html/math/"))
	))

(defun cur-dir ()
  (replace-regexp-in-string
   "source*" "public_html"
   (setq tags-file-name (concat default-directory))))

(defun substring-match()
  (setq base-dir (concat "/home/user/src/muse/public_html/"))
  (cur-dir)
  (setq bslen (length base-dir))
  (setq cdlen (length (cur-dir)))
  (setq cdlen (length (cur-dir)))
  (setq substr (concat (substring (cur-dir) bslen cdlen))))

(defun create-css-url()
  (if (< 0 (length (substring-match)))
      (setq css-url "../css/style.css")
    (setq css-url "css/style.css")
    ))

(custom-set-variables
 '(muse-blosxom-base-directory "~/src/muse/source/")
 '(muse-colors-autogen-headings (quote outline))
 '(muse-colors-inline-image-method (quote muse-colors-use-publishing-directory))
 '(muse-completing-read-function (quote ido-completing-read))
 '(muse-html-charset-default "utf-8")
 '(muse-html-encoding-default (quote utf-8))
 '(muse-html-meta-content-encoding (quote utf-8))
 '(muse-html-header "~/src/muse/source/templates/header.html")
 '(muse-html-footer "~/src/muse/source/templates/footer.html")
 '(muse-html-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"css/style.css\" />")
 '(muse-publish-desc-transforms (quote (muse-wiki-publish-pretty-title muse-wiki-publish-pretty-interwiki muse-publish-strip-URL)))
 '(muse-publish-comments-p t)
 '(muse-publish-date-format "%b. %e, %Y")
 '(muse-wiki-publish-small-title-words (quote ("the" "and" "at" "on" "of" "for" "in" "an" "a" "page")))
 '(muse-xhtml-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\" href=\"css/style.css\" />"))
