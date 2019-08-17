;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs '
;;; ---------------------
;;;
;;; If you need your own personal ~/.emacs
;;; please make a copy of this file
;;; an placein your changes and/or extension.
;;; Copyright (c) 1997-2002 SuSE Gmbh Nuernberg, Germany.
;;;
;;; Author: Werner Fink, <feedback@suse.de> 1997,98,99,2002
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Test of Emacs derivates
;;; -----------------------
(if (string-match "XEmacs\\|Lucid" emacs-version)
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; XEmacs
  ;;; ------
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (progn
      (if (file-readable-p "~/.xemacs/init.el")
          (load "~/.xemacs/init.el" nil t))
      )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;; GNU-Emacs
  ;;; ---------
  ;;; load ~/.gnu-emacs or, if not exists /etc/skel/.gnu-emacs
  ;;; For a description and the settings see /etc/skel/.gnu-emacs
  ;;;   ... for your private ~/.gnu-emacs your are on your one.
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (if (file-readable-p "~/.gnu-emacs")
      (load "~/.gnu-emacs" nil t)
    (if (file-readable-p "/etc/skel/.gnu-emacs")
        (load "/etc/skel/.gnu-emacs" nil t)))

  ;; Custom Settings
  ;; ===============
  ;; To avoid any trouble with the customization system of GNU emacs
  ;; we set the default file ~/.gnu-emacs-custom
  ;(setq custom-file "~/.gnu-emacs-custom")
  ;(load "~/.gnu-emacs-custom" t t)
;;;
  )
;;;
(server-start)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(require 'package)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'untabify)
(global-set-key (kbd "C-x n a") 'rename-buffer)

(use-package key-chord
  :ensure t
  :init
  (key-chord-mode 1)
  :config
  (key-chord-define-global "HT" "()\C-b")
  (key-chord-define-global "\"P" "\"\"\C-b")
  (key-chord-define-global "\'p" "\'\'\C-b")
  (key-chord-define-global "HN" "{}\C-b")
  (key-chord-define-global "NN" "$$\C-b")
  (key-chord-define-global "HR" "[]\C-b")
  (key-chord-define-global "HC" "\C-f")
  (key-chord-define-global "<>" "<>\C-b")
  (key-chord-define-global "GC" 'windmove-up)
  (key-chord-define-global "MW" 'windmove-down)
  (key-chord-define-global "OE" 'windmove-left)
  (key-chord-define-global "OU" 'windmove-right)
  (key-chord-define-global "#$" 'find-file)
  (key-chord-define-global "GL" 'yank-into-clipboard))
(global-set-key (kbd "C-c p") 'helm-projectile)
(defun yank-into-clipboard ()
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "pbcopy"))
(use-package evil
  :ensure t
  :init
  (evil-mode 1)
  :config
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (define-key evil-insert-state-map "\C-a" nil)
  (define-key evil-insert-state-map "\C-k" nil)
  (define-key evil-insert-state-map "\C-d" nil)
  (define-key evil-insert-state-map "\C-w" nil)
  (define-key evil-insert-state-map "\C-e" nil)
  (define-key evil-insert-state-map "\C-t" nil)
  (define-key evil-insert-state-map "\C-n" nil)
  (define-key evil-insert-state-map "\C-p" nil)
  )


(use-package evil-matchit
  :ensure t
  :init
  (global-evil-matchit-mode 1)
  )

(use-package highlight-indentation
  :ensure t
  :config
  (set-face-background 'highlight-indentation-face "#aaaaff")
  )

(use-package intero
  :ensure t
  )

(use-package haskell-mode
  :ensure t
  :init
  (setq haskell-tags-on-save t)
  (add-hook 'haskell-mode 'intero-mode)
  )

(setq path-to-ctags (substring (shell-command-to-string "which ctags") 0 -1))
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )
(defun mutt ()
  (interactive)
  (setq mutts (find-buffers-named (buffer-list) "mutt" 0))
  (if (eq mutts 0)
      (progn
        (ansi-term (substring (shell-command-to-string "which mutt") 0 -1))
        (rename-buffer "mutt")
        )
    ))
(defun initial-ksh ()
  (interactive)
  (setq kshs (find-buffers-named (buffer-list) "ksh" 0))
  (if (eq kshs 0)
      (progn
        (ansi-term (substring (shell-command-to-string "which ksh") 0 -1))
        (rename-buffer "ksh")
	(process-send-string "ksh" ". ~/.profile\n")
        )
    )
  )

(defun cmus ()
  (interactive)
  (setq cmuss (find-buffers-named (buffer-list) "cmus" 0))
  (if (eq cmuss 0)
      (progn
        (ansi-term (substring (shell-command-to-string "which ksh") 0 -1))
		(rename-buffer "cmus")
		(process-send-string "cmus" "cmus\n")
        )
    )
  )

(defun restart-cmus()
  (interactive)
  (kill-matching-buffers "^cmus$")
  (progn
    (ansi-term (substring (shell-command-to-string "which ksh") 0 -1))
    (rename-buffer "cmus")
	(process-send-string "cmus" "cmus\n")
    ))

(defun find-buffers-named (buffers name count)
  (interactive)
  (if buffers
      (if (string-match name (format "^%s" (car buffers)))
          (find-buffers-named (cdr buffers) name (+ 1 count))
        (find-buffers-named (cdr buffers) name count))
    count))

(defun new-ksh ()
  (interactive)
  (ansi-term (substring (shell-command-to-string "which ksh") 0 -1))
  (setq kshs (find-buffers-named (buffer-list) "ksh" 0))
  (if (eq kshs 0)
      (progn (rename-buffer "ksh")
		(process-send-string "ksh" ". ~/.profile\n"))
    (progn (rename-buffer (format "ksh%d" (+ 1 kshs)))
	   (process-send-string (format "ksh%d" (+ 1 kshs)) ". ~/.profile\n"))
	 )
    )

; Run mutt, cmus, and a sh shell on startup
(mutt)
(cmus)
(initial-ksh)

(use-package python-mode
  :ensure t
  :init
  (setq py-python-command "/usr/local/bin/python3")
  (setq flymake-python-pyflakes-executable "flake8")
  (setq flymake-hlint-executable "~/.cabal/bin/hlint")
  (add-hook  'python-mode 'hightlight-indentation-mode)
  :config
  (define-key python-mode-map (kbd "C-c C-l") 'py-execute-buffer-no-switch)
  )

(use-package go-mode
  :ensure t
  :init
  (add-hook 'before-save-hook 'gofmt-before-save)
  :config
  (define-key go-mode-map (kbd "C-c C-e") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB"))
  (define-key go-mode-map (kbd "C-c C-p") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB panic(\"\") <left> <left>"))
  (define-key go-mode-map (kbd "C-c C-n") (kbd "if SPC err SPC != SPC nil SPC { RET TAB return SPC nil, SPC err RET } RET"))
  (define-key go-mode-map (kbd "C-c C-l") 'go-build)
  (define-key go-mode-map (kbd "C-c C-c") 'ac-complete-go)
  (defun go-build ()
	(interactive)
	(eshell-command (format "go build %s" buffer-file-name)))
  )
(use-package go-autocomplete
  :ensure t)
(require 'auto-complete-config)
(ac-config-default)

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "f" 'find-file)
  (evil-leader/set-key-for-mode 'c-mode "s" 'cscope-find-this-symbol)
  (evil-leader/set-key-for-mode 'c-mode "=" 'cscope-find-assignments-to-this-symbol)
  (evil-leader/set-key-for-mode 'c-mode "g" 'cscope-find-global-definition-no-prompting)
  (evil-leader/set-key-for-mode 'c-mode "G" 'cscope-find-global-definition)
  (evil-leader/set-key-for-mode 'c-mode "c" 'cscope-find-functions-calling-this-function)
  (evil-leader/set-key-for-mode 'c-mode "C" 'cscope-find-called-functions)
  (evil-leader/set-key-for-mode 'c-mode "t" 'cscope-find-this-text-string)
  (evil-leader/set-key-for-mode 'c-mode "f" 'cscope-find-this-file)
  (evil-leader/set-key-for-mode 'c-mode "i" 'cscope-find-files-including-file)
  )



(use-package xcscope
  :ensure t
  :config
  (define-key cscope-minor-mode-keymap (kbd "C-c s s") 'cscope-find-this-symbol)
  (define-key cscope-minor-mode-keymap (kbd "C-c s =") 'cscope-find-assignments-to-this-symbol)
  (define-key cscope-minor-mode-keymap (kbd "C-c s d") 'cscope-find-global-definition)
  (define-key cscope-minor-mode-keymap (kbd "C-c s D") 'cscope-find-global-definition-no-prompting)
  (define-key cscope-minor-mode-keymap (kbd "C-c s c") 'cscope-find-functions-calling-this-function)
  (define-key cscope-minor-mode-keymap (kbd "C-c s C") 'cscope-find-called-functions)
  (define-key cscope-minor-mode-keymap (kbd "C-c s t") 'cscope-find-this-text-string)
  (define-key cscope-minor-mode-keymap (kbd "C-c s f") 'cscope-find-this-file)
  (define-key cscope-minor-mode-keymap (kbd "C-c s i") 'cscope-find-files-including-file)
  (add-hook 'c-mode-hook 'cscope-minor-mode))

(setq backup-by-copying t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq column-number-mode t)
(use-package smooth-scrolling
  :ensure t
  :init
  (smooth-scrolling-mode 1)
  )

(setq jekyll-drafts-blog "/Users/brendangood/b-t-g.github.io/src/drafts")
(setq jekyll-pdfs-blog "/Users/brendangood/b-t-g.github.io/pdfs")
(defun pub-pdf-post ()
  (interactive)
  (setq command (format "mv %s/%s.pdf %s" jekyll-drafts-blog (substring (buffer-name (current-buffer)) 0 -4) jekyll-pdfs-blog))
  (progn
	 (org-latex-export-to-pdf)
	 (shell-command command)
	 (org2jekyll-publish)))
(setq indent-tabs-mode nil)
(setq-default tab-width 4)
(use-package org2jekyll
  :defer 3
  :config
  (setq org2jekyll-blog-author       "Brendan Good")
  (setq org2jekyll-source-directory  (expand-file-name "~/b-t-g.github.io/src/drafts"))
  (setq org2jekyll-jekyll-directory  (expand-file-name "~/b-t-g.github.io"))
  (setq org2jekyll-jekyll-drafts-dir "")
  (setq org2jekyll-jekyll-posts-dir  "_posts/")
  (setq org-publish-project-alist `(("default"
                             :base-directory ,(org2jekyll-input-directory)
                             :base-extension "org"
                             :publishing-directory ,(org2jekyll-output-directory)
                             :publishing-function org-html-publish-to-html
                             :headline-levels 4
                             :section-numbers nil
                             :with-toc nil
                             :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                             :html-preamble t
                             :recursive t
                             :make-index t
                             :html-extension "html"
                             :body-only t)

                            ("post"
                             :base-directory ,(org2jekyll-input-directory)
                             :base-extension "org"
                             :publishing-directory ,(org2jekyll-output-directory org2jekyll-jekyll-posts-dir)
                             :publishing-function org-html-publish-to-html
                             :headline-levels 4
                             :section-numbers nil
                             :with-toc nil
                             :html-head "<link rel=\"stylesheet\" href=\"./css/style.css\" type=\"text/css\"/>"
                             :html-preamble t
                             :recursive t
                             :make-index t
                             :html-extension "html"
                             :body-only t)

                            ("images"
                             :base-directory ,(org2jekyll-input-directory "img")
                             :base-extension "jpg\\|gif\\|png"
                             :publishing-directory ,(org2jekyll-output-directory "img")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ("js"
                             :base-directory ,(org2jekyll-input-directory "js")
                             :base-extension "js"
                             :publishing-directory ,(org2jekyll-output-directory "js")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ("css"
                             :base-directory ,(org2jekyll-input-directory "css")
                             :base-extension "css\\|el"
                             :publishing-directory ,(org2jekyll-output-directory "css")
                             :publishing-function org-publish-attachment
                             :recursive t)

                            ("web" :components ("images" "js" "css")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(company-lsp lsp-mode smooth-scrolling scala-mode sbt-mode rust-playground ruby-tools ruby-end ruby-compilation rainbow-delimiters proof-general pdf-tools pandoc org2jekyll org-re-reveal nhexl-mode merlin magithub lfe-mode key-chord julia-mode js2-mode java-imports j-mode intero idris-mode highlight-indentation helm-projectile haskell-emacs gotest gorepl-mode google-this go-autocomplete go-add-tags git geiser fuzzy flymake-python-pyflakes flymake-hlint flycheck-yamllint flycheck-tip flycheck-gometalinter flycheck-elixir flx-ido feature-mode evil-org evil-matchit evil-magit evil-leader ess enh-ruby-mode dumb-jump diminish ctags-update ctags company-irony company-go company-erlang company-distel color-theme-modern clojure-quick-repls clj-refactor auto-complete-clang-async alchemist ace-flyspell ac-inf-ruby ac-etags ac-clang ac-cider))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
