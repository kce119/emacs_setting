((anything status "installed" recipe
	   (:name anything :after nil :features
		  (anything)
		  :website "http://www.emacswiki.org/emacs/Anything" :description "Open anything / QuickSilver-like candidate-selection framework" :type git :url "http://repo.or.cz/r/anything-config.git" :shallow nil :load-path
		  ("." "extensions" "contrib")))
 (auto-complete status "installed" recipe
		(:name auto-complete :after nil :features
		       (auto-complete-config)
		       :depends
		       (fuzzy popup)
		       :website "https://github.com/auto-complete/auto-complete" :description "The most intelligent auto-completion extension." :type github :pkgname "auto-complete/auto-complete" :post-init
		       (progn
			 (add-to-list 'ac-dictionary-directories
				      (expand-file-name "dict" default-directory))
			 (ac-config-default))))
 (auto-complete-c-headers status "installed" recipe
			  (:name auto-complete-c-headers :after nil :depends
				 (auto-complete)
				 :website "https://github.com/mooz/auto-complete-c-headers" :description "An auto-complete source for C/C++ header files." :type github :pkgname "mooz/auto-complete-c-headers" :prepare
				 (progn
				   (defun ac--c-headers-init nil
				     (require 'auto-complete-c-headers)
				     (add-to-list 'ac-sources 'ac-source-c-headers))
				   (add-hook 'c-mode-hook 'ac--c-headers-init)
				   (add-hook 'c++-mode-hook 'ac--c-headers-init))))
 (bm status "installed" recipe
     (:name bm :after nil :pkgname "joodland/bm" :website "http://joodland.github.com/bm/" :type github :description "Visible, persistent, buffer local, bookmarks"))
 (cedet status "installed" recipe
	(:name cedet :website "http://cedet.sourceforge.net/" :description "CEDET is a Collection of Emacs Development Environment Tools written with the end goal of creating an advanced development environment in Emacs." :type git :url "http://git.code.sf.net/p/cedet/git" :build
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs))
		  "clean-all")
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs)))
		 ("make" ,(format "EMACS=%s"
				  (shell-quote-argument el-get-emacs))
		  "-C" "contrib"))
	       :build/berkeley-unix
	       `(("sh" "-c" "touch `find . -name Makefile`")
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs))
		  "clean-all")
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs)))
		 ("gmake" ,(format "EMACS=%s"
				   (shell-quote-argument el-get-emacs))
		  "-C" "contrib"))
	       :build/windows-nt
	       `(("sh" "-c" "touch `/usr/bin/find . -name Makefile` && make FIND=/usr/bin/find"))
	       :features nil :lazy nil :post-init
	       (if
		   (or
		    (featurep 'cedet-devel-load)
		    (featurep 'eieio))
		   (message
		    (concat "Emacs' built-in CEDET has already been loaded!  Restart" " Emacs to load CEDET from el-get instead."))
		 (load
		  (expand-file-name "cedet-devel-load.el" pdir)))))
 (cl-lib status "installed" recipe
	 (:name cl-lib :builtin "24.3" :type elpa :description "Properly prefixed CL functions and macros" :url "http://elpa.gnu.org/packages/cl-lib.html"))
 (coffee-mode status "installed" recipe
	      (:name coffee-mode :after nil :features
		     (coffee-mode)
		     :website "http://ozmm.org/posts/coffee_mode.html" :description "Emacs Major Mode for CoffeeScript" :type github :pkgname "defunkt/coffee-mode" :prepare
		     (progn
		       (add-to-list 'auto-mode-alist
				    '("\\.coffee$" . coffee-mode))
		       (add-to-list 'auto-mode-alist
				    '("Cakefile" . coffee-mode)))))
 (col-highlight status "installed" recipe
		(:type github :pkgname "emacsmirror/col-highlight" :name col-highlight :after nil :depends
		       (vline)
		       :description "Highlight the current column." :type emacsmirror))
 (crosshairs status "installed" recipe
	     (:name crosshairs :after nil :auto-generated t :type emacswiki :description "Highlight the current line and column." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/crosshairs.el"))
 (dash status "installed" recipe
       (:name dash :description "A modern list api for Emacs. No 'cl required." :type github :pkgname "magnars/dash.el"))
 (el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:features el-get :post-init
		(when
		    (memq 'el-get
			  (bound-and-true-p package-activated-list))
		  (message "Deleting melpa bootstrap el-get")
		  (unless package--initialized
		    (package-initialize t))
		  (when
		      (package-installed-p 'el-get)
		    (let
			((feats
			  (delete-dups
			   (el-get-package-features
			    (el-get-elpa-package-directory 'el-get)))))
		      (el-get-elpa-delete-package 'el-get)
		      (dolist
			  (feat feats)
			(unload-feature feat t))))
		  (require 'el-get))))
 (emacs-async status "installed" recipe
	      (:name emacs-async :description "Simple library for asynchronous processing in Emacs" :type github :pkgname "jwiegley/emacs-async"))
 (epl status "installed" recipe
      (:name epl :description "EPL provides a convenient high-level API for various package.el versions, and aims to overcome its most striking idiocies." :type github :pkgname "cask/epl"))
 (exec-path-from-shell status "installed" recipe
		       (:name exec-path-from-shell :after nil :website "https://github.com/purcell/exec-path-from-shell" :description "Emacs plugin for dynamic PATH loading" :type github :pkgname "purcell/exec-path-from-shell"))
 (flycheck status "installed" recipe
	   (:name flycheck :after nil :depends
		  (seq let-alist pkg-info dash)
		  :type github :pkgname "flycheck/flycheck" :minimum-emacs-version "24.3" :description "On-the-fly syntax checking extension"))
 (function-args status "installed" recipe
		(:name function-args :after nil :depends
		       (swiper cedet)
		       :description "Shows C++ function arguments using Semantic" :type github :pkgname "abo-abo/function-args"))
 (fuzzy status "installed" recipe
	(:name fuzzy :website "https://github.com/auto-complete/fuzzy-el" :description "Fuzzy matching utilities for GNU Emacs" :type github :pkgname "auto-complete/fuzzy-el"))
 (ggtags status "installed" recipe
	 (:name ggtags :after nil :description "Use GNU Global in Emacs." :type github :pkgname "leoliu/ggtags"))
 (goto-chg status "installed" recipe
	   (:name goto-chg :after nil :features
		  (goto-chg)
		  :description "Goto the point of the most recent edit in the buffer." :type emacswiki))
 (hl-line+ status "installed" recipe
	   (:name hl-line+ :after nil :auto-generated t :type emacswiki :description "Extensions to hl-line.el." :website "https://raw.github.com/emacsmirror/emacswiki.org/master/hl-line+.el"))
 (let-alist status "installed" recipe
	    (:name let-alist :description "Easily let-bind values of an assoc-list by their names." :builtin "25.0.50" :type elpa :url "https://elpa.gnu.org/packages/let-alist.html"))
 (magit status "required" recipe nil)
 (migemo status "installed" recipe
	 (:name migemo :after nil :description "Japanese increment search with 'Romanization of Japanese'" :type github :pkgname "emacs-jp/migemo"))
 (package status "installed" recipe
	  (:name package :description "ELPA implementation (\"package.el\") from Emacs 24" :builtin "24" :type http :url "https://repo.or.cz/w/emacs.git/blob_plain/ba08b24186711eaeb3748f3d1f23e2c2d9ed0d09:/lisp/emacs-lisp/package.el" :features package :post-init
		 (progn
		   (let
		       ((old-package-user-dir
			 (expand-file-name
			  (convert-standard-filename
			   (concat
			    (file-name-as-directory default-directory)
			    "elpa")))))
		     (when
			 (file-directory-p old-package-user-dir)
		       (add-to-list 'package-directory-list old-package-user-dir)))
		   (setq package-archives
			 (bound-and-true-p package-archives))
		   (let
		       ((protocol
			 (if
			     (and
			      (fboundp 'gnutls-available-p)
			      (gnutls-available-p))
			     "https://"
			   (lwarn
			    '(el-get tls)
			    :warning "Your Emacs doesn't support HTTPS (TLS)%s"
			    (if
				(eq system-type 'windows-nt)
				",\n  see https://github.com/dimitri/el-get/wiki/Installation-on-Windows." "."))
			   "http://"))
			(archives
			 '(("melpa" . "melpa.org/packages/")
			   ("gnu" . "elpa.gnu.org/packages/")
			   ("marmalade" . "marmalade-repo.org/packages/"))))
		     (dolist
			 (archive archives)
		       (add-to-list 'package-archives
				    (cons
				     (car archive)
				     (concat protocol
					     (cdr archive)))))))))
 (pkg-info status "installed" recipe
	   (:name pkg-info :description "Provide information about Emacs packages." :type github :pkgname "lunaryorn/pkg-info.el" :depends
		  (dash epl)))
 (point-undo status "installed" recipe
	     (:name point-undo :after nil :auto-generated t :type emacswiki :description "undo/redo position" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/point-undo.el"))
 (popup status "installed" recipe
	(:name popup :website "https://github.com/auto-complete/popup-el" :description "Visual Popup Interface Library for Emacs" :type github :submodule nil :depends cl-lib :pkgname "auto-complete/popup-el"))
 (recentf-ext status "installed" recipe
	      (:name recentf-ext :after nil :features
		     ("recentf-ext")
		     :description "Recentf extensions" :type emacswiki))
 (redo+ status "installed" recipe
	(:name redo+ :after nil :auto-generated t :type emacswiki :description "Redo/undo system for Emacs" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/redo+.el"))
 (seq status "installed" recipe
      (:name seq :description "Sequence manipulation library for Emacs" :builtin "25" :type github :pkgname "NicolasPetton/seq.el"))
 (sequential-command status "installed" recipe
		     (:name sequential-command :after nil :auto-generated t :type emacswiki :description "Many commands into one command" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sequential-command.el"))
 (sequential-command-config status "installed" recipe
			    (:name sequential-command-config :after nil :auto-generated t :type emacswiki :description "Examples of sequential-command.el" :website "https://raw.github.com/emacsmirror/emacswiki.org/master/sequential-command-config.el"))
 (swiper status "installed" recipe
	 (:name swiper :description "Gives you an overview as you search for a regex." :type github :pkgname "abo-abo/swiper" :build
		(("makeinfo" "-o" "doc/ivy.info" "doc/ivy.texi"))
		:info "doc/ivy.info"))
 (vline status "installed" recipe
	(:name vline :description "show vertical line (column highlighting) mode." :type emacswiki :features vline))
 (with-editor status "installed" recipe
	      (:name with-editor :description "Use the Emacsclient as $EDITOR" :type github :pkgname "magit/with-editor")))
