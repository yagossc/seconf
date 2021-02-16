;; This file replaces itself with the actual configuration at first run.

;; We can't tangle without org!
(require 'org)

;; Read seconf configuration
(find-file (expand-file-name "seconf.org" user-emacs-directory))

;; tangle it (only emacs-lisp source code)
(org-babel-tangle nil nil "emacs-lisp")

;; rename: eos to init
(rename-file
 (expand-file-name "seconf.el" user-emacs-directory)
 (expand-file-name "init.el" user-emacs-directory)
 ;; OK-IF-ALREADY-EXISTS
 t)

;; finally byte-compile it
(byte-compile-file (concat user-emacs-directory "init.el"))
