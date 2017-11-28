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

(setq indent-tabs-mode nil)
(setq-default tab-width 4)
(require 'package)
(custom-set-variables
 '(package-archives
 (quote
 (("gnu" . "http://elpa.gnu.org/packages/")
  ("melpa-stable" . "http://stable.melpa.org/packages/")))))
;(autoload 'key-chord "key-chord" "key-choard" t)
(autoload 'magit "magit" "magit" t)
(autoload 'ensime "ensime" "ensime" t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(key-chord-mode 1)
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
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(require 'evil-matchit)
(global-evil-matchit-mode 1)
(global-set-key (kbd "C-c p") 'helm-projectile)
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#aaaaff")

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

(eval-after-load 'ruby-mode '(progn
                               (define-key ruby-mode-map (kbd "M-s M-h") 'ruby-load-file)
                               (define-key ruby-mode-map (kbd "M-s M-s") 'inf-ruby)))
(setq haskell-tags-on-save t)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(setq path-to-ctags "/usr/local/bin/ctags")
(defun create-tags (dir-name)
    "Create tags file."
        (interactive "DDirectory: ")
            (shell-command
                 (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
              )
(defun go-build ()
  (interactive)
  (eshell-command (format "go build %s" buffer-file-name)))

(add-hook 'haskell-mode-hook 'intero-mode)
(setq backup-by-copying t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq column-number-mode t)
(add-hook 'python-mode-hook #'(lambda () (setq py-python-command "/usr/local/bin/python3")))
(setq flymake-python-pyflakes-executable "flake8")
(setq flymake-hlint-executable "~/.cabal/bin/hlint")
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(eval-after-load 'go-mode '(progn
                             (setq indent-tabs-mode nil)
                             (setq-default tab-width 4)
                             (define-key go-mode-map (kbd "C-c C-e") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB"))
                             (define-key go-mode-map (kbd "C-c C-p") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB panic(\"\") <left> <left>"))
                             (define-key go-mode-map (kbd "C-c C-n") (kbd "if SPC err SPC != SPC nil SPC { RET TAB return SPC nil, SPC err RET } RET"))
                             (define-key go-mode-map (kbd "C-c C-l") 'go-build)))
