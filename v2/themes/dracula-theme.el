;;; dracula-theme.el --- Dracula Theme

;; Copyright 2015-present, All rights reserved
;;
;; Code licensed under the MIT license

;; Maintainer: Étienne Deparis <etienne@depar.is>
;; Author: film42
;; Version: 1.8.2
;; Package-Requires: ((emacs "24.3"))
;; URL: https://github.com/dracula/emacs

;;; Commentary:

;; A dark color theme available for a number of editors.
;; This theme tries as much as possible to follow the consensual
;; specification (see URL `https://spec.draculatheme.com/').

;;; News:

;;;; Version 1.8.2

;; Fix ansi-color definition
;; Support solaire-mode

;;;; Version 1.8.1

;; Fix missing 1.8.0 docstring...

;;;; Version 1.8.0

;; New package support:
;;
;; - Add support for ansi-color-names-vector
;; - Add support for bookmark-face
;; - Add support for (e)diff-mode. Add dark-red and dark-green new colors
;; - Add support for eldoc-box
;; - Add support for elfeed
;; - Add support for gemini-mode and elpher
;; - Add support for go-test
;; - Add support for header-line
;; - Add support for ivy
;; - Add support for lsp-ui
;; - Add support for neotree
;; - Add support for perspective and mini-modeline
;; - Add support for reStructuredText
;; - Add support for selectrum-mode
;; - Add support for shadow-face
;; - Add support for speedbar
;; - Add support for telephone-line
;; - Add support for tooltip-face
;; - Add support for tree-sitter and add missing font-lock faces
;; - Add support for web-mode-css-property-name-face
;; - Add support for which-key-mode
;;
;; - Fix ‘message-cited-text-*’ colors
;; - Use same color for gnus than message mode and old mu4e-view mode
;; - Follow dracula color specs for Markdown and Org mode
;; - Improve readability of company colors
;; - Improve default mode-line colors
;; - Set powerline active and inactive dracula colors
;; - Improve completions (from minibuffer.el) colors
;;
;; Terminal related things:
;;
;; - Try a new 256 colors palette
;; - Add a setting to force 24bit colors on 256 colors terms
;; - Do not advertize dracula-use-24-bit-colors-on-256-colors-terms in README
;; - Avoid black and black text for TUI applications
;; - Use a dark menubar on terminals
;;
;; Tests related things:
;;
;; - Improve a little test script
;; - Avoid auto-save-default folder creation in test profile
;; - Remove test profile from melpa package content
;;
;; README related things:
;;
;; - Remove outdated homebrew instructions
;; - Update screenshot
;; - Update install instruction to advertize NonGNU Elpa
;; - Update README configure section with correct names.
;; - 📃 Standardize docs with other dracula repositories
;;
;; Others:
;;
;; - Fix comment before color listing
;; - Use unspecified-bg/-fg instead of nil color spec
;; - Use inherit highlight for two matching company faces
;; - Remove useless , in front of inherited faces
;; - Remove cl-lib dependency
;; - Reduce eval call scope
;; - Little change to file metadata
;; - Remove some unspecified color specifications
;; - Alphabetically sort basic faces settings
;; - Move mode-line faces in basic faces section
;; - Little adjustments for eglot package
;; - Remove bg3 as it was very similar to dracula-current
;; - Rename other-blue to dark-blue
;; - Colorize shr title as in the other markup modes
;; - Improve magit faces
;;

;;; Code:
(deftheme dracula)


;;;; Configuration options:

(defgroup dracula nil
  "Dracula theme options.

The theme has to be reloaded after changing anything in this group."
  :group 'faces)

(defcustom dracula-enlarge-headings t
  "Use different font sizes for some headings and titles."
  :type 'boolean
  :group 'dracula)

(defcustom dracula-height-title-1 1.3
  "Font size 100%."
  :type 'number
  :group 'dracula)

(defcustom dracula-height-title-2 1.1
  "Font size 110%."
  :type 'number
  :group 'dracula)

(defcustom dracula-height-title-3 1.0
  "Font size 130%."
  :type 'number
  :group 'dracula)

(defcustom dracula-height-doc-title 1.44
  "Font size 144%."
  :type 'number
  :group 'dracula)

(defcustom dracula-alternate-mode-line-and-minibuffer nil
  "Use less bold and pink in the minibuffer."
  :type 'boolean
  :group 'dracula)

(defvar dracula-use-24-bit-colors-on-256-colors-terms nil
  "Use true colors even on terminals announcing less capabilities.

Beware the use of this variable.  Using it may lead to unwanted
behavior, the most common one being an ugly blue background on
terminals, which don't understand 24 bit colors.  To avoid this
blue background, when using this variable, one can try to add the
following lines in their config file after having load the
Dracula theme:

    (unless (display-graphic-p)
      (set-face-background \\='default \"black\" nil))

There is a lot of discussion behind the 256 colors theme (see URL
`https://github.com/dracula/emacs/pull/57').  Please take time to
read it before opening a new issue about your will.")


;;;; Theme definition:

;; Assigment form: VARIABLE COLOR [256-COLOR [TTY-COLOR]]
(let ((colors '(;; Upstream theme color
                (dracula-bg      "#282a36" "unspecified-bg" "unspecified-bg") ; official background
                (dracula-fg      "#f8f8f2" "#ffffff" "brightwhite") ; official foreground
                (dracula-current "#44475a" "#303030" "brightblack") ; official current-line/selection
                (dracula-comment "#6272a4" "#5f5faf" "blue")        ; official comment
                (dracula-cyan    "#8be9fd" "#87d7ff" "brightcyan")  ; official cyan
                (dracula-green   "#50fa7b" "#5fff87" "green")       ; official green
                (dracula-orange  "#ffb86c" "#ffaf5f" "brightred")   ; official orange
                (dracula-pink    "#ff79c6" "#ff87d7" "magenta")     ; official pink
                (dracula-purple  "#bd93f9" "#af87ff" "brightmagenta") ; official purple
                (dracula-red     "#ff5555" "#ff8787" "red")         ; official red
                (dracula-yellow  "#f1fa8c" "#ffff87" "yellow")      ; official yellow
                ;; Other colors
                (bg2             "#373844" "#121212" "brightblack")
                (bg3             "#565761" "#444444" "brightblack")
                (fg2             "#e2e2dc" "#e4e4e4" "brightwhite")
                (fg3             "#ccccc7" "#c6c6c6" "white")
                (fg4             "#b6b6b2" "#b2b2b2" "white")
                (dark-red        "#880000" "#870000" "red") ; 40% darker
                (dark-green      "#037a22" "#00af00" "green") ; 40% darker
                (dark-blue       "#0189cc" "#0087ff" "brightblue")))
      (faces '(;; default / basic faces
               (cursor :background ,fg3)
               (default :background ,dracula-bg :foreground ,dracula-fg)
               (default-italic :slant italic)
               (error :foreground ,dracula-red)
               (ffap :foreground ,fg4)
               (fringe :background ,dracula-bg :foreground ,fg4)
               (header-line :inherit 'mode-line)
               (highlight :foreground ,fg3 :background ,dracula-current)
               (hl-line :background ,dracula-current :extend t)
               (info-quoted-name :foreground ,dracula-orange)
               (info-string :foreground ,dracula-yellow)
               (lazy-highlight :foreground ,fg2 :background ,bg2)
               (link :foreground ,dracula-cyan :underline t)
               (linum :slant italic :foreground ,bg3 :background ,dracula-bg)
               (line-number :slant italic :foreground ,bg3 :background ,dracula-bg)
               (match :background ,dracula-yellow :foreground ,dracula-bg)
               (menu :background ,dracula-current :inverse-video nil
                     ,@(if dracula-alternate-mode-line-and-minibuffer
                           (list :foreground fg3)
                         (list :foreground dracula-fg)))
               (minibuffer-prompt
                ,@(if dracula-alternate-mode-line-and-minibuffer
                      (list :weight 'normal :foreground dracula-fg)
                    (list :weight 'bold :foreground dracula-pink)))
               (mode-line :background ,dracula-current
                          :box ,dracula-current :inverse-video nil
                          ,@(if dracula-alternate-mode-line-and-minibuffer
                                (list :foreground fg3)
                              (list :foreground dracula-fg)))
               (mode-line-inactive
                :background ,dracula-bg :inverse-video nil
                ,@(if dracula-alternate-mode-line-and-minibuffer
                      (list :foreground dracula-comment :box dracula-bg)
                    (list :foreground fg4 :box bg2)))
               (read-multiple-choice-face :inherit completions-first-difference)
               (region :inherit match :extend t)
               (shadow :foreground ,dracula-comment)
               (success :foreground ,dracula-green)
               (tooltip :foreground ,dracula-fg :background ,dracula-current)
               (trailing-whitespace :background ,dracula-orange)
               (vertical-border :foreground ,bg2)
               (warning :foreground ,dracula-orange)

               ;; syntax / font-lock
               (font-lock-builtin-face :foreground ,dracula-cyan :slant italic)
               (font-lock-comment-face :inherit shadow)
               (font-lock-comment-delimiter-face :inherit shadow)
               (font-lock-constant-face :foreground ,dracula-purple)
               (font-lock-doc-face :foreground ,dracula-comment)
               (font-lock-function-name-face :foreground ,dracula-green :weight bold)
               (font-lock-keyword-face :foreground ,dracula-pink :weight bold)
               (font-lock-negation-char-face :foreground ,dracula-cyan)
               (font-lock-number-face :foreground ,dracula-purple)
               (font-lock-operator-face :foreground ,dracula-pink)
               (font-lock-preprocessor-face :foreground ,dracula-orange)
               (font-lock-reference-face :inherit font-lock-constant-face) ;; obsolete
               (font-lock-regexp-grouping-backslash :foreground ,dracula-cyan)
               (font-lock-regexp-grouping-construct :foreground ,dracula-purple)
               (font-lock-string-face :foreground ,dracula-yellow)
               (font-lock-type-face :inherit font-lock-builtin-face)
               (font-lock-variable-name-face :foreground ,dracula-fg :weight bold)
               (font-lock-warning-face :inherit warning :background ,bg2)

               ;; ansi-color
               (ansi-color-black :foreground ,dracula-bg :background ,dracula-bg)
               (ansi-color-bright-black :foreground "black" :background "black")
               (ansi-color-blue :foreground ,dracula-purple :background ,dracula-purple)
               (ansi-color-bright-blue :foreground ,dracula-purple
                                       :background ,dracula-purple
                                       :weight bold)
               (ansi-color-cyan :foreground ,dracula-cyan :background ,dracula-cyan)
               (ansi-color-bright-cyan :foreground ,dracula-cyan
                                       :background ,dracula-cyan
                                       :weight bold)
               (ansi-color-green :foreground ,dracula-green :background ,dracula-green)
               (ansi-color-bright-green :foreground ,dracula-green
                                        :background ,dracula-green
                                        :weight bold)
               (ansi-color-magenta :foreground ,dracula-pink :background ,dracula-pink)
               (ansi-color-bright-magenta :foreground ,dracula-pink
                                          :background ,dracula-pink
                                          :weight bold)
               (ansi-color-red :foreground ,dracula-red :background ,dracula-red)
               (ansi-color-bright-red :foreground ,dracula-red
                                      :background ,dracula-red
                                      :weight bold)
               (ansi-color-white :foreground ,dracula-fg :background ,dracula-fg)
               (ansi-color-bright-white :foreground "white" :background "white")
               (ansi-color-yellow :foreground ,dracula-yellow :background ,dracula-yellow)
               (ansi-color-bright-yellow :foreground ,dracula-yellow
                                         :background ,dracula-yellow
                                         :weight bold)
               ;; bookmarks
               (bookmark-face :foreground ,dracula-pink)

               ;; completions (minibuffer.el)
               (completions-annotations :inherit font-lock-comment-face)
               (completions-common-part :foreground ,dracula-green)
               (completions-first-difference :foreground ,dracula-pink :weight bold)

               ;; diff
               (diff-added :background ,dark-green :foreground ,dracula-fg :extend t)
               (diff-removed :background ,dark-red :foreground ,dracula-fg :extend t)
               (diff-refine-added :background ,dracula-green
                                  :foreground ,dracula-bg)
               (diff-refine-removed :background ,dracula-red
                                    :foreground ,dracula-fg)
               (diff-indicator-added :foreground ,dracula-green)
               (diff-indicator-removed :foreground ,dracula-red)
               (diff-indicator-changed :foreground ,dracula-orange)
               (diff-error :foreground ,dracula-red, :background ,dracula-bg
                           :weight bold)

               ;; diff-hl
               (diff-hl-change :foreground ,dracula-orange :background ,dracula-orange)
               (diff-hl-delete :foreground ,dracula-red :background ,dracula-red)
               (diff-hl-insert :foreground ,dracula-green :background ,dracula-green)

               ;; dired
               (dired-directory :foreground ,dracula-green :weight normal)
               (dired-flagged :foreground ,dracula-pink)
               (dired-header :foreground ,fg3 :background ,dracula-bg)
               (dired-ignored :inherit shadow)
               (dired-mark :foreground ,dracula-fg :weight bold)
               (dired-marked :foreground ,dracula-orange :weight bold)
               (dired-perm-write :foreground ,fg3 :underline t)
               (dired-symlink :foreground ,dracula-yellow :weight normal :slant italic)
               (dired-warning :foreground ,dracula-orange :underline t)
               (diredp-compressed-file-name :foreground ,fg3)
               (diredp-compressed-file-suffix :foreground ,fg4)
               (diredp-date-time :foreground ,dracula-fg)
               (diredp-deletion-file-name :foreground ,dracula-pink :background ,dracula-current)
               (diredp-deletion :foreground ,dracula-pink :weight bold)
               (diredp-dir-heading :foreground ,fg2 :background ,bg3)
               (diredp-dir-name :inherit dired-directory)
               (diredp-dir-priv :inherit dired-directory)
               (diredp-executable-tag :foreground ,dracula-orange)
               (diredp-file-name :foreground ,dracula-fg)
               (diredp-file-suffix :foreground ,fg4)
               (diredp-flag-mark-line :foreground ,fg2 :slant italic :background ,dracula-current)
               (diredp-flag-mark :foreground ,fg2 :weight bold :background ,dracula-current)
               (diredp-ignored-file-name :foreground ,dracula-fg)
               (diredp-mode-line-flagged :foreground ,dracula-orange)
               (diredp-mode-line-marked :foreground ,dracula-orange)
               (diredp-no-priv :foreground ,dracula-fg)
               (diredp-number :foreground ,dracula-cyan)
               (diredp-other-priv :foreground ,dracula-orange)
               (diredp-rare-priv :foreground ,dracula-orange)
               (diredp-read-priv :foreground ,dracula-purple)
               (diredp-write-priv :foreground ,dracula-pink)
               (diredp-exec-priv :foreground ,dracula-yellow)
               (diredp-symlink :foreground ,dracula-orange)
               (diredp-link-priv :foreground ,dracula-orange)
               (diredp-autofile-name :foreground ,dracula-yellow)
               (diredp-tagged-autofile-name :foreground ,dracula-yellow)

               ;; ediff
               (ediff-current-diff-A :background ,dark-red)
               (ediff-fine-diff-A :background ,dracula-red :foreground ,dracula-fg)
               (ediff-current-diff-B :background ,dark-green)
               (ediff-fine-diff-B :background ,dracula-green :foreground ,dracula-bg)
               (ediff-current-diff-C :background ,dark-blue)
               (ediff-fine-diff-C :background ,dracula-cyan :foreground ,dracula-bg)

               ;; eglot
               (eglot-diagnostic-tag-unnecessary-face :inherit warning)
               (eglot-diagnostic-tag-deprecated-face :inherit warning :strike-through t)

               ;; eldoc-box
               (eldoc-box-border :background ,dracula-current)
               (eldoc-box-body :background ,dracula-current)

               ;; elfeed
               (elfeed-search-date-face :foreground ,dracula-comment)
               (elfeed-search-title-face :foreground ,dracula-fg)
               (elfeed-search-unread-title-face :foreground ,dracula-pink :weight bold)
               (elfeed-search-feed-face :foreground ,dracula-fg :weight bold)
               (elfeed-search-tag-face :foreground ,dracula-green)
               (elfeed-search-last-update-face :weight bold)
               (elfeed-search-unread-count-face :foreground ,dracula-pink)
               (elfeed-search-filter-face :foreground ,dracula-green :weight bold)
               ;;(elfeed-log-date-face :inherit font-lock-type-face)
               (elfeed-log-error-level-face :foreground ,dracula-red)
               (elfeed-log-warn-level-face :foreground ,dracula-orange)
               (elfeed-log-info-level-face :foreground ,dracula-cyan)
               (elfeed-log-debug-level-face :foreground ,dracula-comment)

               ;; elpher
               (elpher-gemini-heading1 :inherit bold :foreground ,dracula-pink
                                       ,@(when dracula-enlarge-headings
                                           (list :height dracula-height-title-1)))
               (elpher-gemini-heading2 :inherit bold :foreground ,dracula-purple
                                       ,@(when dracula-enlarge-headings
                                           (list :height dracula-height-title-2)))
               (elpher-gemini-heading3 :weight normal :foreground ,dracula-green
                                       ,@(when dracula-enlarge-headings
                                           (list :height dracula-height-title-3)))
               (elpher-gemini-preformatted :inherit fixed-pitch
                                           :foreground ,dracula-orange)

               ;; flyspell
               (flyspell-duplicate :underline (:style wave :color ,dracula-orange))
               (flyspell-incorrect :underline (:style wave :color ,dracula-red))

               ;; font-latex
               (font-latex-bold-face :foreground ,dracula-purple)
               (font-latex-italic-face :foreground ,dracula-pink :slant italic)
               (font-latex-match-reference-keywords :foreground ,dracula-cyan)
               (font-latex-match-variable-keywords :foreground ,dracula-fg)
               (font-latex-string-face :foreground ,dracula-yellow)

               ;; gemini
               (gemini-heading-face-1 :inherit bold :foreground ,dracula-pink
                                      ,@(when dracula-enlarge-headings
                                          (list :height dracula-height-title-1)))
               (gemini-heading-face-2 :inherit bold :foreground ,dracula-purple
                                      ,@(when dracula-enlarge-headings
                                          (list :height dracula-height-title-2)))
               (gemini-heading-face-3 :weight normal :foreground ,dracula-green
                                      ,@(when dracula-enlarge-headings
                                          (list :height dracula-height-title-3)))
               (gemini-heading-face-rest :weight normal :foreground ,dracula-yellow)
               (gemini-quote-face :foreground ,dracula-purple)

               ;; go-test
               (go-test--ok-face :inherit success)
               (go-test--error-face :inherit error)
               (go-test--warning-face :inherit warning)
               (go-test--pointer-face :foreground ,dracula-pink)
               (go-test--standard-face :foreground ,dracula-cyan)

               ;; gnus-group
               (gnus-group-mail-1 :foreground ,dracula-pink :weight bold)
               (gnus-group-mail-1-empty :inherit gnus-group-mail-1 :weight normal)
               (gnus-group-mail-2 :foreground ,dracula-cyan :weight bold)
               (gnus-group-mail-2-empty :inherit gnus-group-mail-2 :weight normal)
               (gnus-group-mail-3 :foreground ,dracula-comment :weight bold)
               (gnus-group-mail-3-empty :inherit gnus-group-mail-3 :weight normal)
               (gnus-group-mail-low :foreground ,dracula-current :weight bold)
               (gnus-group-mail-low-empty :inherit gnus-group-mail-low :weight normal)
               (gnus-group-news-1 :foreground ,dracula-pink :weight bold)
               (gnus-group-news-1-empty :inherit gnus-group-news-1 :weight normal)
               (gnus-group-news-2 :foreground ,dracula-cyan :weight bold)
               (gnus-group-news-2-empty :inherit gnus-group-news-2 :weight normal)
               (gnus-group-news-3 :foreground ,dracula-comment :weight bold)
               (gnus-group-news-3-empty :inherit gnus-group-news-3 :weight normal)
               (gnus-group-news-4 :inherit gnus-group-news-low)
               (gnus-group-news-4-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-5 :inherit gnus-group-news-low)
               (gnus-group-news-5-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-6 :inherit gnus-group-news-low)
               (gnus-group-news-6-empty :inherit gnus-group-news-low-empty)
               (gnus-group-news-low :foreground ,dracula-current :weight bold)
               (gnus-group-news-low-empty :inherit gnus-group-news-low :weight normal)
               (gnus-header-content :foreground ,dracula-purple)
               (gnus-header-from :foreground ,dracula-fg)
               (gnus-header-name :foreground ,dracula-green)
               (gnus-header-subject :foreground ,dracula-pink :weight bold)
               (gnus-summary-markup-face :foreground ,dracula-cyan)
               (gnus-summary-high-unread :foreground ,dracula-pink :weight bold)
               (gnus-summary-high-read :inherit gnus-summary-high-unread :weight normal)
               (gnus-summary-high-ancient :inherit gnus-summary-high-read)
               (gnus-summary-high-ticked :inherit gnus-summary-high-read :underline t)
               (gnus-summary-normal-unread :foreground ,dark-blue :weight bold)
               (gnus-summary-normal-read :foreground ,dracula-comment :weight normal)
               (gnus-summary-normal-ancient :inherit gnus-summary-normal-read :weight light)
               (gnus-summary-normal-ticked :foreground ,dracula-pink :weight bold)
               (gnus-summary-low-unread :foreground ,dracula-comment :weight bold)
               (gnus-summary-low-read :inherit gnus-summary-low-unread :weight normal)
               (gnus-summary-low-ancient :inherit gnus-summary-low-read)
               (gnus-summary-low-ticked :inherit gnus-summary-low-read :underline t)
               (gnus-summary-selected :inverse-video t)

               ;; haskell-mode
               (haskell-operator-face :foreground ,dracula-pink)
               (haskell-constructor-face :foreground ,dracula-purple)

               ;; highlight-indentation minor mode
               (highlight-indentation-face :background ,bg2)

               ;; icomplete
               (icompletep-determined :foreground ,dracula-orange)

               ;; ido
               (ido-first-match
                ,@(if dracula-alternate-mode-line-and-minibuffer
                      (list :weight 'normal :foreground dracula-green)
                    (list :weight 'bold :foreground dracula-pink)))
               (ido-only-match :foreground ,dracula-orange)
               (ido-subdir :foreground ,dracula-yellow)
               (ido-virtual :foreground ,dracula-cyan)
               (ido-incomplete-regexp :inherit font-lock-warning-face)
               (ido-indicator :foreground ,dracula-fg :background ,dracula-pink)

               ;; isearch
               (isearch :inherit match :weight bold)
               (isearch-fail :foreground ,dracula-bg :background ,dracula-orange)

               ;; jde-java
               (jde-java-font-lock-constant-face :foreground ,dracula-cyan)
               (jde-java-font-lock-modifier-face :foreground ,dracula-pink)
               (jde-java-font-lock-number-face :foreground ,dracula-fg)
               (jde-java-font-lock-package-face :foreground ,dracula-fg)
               (jde-java-font-lock-private-face :foreground ,dracula-pink)
               (jde-java-font-lock-public-face :foreground ,dracula-pink)
               ;; js2-mode
               (js2-external-variable :foreground ,dracula-purple)
               (js2-function-param :foreground ,dracula-cyan)
               (js2-jsdoc-html-tag-delimiter :foreground ,dracula-yellow)
               (js2-jsdoc-html-tag-name :foreground ,dark-blue)
               (js2-jsdoc-value :foreground ,dracula-yellow)
               (js2-private-function-call :foreground ,dracula-cyan)
               (js2-private-member :foreground ,fg3)
               ;; js3-mode
               (js3-error-face :underline ,dracula-orange)
               (js3-external-variable-face :foreground ,dracula-fg)
               (js3-function-param-face :foreground ,dracula-pink)
               (js3-instance-member-face :foreground ,dracula-cyan)
               (js3-jsdoc-tag-face :foreground ,dracula-pink)
               (js3-warning-face :underline ,dracula-pink)

               ;; lsp
               (lsp-ui-peek-peek :background ,dracula-bg)
               (lsp-ui-peek-list :background ,bg2)
               (lsp-ui-peek-filename :foreground ,dracula-pink :weight bold)
               (lsp-ui-peek-line-number :foreground ,dracula-fg)
               (lsp-ui-peek-highlight :inherit highlight :distant-foreground ,dracula-bg)
               (lsp-ui-peek-header :background ,dracula-current :foreground ,fg3, :weight bold)
               (lsp-ui-peek-footer :inherit lsp-ui-peek-header)
               (lsp-ui-peek-selection :inherit match)
               (lsp-ui-sideline-symbol :foreground ,fg4 :box (:line-width -1 :color ,fg4) :height 0.99)
               (lsp-ui-sideline-current-symbol :foreground ,dracula-fg :weight ultra-bold
                                               :box (:line-width -1 :color dracula-fg) :height 0.99)
               (lsp-ui-sideline-code-action :foreground ,dracula-yellow)
               (lsp-ui-sideline-symbol-info :slant italic :height 0.99)
               (lsp-ui-doc-background :background ,dracula-bg)
               (lsp-ui-doc-header :foreground ,dracula-bg :background ,dracula-cyan)

               ;; magit
               (magit-branch-local :foreground ,dracula-cyan)
               (magit-branch-remote :foreground ,dracula-green)
               (magit-refname :foreground ,dark-blue)
               (magit-tag :foreground ,dracula-orange)
               (magit-hash :foreground ,dracula-comment)
               (magit-dimmed :foreground ,dracula-comment)
               (magit-section-heading :foreground ,dracula-pink :weight bold)
               (magit-section-highlight :background ,dracula-current :extend t)
               (magit-diff-context :foreground ,fg3 :extend t)
               (magit-diff-context-highlight :inherit magit-section-highlight
                                             :foreground ,dracula-fg)
               (magit-diff-revision-summary :foreground ,dracula-orange
                                            :background ,dracula-bg
                                            :weight bold)
               (magit-diff-revision-summary-highlight :inherit magit-section-highlight
                                                      :foreground ,dracula-orange
                                                      :weight bold)
               (magit-diff-added :background ,dracula-bg :foreground ,dracula-green)
               (magit-diff-added-highlight :background ,dracula-current
                                           :foreground ,dracula-green)
               (magit-diff-removed :background ,dracula-bg :foreground ,dracula-red)
               (magit-diff-removed-highlight :background ,dracula-current
                                             :foreground ,dracula-red)
               (magit-diff-file-heading :foreground ,dracula-fg)
               (magit-diff-file-heading-highlight :inherit magit-section-highlight
                                                  :weight bold)
               (magit-diff-file-heading-selection
                :inherit magit-diff-file-heading-highlight
                :foreground ,dracula-pink)
               (magit-diff-hunk-heading :inherit magit-diff-context
                                        :background ,bg3)
               (magit-diff-hunk-heading-highlight
                :inherit magit-diff-context-highlight
                :weight bold)
               (magit-diff-hunk-heading-selection
                :inherit magit-diff-hunk-heading-highlight
                :foreground ,dracula-pink)
               (magit-diff-lines-heading
                :inherit magit-diff-hunk-heading-highlight
                :foreground ,dracula-pink)
               (magit-diff-lines-boundary :background ,dracula-pink)
               (magit-diffstat-added :foreground ,dracula-green)
               (magit-diffstat-removed :foreground ,dracula-red)
               (magit-log-author :foreground ,dracula-comment)
               (magit-log-date :foreground ,dracula-comment)
               (magit-log-graph :foreground ,dracula-yellow)
               (magit-process-ng :foreground ,dracula-orange :weight bold)
               (magit-process-ok :foreground ,dracula-green :weight bold)
               (magit-signature-good :foreground ,dracula-green)
               (magit-signature-bad :foreground ,dracula-red :weight bold)
               (magit-signature-untrusted :foreground ,dracula-cyan)
               (magit-signature-expired :foreground ,dracula-orange)
               (magit-signature-revoked :foreground ,dracula-purple)
               (magit-signature-error :foreground ,dracula-cyan)
               (magit-cherry-unmatched :foreground ,dracula-cyan)
               (magit-cherry-equivalent :foreground ,dracula-purple)

               ;; markdown
               (markdown-blockquote-face :foreground ,dracula-yellow
                                         :slant italic)
               (markdown-code-face :foreground ,dracula-orange)
               (markdown-footnote-face :foreground ,dark-blue)
               (markdown-header-face :weight normal)
               (markdown-header-face-1
                :inherit bold :foreground ,dracula-pink
                ,@(when dracula-enlarge-headings
                    (list :height dracula-height-title-1)))
               (markdown-header-face-2
                :inherit bold :foreground ,dracula-purple
                ,@(when dracula-enlarge-headings
                    (list :height dracula-height-title-2)))
               (markdown-header-face-3
                :foreground ,dracula-green
                ,@(when dracula-enlarge-headings
                    (list :height dracula-height-title-3)))
               (markdown-header-face-4 :foreground ,dracula-yellow)
               (markdown-header-face-5 :foreground ,dracula-cyan)
               (markdown-header-face-6 :foreground ,dracula-orange)
               (markdown-header-face-7 :foreground ,dark-blue)
               (markdown-header-face-8 :foreground ,dracula-fg)
               (markdown-inline-code-face :foreground ,dracula-green)
               (markdown-plain-url-face :inherit link)
               (markdown-pre-face :foreground ,dracula-orange)
               (markdown-table-face :foreground ,dracula-purple)
               (markdown-list-face :foreground ,dracula-cyan)
               (markdown-language-keyword-face :foreground ,dracula-comment)

               ;; message
               (message-header-to :foreground ,dracula-fg :weight bold)
               (message-header-cc :foreground ,dracula-fg :bold bold)
               (message-header-subject :foreground ,dracula-orange)
               (message-header-newsgroups :foreground ,dracula-purple)
               (message-header-other :foreground ,dracula-purple)
               (message-header-name :foreground ,dracula-green)
               (message-header-xheader :foreground ,dracula-cyan)
               (message-separator :foreground ,dracula-cyan :slant italic)
               (message-cited-text :foreground ,dracula-purple)
               (message-cited-text-1 :foreground ,dracula-purple)
               (message-cited-text-2 :foreground ,dracula-orange)
               (message-cited-text-3 :foreground ,dracula-comment)
               (message-cited-text-4 :foreground ,fg2)
               (message-mml :foreground ,dracula-green :weight normal)

               ;; mini-modeline
               (mini-modeline-mode-line :inherit mode-line :height 0.1 :box nil)

               ;; neotree
               (neo-banner-face :foreground ,dracula-orange :weight bold)
               ;;(neo-button-face :underline nil)
               (neo-dir-link-face :foreground ,dracula-purple)
               (neo-expand-btn-face :foreground ,dracula-fg)
               (neo-file-link-face :foreground ,dracula-cyan)
               (neo-header-face :background ,dracula-bg
                                :foreground ,dracula-fg
                                :weight bold)
               (neo-root-dir-face :foreground ,dracula-purple :weight bold)
               (neo-vc-added-face :foreground ,dracula-orange)
               (neo-vc-conflict-face :foreground ,dracula-red)
               (neo-vc-default-face :inherit neo-file-link-face)
               (neo-vc-edited-face :foreground ,dracula-orange)
               (neo-vc-ignored-face :foreground ,dracula-comment)
               (neo-vc-missing-face :foreground ,dracula-red)
               (neo-vc-needs-merge-face :foreground ,dracula-red
                                        :weight bold)
               ;;(neo-vc-needs-update-face :underline t)
               ;;(neo-vc-removed-face :strike-through t)
               (neo-vc-unlocked-changes-face :foreground ,dracula-red)
               ;;(neo-vc-unregistered-face nil)
               (neo-vc-up-to-date-face :foreground ,dracula-green)
               (neo-vc-user-face :foreground ,dracula-purple)

               ;; org
               (org-agenda-date :foreground ,dracula-cyan :underline nil)
               (org-agenda-dimmed-todo-face :foreground ,dracula-comment)
               (org-agenda-done :foreground ,dracula-green)
               (org-agenda-structure :foreground ,dracula-purple)
               (org-block :background ,bg2, :foreground ,dracula-orange)
               ;; (org-block :foreground ,dracula-orange)
               (org-code :foreground ,dracula-green)
               (org-column :background ,bg3)
               (org-column-title :inherit org-column :weight bold :underline t)
               (org-date :foreground ,dracula-cyan :underline t)
               (org-document-info :foreground ,dark-blue)
               (org-document-info-keyword :foreground ,dracula-comment)
               (org-document-title :weight bold :foreground ,dracula-orange
                                   ,@(when dracula-enlarge-headings
                                       (list :height dracula-height-doc-title)))
               (org-done :foreground ,dracula-green)
               (org-ellipsis :foreground ,dracula-comment)
               (org-footnote :foreground ,dark-blue)
               (org-formula :foreground ,dracula-pink)
               (org-headline-done :foreground ,dracula-comment
                                  :weight normal :strike-through t)
               (org-hide :foreground ,dracula-bg :background ,dracula-bg)
               (org-level-1 :inherit bold :foreground ,dracula-pink
                            ,@(when dracula-enlarge-headings
                                (list :height dracula-height-title-1)))
               (org-level-2 :inherit bold :foreground ,dracula-purple
                            ,@(when dracula-enlarge-headings
                                (list :height dracula-height-title-2)))
               (org-level-3 :weight normal :foreground ,dracula-green
                            ,@(when dracula-enlarge-headings
                                (list :height dracula-height-title-3)))
               (org-level-4 :weight normal :foreground ,dracula-yellow)
               (org-level-5 :weight normal :foreground ,dracula-cyan)
               (org-level-6 :weight normal :foreground ,dracula-orange)
               (org-level-7 :weight normal :foreground ,dark-blue)
               (org-level-8 :weight normal :foreground ,dracula-fg)
               (org-link :foreground ,dracula-cyan :underline t)
               (org-priority :foreground ,dracula-cyan)
               (org-quote :foreground ,dracula-yellow :slant italic)
               (org-scheduled :foreground ,dracula-green)
               (org-scheduled-previously :foreground ,dracula-yellow)
               (org-scheduled-today :foreground ,dracula-green)
               (org-sexp-date :foreground ,fg4)
               (org-special-keyword :foreground ,dracula-yellow)
               (org-table :foreground ,dracula-purple)
               (org-tag :foreground ,dracula-pink :weight bold :background ,bg2)
               (org-todo :foreground ,dracula-orange :weight bold :background ,bg2)
               (org-upcoming-deadline :foreground ,dracula-yellow)
               (org-verbatim :inherit org-quote)
               (org-warning :weight bold :foreground ,dracula-pink)

               ;; outline
               (outline-1 :foreground ,dracula-pink)
               (outline-2 :foreground ,dracula-purple)
               (outline-3 :foreground ,dracula-green)
               (outline-4 :foreground ,dracula-yellow)
               (outline-5 :foreground ,dracula-cyan)
               (outline-6 :foreground ,dracula-orange)

               ;; rainbow-delimiters
               (rainbow-delimiters-depth-1-face :foreground ,dracula-fg)
               (rainbow-delimiters-depth-2-face :foreground ,dracula-cyan)
               (rainbow-delimiters-depth-3-face :foreground ,dracula-purple)
               (rainbow-delimiters-depth-4-face :foreground ,dracula-pink)
               (rainbow-delimiters-depth-5-face :foreground ,dracula-orange)
               (rainbow-delimiters-depth-6-face :foreground ,dracula-green)
               (rainbow-delimiters-depth-7-face :foreground ,dracula-yellow)
               (rainbow-delimiters-depth-8-face :foreground ,dark-blue)
               (rainbow-delimiters-unmatched-face :foreground ,dracula-orange)

               ;; show-paren
               (show-paren-match-face :background unspecified
                                      :foreground ,dracula-cyan
                                      :weight bold)
               (show-paren-match :background unspecified
                                 :foreground ,dracula-cyan
                                 :weight bold)
               (show-paren-match-expression :inherit match)
               (show-paren-mismatch :inherit font-lock-warning-face)

               ;; shr
               (shr-h1 :foreground ,dracula-pink :weight bold :height 1.3)
               (shr-h2 :foreground ,dracula-purple :weight bold)
               (shr-h3 :foreground ,dracula-green :slant italic)
               (shr-h4 :foreground ,dracula-yellow)
               (shr-h5 :foreground ,dracula-cyan)
               (shr-h6 :foreground ,dracula-orange)

               ;; spam
               (spam :inherit gnus-summary-normal-read :foreground ,dracula-orange
                     :strike-through t :slant oblique)

               ;; speedbar (and sr-speedbar)
               (speedbar-button-face :foreground ,dracula-green)
               (speedbar-file-face :foreground ,dracula-cyan)
               (speedbar-directory-face :foreground ,dracula-purple)
               (speedbar-tag-face :foreground ,dracula-yellow)
               (speedbar-selected-face :foreground ,dracula-pink)
               (speedbar-highlight-face :inherit match)
               (speedbar-separator-face :background ,dracula-bg
                                        :foreground ,dracula-fg
                                        :weight bold)

               ;; tab-bar & tab-line (since Emacs 27.1)
               (tab-bar :foreground ,dracula-purple :background ,dracula-current
                        :inherit variable-pitch)
               (tab-bar-tab :foreground ,dracula-pink :background ,dracula-bg
                            :box (:line-width 2 :color ,dracula-bg :style nil))
               (tab-bar-tab-inactive :foreground ,dracula-purple :background ,bg2
                                     :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line :foreground ,dracula-purple :background ,dracula-current
                         :height 0.9 :inherit variable-pitch)
               (tab-line-tab :foreground ,dracula-pink :background ,dracula-bg
                             :box (:line-width 2 :color ,dracula-bg :style nil))
               (tab-line-tab-inactive :foreground ,dracula-purple :background ,bg2
                                      :box (:line-width 2 :color ,bg2 :style nil))
               (tab-line-tab-current :inherit tab-line-tab)
               (tab-line-close-highlight :foreground ,dracula-red)

               ;; telephone-line
               (telephone-line-accent-active :background ,dracula-bg :foreground ,dracula-pink)
               (telephone-line-accent-inactive :background ,bg2 :foreground ,dracula-purple)
               (telephone-line-unimportant :background ,dracula-bg :foreground ,dracula-comment)

               ;; term
               (term :foreground ,dracula-fg :background ,dracula-bg)
               (term-color-black :foreground ,dracula-bg :background ,dracula-comment)
               (term-color-blue :foreground ,dracula-purple :background ,dracula-purple)
               (term-color-cyan :foreground ,dracula-cyan :background ,dracula-cyan)
               (term-color-green :foreground ,dracula-green :background ,dracula-green)
               (term-color-magenta :foreground ,dracula-pink :background ,dracula-pink)
               (term-color-red :foreground ,dracula-red :background ,dracula-red)
               (term-color-white :foreground ,dracula-fg :background ,dracula-fg)
               (term-color-yellow :foreground ,dracula-yellow :background ,dracula-yellow)

               ;; tree-sitter
               (tree-sitter-hl-face:attribute :inherit font-lock-constant-face)
               (tree-sitter-hl-face:comment :inherit font-lock-comment-face)
               (tree-sitter-hl-face:constant :inherit font-lock-constant-face)
               (tree-sitter-hl-face:constant.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:constructor :inherit font-lock-constant-face)
               (tree-sitter-hl-face:escape :foreground ,dracula-pink)
               (tree-sitter-hl-face:function :inherit font-lock-function-name-face)
               (tree-sitter-hl-face:function.builtin :inherit font-lock-builtin-face)
               (tree-sitter-hl-face:function.call :inherit font-lock-function-name-face
                                                  :weight normal)
               (tree-sitter-hl-face:function.macro :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:function.special :inherit font-lock-preprocessor-face)
               (tree-sitter-hl-face:keyword :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:punctuation :foreground ,dracula-pink)
               (tree-sitter-hl-face:punctuation.bracket :foreground ,dracula-fg)
               (tree-sitter-hl-face:punctuation.delimiter :foreground ,dracula-fg)
               (tree-sitter-hl-face:punctuation.special :foreground ,dracula-pink)
               (tree-sitter-hl-face:string :inherit font-lock-string-face)
               (tree-sitter-hl-face:string.special :foreground ,dracula-red)
               (tree-sitter-hl-face:tag :inherit font-lock-keyword-face)
               (tree-sitter-hl-face:type :inherit font-lock-type-face)
               (tree-sitter-hl-face:type.parameter :foreground ,dracula-pink)
               (tree-sitter-hl-face:variable :inherit font-lock-variable-name-face)
               (tree-sitter-hl-face:variable.parameter :inherit tree-sitter-hl-face:variable
                                                       :weight normal)
               ;; undo-tree
               (undo-tree-visualizer-current-face :foreground ,dracula-orange)
               (undo-tree-visualizer-default-face :foreground ,fg2)
               (undo-tree-visualizer-register-face :foreground ,dracula-purple)
               (undo-tree-visualizer-unmodified-face :foreground ,dracula-fg)

               ;; web-mode
               (web-mode-builtin-face :inherit font-lock-builtin-face)
               (web-mode-comment-face :inherit font-lock-comment-face)
               (web-mode-constant-face :inherit font-lock-constant-face)
               (web-mode-css-property-name-face :inherit font-lock-constant-face)
               (web-mode-doctype-face :inherit font-lock-comment-face)
               (web-mode-function-name-face :inherit font-lock-function-name-face)
               (web-mode-html-attr-name-face :foreground ,dracula-purple)
               (web-mode-html-attr-value-face :foreground ,dracula-green)
               (web-mode-html-tag-face :foreground ,dracula-pink :weight bold)
               (web-mode-keyword-face :foreground ,dracula-pink)
               (web-mode-string-face :foreground ,dracula-yellow)
               (web-mode-type-face :inherit font-lock-type-face)
               (web-mode-warning-face :inherit font-lock-warning-face)

               ;; which-func
               (which-func :inherit font-lock-function-name-face)

               ;; which-key
               (which-key-key-face :inherit font-lock-builtin-face)
               (which-key-command-description-face :inherit default)
               (which-key-separator-face :inherit font-lock-comment-delimiter-face)
               (which-key-local-map-description-face :foreground ,dracula-green)

               ;; whitespace
               (whitespace-big-indent :background ,dracula-red :foreground ,dracula-red)
               (whitespace-empty :background ,dracula-orange :foreground ,dracula-red)
               (whitespace-hspace :background ,dracula-current :foreground ,dracula-comment)
               (whitespace-indentation :background ,dracula-orange :foreground ,dracula-red)
               (whitespace-line :background ,dracula-bg :foreground ,dracula-pink)
               (whitespace-newline :foreground ,dracula-comment)
               (whitespace-space :background ,dracula-bg :foreground ,dracula-comment)
               (whitespace-space-after-tab :background ,dracula-orange :foreground ,dracula-red)
               (whitespace-space-before-tab :background ,dracula-orange :foreground ,dracula-red)
               (whitespace-tab :background ,bg2 :foreground ,dracula-comment)
               (whitespace-trailing :inherit trailing-whitespace))))

  (apply #'custom-theme-set-faces
         'dracula
         (let ((expand-with-func
                (lambda (func spec)
                  (let (reduced-color-list)
                    (dolist (col colors reduced-color-list)
                      (push (list (car col) (funcall func col))
                            reduced-color-list))
                    (eval `(let ,reduced-color-list
                             (backquote ,spec))))))
               whole-theme)
           (pcase-dolist (`(,face . ,spec) faces)
             (push `(,face
                     ((((min-colors 16777216)) ; fully graphical envs
                       ,(funcall expand-with-func 'cadr spec))
                      (((min-colors 256))      ; terminal withs 256 colors
                       ,(if dracula-use-24-bit-colors-on-256-colors-terms
                            (funcall expand-with-func 'cadr spec)
                          (funcall expand-with-func 'caddr spec)))
                      (t                       ; should be only tty-like envs
                       ,(funcall expand-with-func 'cadddr spec))))
                   whole-theme))
           whole-theme)))


;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'dracula)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

;;; dracula-theme.el ends here