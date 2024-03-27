;; This file replaces itself with the actual configuration at first run.

;; We can't tangle without org!
(require 'org)

;; Read seconf configuration
(find-file (expand-file-name "v2.org" user-emacs-directory))

(org-org-export-to-org)

(find-file (expand-file-name "init.org" user-emacs-directory))

;; tangle it (only emacs-lisp source code)
(org-babel-tangle nil nil "emacs-lisp")

;; rename: seconf.el to init.el
 ;; (rename-file
 ;;  (expand-file-name "v2.el" user-emacs-directory)
 ;;  (expand-file-name "init.el" user-emacs-directory)
 ;;  ;;OK-IF-ALREADY-EXISTS
 ;;  t)

;; finally byte-compile it
(byte-compile-file (concat user-emacs-directory "init.el"))
