;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; File name: ` ~/.emacs '
;;; ---------------------
;;;
;;; If you need your own personal ~/.emacs
;;; please make a copy of this file
;;; an placein your changes and/or extension.
;;;
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
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)
;;;
)
;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)

(require 'package)
(custom-set-variables
 '(package-archives
 (quote
 (("gnu" . "http://elpa.gnu.org/packages/")
  ("melpa-stable" . "http://stable.melpa.org/packages/")))))

(add-to-list 'load-path "/home/brendan/.emacs.d/lisp")
(require 'key-chord)
(key-chord-mode 1)
; (setq x-meta-keysym 'super) (setq x-super-keysym 'meta)
(key-chord-define-global "HH" "()\C-b")
(key-chord-define-global "\"\"" "\"\"\C-b")
(key-chord-define-global "TT" "{}\C-b")
(key-chord-define-global "NN" "$$\C-b")
(key-chord-define-global "SS" "[]\C-b")
(key-chord-define-global "<>" "<>\C-b")
(with-eval-after-load 'evil-maps)
  (define-key evil-motion-state-map (kbd ":") 'evil-repeat-find-char)
 (define-key evil-motion-state-map (kbd ";") 'evil-ex)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "M-s M-h") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "M-s M-s") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))

(global-set-key (kbd "C-x M-p") 'windmove-up)
(global-set-key (kbd "C-x M-n") 'windmove-down)
(eval-after-load 'ruby-mode '(progn
			       (define-key ruby-mode-map (kbd "M-s M-h") 'ruby-load-file)
			       (define-key ruby-mode-map (kbd "M-s M-s") 'inf-ruby)))
(setq haskell-tags-on-save t)
(require 'evil-magit)
(require 'org)
(require 'evil-org)
(setq path-to-ctags "/usr/bin/ctags")
(defun create-tags (dir-name)
    "Create tags file."
        (interactive "DDirectory: ")
            (shell-command
                 (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
              )

(add-hook 'haskell-mode-hook 'intero-mode)
(load-theme 'high-contrast t t)
(enable-theme 'high-contrast)
