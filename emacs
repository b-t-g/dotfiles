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
  (setq custom-file "~/.gnu-emacs-custom")
  (load "~/.gnu-emacs-custom" t t)
;;;
  )
;;;
(server-start)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'package)
(custom-set-variables
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")))))
                                        ;(autoload 'key-chord "key-chord" "key-choard" t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key (kbd "C-x n a") 'rename-buffer)
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
(key-chord-define-global "#$" 'find-file)
(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(define-key evil-insert-state-map "\C-a" nil)
(define-key evil-insert-state-map "\C-k" nil)
(define-key evil-insert-state-map "\C-d" nil)
(define-key evil-insert-state-map "\C-w" nil)
(define-key evil-insert-state-map "\C-e" nil)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

(global-set-key (kbd "C-c p") 'helm-projectile)
(require 'highlight-indentation)
(set-face-background 'highlight-indentation-face "#aaaaff")

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))
(eval-after-load 'ruby-mode '(progn
                               (define-key ruby-mode-map (kbd "M-s M-h") 'ruby-load-file)
                               (define-key ruby-mode-map (kbd "M-s M-s") 'inf-ruby)))
(setq haskell-tags-on-save t)
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

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
(defun initial-zsh ()
  (interactive)
  (setq zshs (find-buffers-named (buffer-list) "zsh" 0))
  (if (eq zshs 0)
      (progn
        (ansi-term (substring (shell-command-to-string "which zsh") 0 -1))
        (rename-buffer "zsh")
        )
    )
  )

(defun cmus ()
  (interactive)
  (setq cmuss (find-buffers-named (buffer-list) "cmus" 0))
  (if (eq cmuss 0)
      (progn
        (ansi-term (substring (shell-command-to-string "which zsh") 0 -1))
		(rename-buffer "cmus")
		(process-send-string "cmus" "cmus\n")
        )
    )
  )

(defun restart-cmus()
  (interactive)
  (kill-matching-buffers "^cmus$")
  (progn
    (ansi-term (substring (shell-command-to-string "which zsh") 0 -1))
    (rename-buffer "cmus")
	(process-send-string "cmus" "cmus\n")
    ))

(defun find-buffers-named (buffers name count)
  (interactive)
  (if buffers
      (if (string-match name (format "%s" (car buffers)))
          (find-buffers-named (cdr buffers) name (+ 1 count))
        (find-buffers-named (cdr buffers) name count))
    count))

(defun new-zsh ()
  (interactive)
  (ansi-term (substring (shell-command-to-string "which zsh") 0 -1))
  (setq zshs (find-buffers-named (buffer-list) "zsh" 0))
  (if (eq zshs 0)
      (rename-buffer "zsh")
    (rename-buffer (format "zsh%d" (+ 1 zshs)))
    )
  )

; Run mutt, cmus, and a zsh shell on startup
(mutt)
(cmus)
(initial-zsh)

(add-hook 'python-mode-hook #'(lambda () (setq py-python-command "/usr/local/bin/python3")))
(setq flymake-python-pyflakes-executable "flake8")
(setq flymake-hlint-executable "~/.cabal/bin/hlint")
(add-hook 'python-mode-hook 'highlight-indentation-mode)
(eval-after-load 'python-mode '(progn
                                 (define-key python-mode-map (kbd "C-c C-l") 'py-execute-buffer-no-switch)))

(defun go-build ()
  (interactive)
  (eshell-command (format "go build %s" buffer-file-name)))
(eval-after-load 'go-mode '(progn
                             (define-key go-mode-map (kbd "C-c C-e") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB"))
                             (define-key go-mode-map (kbd "C-c C-p") (kbd "if SPC err SPC != SPC nil SPC { RET RET } <up> TAB panic(\"\") <left> <left>"))
                             (define-key go-mode-map (kbd "C-c C-n") (kbd "if SPC err SPC != SPC nil SPC { RET TAB return SPC nil, SPC err RET } RET"))
                             (define-key go-mode-map (kbd "C-c C-l") 'go-build)
                             (define-key go-mode-map (kbd "C-c C-c") 'ac-complete-go)
                             (add-hook 'before-save-hook 'gofmt-before-save)
                             ))
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(require 'ac-clang)

(setq backup-by-copying t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq column-number-mode t)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(setq indent-tabs-mode nil)
(setq-default tab-width 4)
(autoload 'magit "magit" "magit" t)

(eval-after-load 'term-mode '(progn
							   (define-key term-mode-map "\C-c" nil)))
