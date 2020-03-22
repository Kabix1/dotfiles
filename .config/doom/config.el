(setq user-full-name "Olle Wiklund"
      user-mail-address "owl@live.se")

(setq doom-font (font-spec :family "Attribute Mono" :size 20))
(unless (find-font doom-font)
  (setq doom-font (font-spec :family "Inconsolata" :size 20)))

(setq doom-unicode-font (font-spec :name "DejaVu Sans Mono" :size 20))

;; Undo the helm text enlargement in childframes
(setq +helm-posframe-text-scale 0)

;; # (setq +doom-dashboard-banner-file (expand-file-name "banner.png" doom-private-dir))

(setq-hook! 'LaTeX-mode-hook +spellcheck-immediately nil)

; hlissner
(use-package! doom-snippets
  :after yasnippet)
; AndreaCrotti
(use-package! yasnippet-snippets
  :after yasnippet)

(after! org
  (remove-hook 'after-save-hook #'+literate|recompile-maybe))

(use-package! magit-todos)

(use-package! magit-annex
  :after magit)
(use-package! git-annex
  :after dired)

;; enable word-wrap in C/C++/ObjC/Java
(add-hook! 'markdown-mode-hook #'+word-wrap-mode)
(add-hook! 'text-mode-hook #'+word-wrap-mode)
(add-hook! 'tex-mode-hook #'+word-wrap-mode)

(use-package! anki-editor
  :after org-noter
  :config
  ; I like making decks
  (setq anki-editor-create-decks 't))

;; I like short names
(general-evil-setup t)
;; Stop telling me things begin with non-prefix keys
(general-auto-unbind-keys)

(setq-default evil-escape-key-sequence "fd")

; Compatibility, delete when fully migrated
(defconst my-leader "SPC")
; Bind a new key chord
(map!
 (:leader
   (:prefix "b"
     :desc "Kill buffer" "d" #'kill-this-buffer)
   (:prefix ("k" . "kill")
     :desc "Save and kill" "e" 'save-buffers-kill-terminal
     :desc "Kill buffer" "b" 'my-kill-this-buffer
     :desc "Delete frame" "f" 'delete-frame
   (:prefix ("o" . "Other")
     :desc "Frames" "f" 'delete-other-frames
     :desc "Windows" "w" 'delete-other-windows
     )
   )
   ))

(nmap
  :prefix "gz"
  :keymaps 'global
  "r" '(mc/edit-lines :wk "Span region")
  "z" '(+evil/mc-make-cursor-here :wk "Place frozen cursor")
  )

(map! :leader
      (:prefix ("r" . "Replace")
      :desc "String" "s" 'replace-string
      :desc "Query" "q" 'query-replace
      (:prefix ("r" . "Regexp")
        :desc "String" "s" 'replace-regexp
        :desc "Query" "q" 'query-replace-regexp
        )
      )
      )

(map! :leader
      (:prefix ("i" . "Insert")
       :desc "Unicode" "u" 'insert-char
       :desc "Snippet" "s" 'yas-insert-snippet
       :desc "From Clipboard" "y" '+default/yank-pop
       :desc "From Evil Registers" "r" 'counsel-evil-registers
      )
)

(nmap
  :prefix my-leader
  ;; look things up
  "l" '(:ignore t :wk "lookup")
  "l o" '(+lookup/online-select :wk "Online")
  "l f" '(+lookup/file :wk "File")
  )

;; (general-define-key
;;  :keymaps '(insert visual normal)
;;  "S-SPC" 'evil-force-normal-state)

(map! :localleader
      :map markdown-mode-map
      :prefix ("i" . "Insert")
      :desc "Blockquote"    "q" 'markdown-insert-blockquote
      :desc "Bold"          "b" 'markdown-insert-bold
      :desc "Code"          "c" 'markdown-insert-code
      :desc "Emphasis"      "e" 'markdown-insert-italic
      :desc "Footnote"      "f" 'markdown-insert-footnote
      :desc "Code Block"    "s" 'markdown-insert-gfm-code-block
      :desc "Image"         "i" 'markdown-insert-image
      :desc "Link"          "l" 'markdown-insert-link
      :desc "List Item"     "n" 'markdown-insert-list-item
      :desc "Pre"           "p" 'markdown-insert-pre
      (:prefix ("h" . "Headings")
        :desc "One"   "1" 'markdown-insert-atx-1
        :desc "Two"   "2" 'markdown-insert-atx-2
        :desc "Three" "3" 'markdown-insert-atx-3
        :desc "Four"  "4" 'markdown-insert-atx-4
        :desc "Five"  "5" 'markdown-insert-atx-5
        :desc "Six"   "6" 'markdown-insert-atx-6))

(map! :localleader
      :map (org-mode-map pdf-view-mode-map)
      (:prefix ("o" . "Org")
        (:prefix ("n" . "Noter")
          :desc "Noter" "n" 'org-noter
          :desc "Test" "t" 'olle/org-print-debug
          )))

; localleader is SPC m
(map! :localleader
      :map pdf-view-mode-map
      :desc "Insert note" "i" 'org-noter-insert-note
      ;; (:prefix "o"
      ;;   (:prefix "n"
      ;;     :desc "Insert" "i" 'org-noter-insert-note
          )

(map! :localleader
      :map org-mode-map
      (:prefix "o"
        :desc "Tags" "t" 'org-set-tags
        (:prefix ("p" . "Properties")
          :desc "Set" "s" 'org-set-property
          :desc "Delete" "d" 'org-delete-property
          :desc "Actions" "a" 'org-property-action
          )
        )
      (:prefix ("i" . "Insert")
        :desc "Link/Image" "l" 'org-insert-link
        :desc "Item" "o" 'org-insert-item
        :desc "Footnote" "f" 'org-footnote-action
        :desc "Table" "t" 'org-table-create-or-convert-from-region
        :desc "Screenshot" "s" 'org-screenshot-take
        (:prefix ("h" . "Headings")
          :desc "Normal" "h" 'org-insert-heading
          :desc "Todo" "t" 'org-insert-todo-heading
          (:prefix ("s" . "Subheadings")
            :desc "Normal" "s" 'org-insert-subheading
            :desc "Todo" "t" 'org-insert-todo-subheading
            )
          )
        (:prefix ("e" . "Exports")
          :desc "Dispatch" "d" 'org-export-dispatch
          )
        )
      )

(map! :localleader
      :map org-mode-map
      (:prefix ("a" . "Anki")
        :desc "Push" "p" 'anki-editor-push-notes
        :desc "Retry" "r" 'anki-editor-retry-failure-notes
        :desc "Insert" "n" 'anki-editor-insert-note
        (:prefix ("c" . "Cloze")
          :desc "Dwim" "d" 'anki-editor-cloze-dwim
          :desc "Region" "r" 'anki-editor-cloze-region
          )
        )
 )

(nmap
:prefix my-leader
:keymaps 'c-mode-base-map
"m" '(:ignore t :wk "Local Commands")
"m r" '(:ignore t :wk "Rtags")
"m r c" '(rtags-check-includes :wk "Check Includes")
;; All the find commands
"m r f" '(:ignore t :wk "Find")
"m r f s" '(:ignore t :wk "Symbol")
"m r f s a" '(rtags-find-symbol-at-point :wk "At point")
"m r f s s" '(rtags-find-symbol :wk "Symbol")
"m r f s c" '(:ignore t :wk "Current")
"m r f s c f" '(rtags-find-symbol-current-file :wk "File")
"m r f s c d" '(rtags-find-symbol-current-dir :wk "Directory")
"m r f f" '(rtags-find-functions-called-by-this-function :wk "Functions")
"m r f r" '(rtags-find-references :wk "References")
)

(nmap 
  "K" 'nil
  "K" 'evil-scroll-page-up
  "J" 'evil-scroll-page-down)

(nmap
  :prefix my-leader
  :keymaps '(latex-mode-map tex-mode-map LaTeX-mode-map)
  ;; Folding Stuff
  "m f" '(:ignore t :wk "Fold Things")
  "m f c" '(TeX-fold-comment :wk "Comment")
  "m f e" '(TeX-fold-env :wk "Environment")
  "m f m" '(TeX-fold-math :wk "Math")
  ;; Insertions
  "m i" '(:ignore t :wk "Insert")
  "m i m" '(helm-insert-latex-math :wk "Math Symbols")
  "m i r" '(:ignore t :wk "References")
  "m i r h" '(helm-bibtex-with-local-bibliography :wk "Helm")
  "m i r r" '(reftex-citation :wk "Reftex")
  )

(setq org-file-apps
  '((auto-mode . emacs)
    ("\\.mm\\'" . default)
    ("\\.x?html?\\'" . default)
    ("\\.pdf\\'" . default)
    ("\\.png\\'" . viewnior)
    ("\\.jpg\\'" . viewnior)
    ))

(setq  inferior-julia-program-name "/bin/julia")

(after! 'org
            (org-babel-do-load-languages 'org-babel-load-languages
                                         (append org-babel-load-languages
                                                 '(julia . t))))

(setq org-startup-with-inline-images 'nil)
(setq org-image-actual-width 500)

(use-package! helm-org-rifle
  :after org
  :general
  (:keymaps 'org-mode-map
            :states 'normal
            :prefix my-leader
            "m r" '(:ignore t :wk "Rifle (Helm)")
            "m r b" '(helm-org-rifle-current-buffer :wk "Rifle buffer")
            "m r e" '(helm-org-rifle :wk "Rifle every open buffer")
            "m r d" '(helm-org-rifle-directory :wk "Rifle from org-directory")
            "m r a" '(helm-org-rifle-agenda-files :wk "Rifle agenda")
            "m r o" '(:ignore t :wk "Occur (Persistent)")
            "m r o b" '(helm-org-rifle-current-buffer :wk "Rifle buffer")
            "m r o e" '(helm-org-rifle :wk "Rifle every open buffer")
            "m r o d" '(helm-org-rifle-directory :wk "Rifle from org-directory")
            "m r o a" '(helm-org-rifle-agenda-files :wk "Rifle agenda")
            )
  )

(use-package! org-mind-map
  :general
  (:keymaps 'org-mode-map
            :states 'normal
            :prefix my-leader
            "m e m" '(org-mind-map-write :wk "Export mind-map") ))

(use-package! org-download
  :after org
  :config
(setq-default org-download-image-dir "./img/"
              org-download-screenshot-method "scrot -s %s"
              org-download-method 'directory
              org-download-heading-lvl 1
              )
  )

(use-package! org-gcal
  :config
(setq org-gcal-file-alist '(("r95g10@gmail.com" .  "~/.config/doom/org/agenda.org.gpg")))
  )

(setq auto-mode-alist (append '(("\\.envrc$" . shell-script-mode))
                              auto-mode-alist))

(use-package! pkgbuild-mode
  :mode "\\PKGBUILD")

(use-package! lammps-mode)
(setq auto-mode-alist (append
                              '(("in\\.'" . lammps-mode))
                              '(("\\.lmp\\'" . lammps-mode))
                              auto-mode-alist
                              ))

(use-package! pug-mode
  :mode "\\.pug\\'")

(setq auto-mode-alist
             (append
             '(("\\.rc\\'" . conf-mode))
             '(("\\.vmd\\'" . conf-mode))
             auto-mode-alist
             ))

(setq auto-mode-alist
             (append
             '(("\\.F90\\'" . fortran-mode))
             auto-mode-alist
             ))

(use-package! kotlin-mode
  :mode "\\.kt\\'")

(use-package! groovy-mode
  :mode "\\.groovy\\'")

(use-package! systemd
  :mode "\\.service\\'")

;; Load it
(use-package! salt-mode
  :config
;; Flyspell
(add-hook 'salt-mode-hook
        (lambda ()
            (flyspell-mode 1))))

(use-package! wakatime-mode)

(use-package! dockerfile-mode
  :mode "Dockerfile\\'"
  :config
  (put 'dockerfile-image-name 'safe-local-variable #'stringp)
  )

; Pdf
(defun haozeke/org-save-and-export-pdf ()
  (if (eq major-mode 'org-mode)
    (org-latex-export-to-pdf t)))
; LaTeX
(defun haozeke/org-save-and-export-latex ()
  (if (eq major-mode 'org-mode)
    (org-latex-export-to-latex t)))
(defun haozeke/org-save-and-export-beamer ()
  (if (eq major-mode 'org-mode)
    (org-beamer-export-to-latex  t)))

(defun haozeke/org-save-and-export-koma-letter-pdf ()
  (if (eq major-mode 'org-mode)
    (org-koma-letter-export-to-pdf t)))

(defun haozeke/org-save-and-export-tex ()
  (if (eq major-mode 'org-mode)
    (org-latex-export-to-latex t)))

(defun olle/org-print-debug ()
  (if (eq major-mode 'org-mode)
      (insert (org-element-property :raw-value (org-element-at-point)))))

;; this function is used to append multiple elements to the list 'ox-latex
(defun append-to-list (list-var elements)
  "Append ELEMENTS to the end of LIST-VAR. The return value is the new value of LIST-VAR."
  (unless (consp elements) (error "ELEMENTS must be a list"))
  (let ((list (symbol-value list-var)))
    (if list
        (setcdr (last list) elements)
      (set list-var elements)))
(symbol-value list-var))

(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(defun haozeke/clang-format-buffer-conditional ()
(interactive)
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (+format|buffer)))

(defun haozeke/org-pandoc-markdown (dir &optional pargs)
  "A wrapper to generate yaml metadata markdown files. Takes the output
  directory followed by pandoc arguments"
  (if (not (file-exists-p dir)) (make-directory dir))
  (async-shell-command-no-window
   (concat "pandoc -f org -t markdown -s " pargs " " (buffer-name) " -o "
           dir "/" (file-name-sans-extension (buffer-name)) ".md"))
    )

(defun sp-wrap-backtick ()
  "Wrap following sexp in backticks."
  (interactive)
  (sp-wrap-with-pair "`"))
(defun sp-wrap-tilda ()
  "Wrap following sexp in tildes."
  (interactive)
  (sp-wrap-with-pair "~"))

; Make sure it's not set before adding to it
(unless (boundp 'org-publish-project-alist)
  (setq org-publish-project-alist nil))

; dotDoom stuff
; This is a rather harmless useful variable
(setq dotdoom-root-dir "~/.config/doom/")
(setq dotdoom-publish-dir  (concat dotdoom-root-dir "docs"))

(add-to-list 'org-publish-project-alist
      `("dotdoom-org"
         :base-directory ,dotdoom-root-dir
         :publishing-directory ,dotdoom-publish-dir
         :base-extension "org"
         :infojs-opt "view:t toc:t ltoc:t mouse:underline buttons:0 path:https://thomasf.github.io/solarized-css/org-info.min.js"
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://thomasf.github.io/solarized-css/solarized-dark.min.css\" />"
         :recursive t
         :publishing-function org-html-publish-to-html
         :auto-index nil ; I make my own from the readme.org
         ;; :html-head-include-default-style nil ; supresses the rest
         ;; :index-filename "README.org"
         ;; :index-title "index"
         ;; :auto-sitemap t                ; Generate sitemap.org automagically...
         ;; :sitemap-filename "index.org"  ; ... call it sitemap.org (it's the default)...
         ;; :sitemap-title "index"         ; ... with title 'sitemap'.
         :link-home "index.html"))

(add-to-list 'org-publish-project-alist
      `("dotdoom-static"
         :base-directory ,dotdoom-root-dir
         :publishing-directory ,dotdoom-publish-dir
         :base-extension "txt"
         :recursive nil
         :publishing-function org-publish-attachment))

(add-to-list 'org-publish-project-alist
      `("dotdoom"
        :components ("dotdoom-org" "dotdoom-static")
        ))

; The interactive thing is REQUIRED
(defun haozeke/clang-format-buffer-smart-on-save ()
(interactive)
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'haozeke/clang-format-buffer-conditional nil t))
; This is a doom-emacs convinience macro
(add-hook! (c-mode c++-mode cc-mode) #'haozeke/clang-format-buffer-smart-on-save)

; Do not automatically try to run rdm
(remove-hook 'c-mode-common-hook #'+cc|init-rtags)

(add-to-list 'safe-local-variable-values
             '(eval add-hook 'after-save-hook
	                (lambda () (org-babel-tangle))
	                nil t))

(add-to-list 'safe-local-variable-values
                '(eval add-hook 'after-save-hook 'haozeke/org-save-and-export-tex nil t)
                '(eval add-hook 'after-save-hook 'haozeke/org-save-and-export-pdf nil t))

(setq org-export-async-init-file (concat doom-private-dir "local/async-ox.el"))

(after! doom-themes
  (remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config))

;; Load
(use-package! poly-R
:config
(map! (:localleader
      :map polymode-mode-map
      :desc "Export"   "e" 'polymode-export
      :desc "Errors" "$" 'polymode-show-process-buffer
      :desc "Weave" "w" 'polymode-weave
      ;; (:prefix ("n" . "Navigation")
      ;;   :desc "Next" "n" . 'polymode-next-chunk
      ;;   :desc "Previous" "N" . 'polymode-previous-chunk)
      ;; (:prefix ("c" . "Chunks")
      ;;   :desc "Narrow" "n" . 'polymode-toggle-chunk-narrowing
      ;;   :desc "Kill" "k" . 'polymode-kill-chunk
      ;;   :desc "Mark-Extend" "m" . 'polymode-mark-or-extend-chunk)
      ))
  )

(eval-after-load 'ox '(require 'ox-koma-letter))
(with-eval-after-load 'ox-latex
  ;; Compiler
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdfxe %f"))
  ;; Configuration
  (add-to-list 'org-latex-packages-alist '("" "minted" "xcolor"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
    '(("bgcolor" "lightgray") ("linenos" "true") ("style" "tango")))
  (append-to-list
   'org-latex-classes
   '(("tufte-book"
      "\\documentclass[a4paper, sfsidenotes, openany, justified]{tufte-book}
      \\input{/home/haozeke/Git/tufte-book.tex}"
      ("\\part{%s}" . "\\part*{%s}")
      ("\\chapter{%s}" . "\\chapter*{%s}")
      ("\\section{%s}" . "\\section*{%s}")
      ("utf8" . "utf8x")
      ("\\subsection{%s}" . "\\subsection*{%s}"))))
  (add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
)

'(org-preview-latex-process-alist
       (quote
       ((dvipng :programs
         ("lualatex" "dvipng")
         :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
         (1.0 . 1.0)
         :latex-compiler
         ("lualatex -output-format dvi -interaction nonstopmode -output-directory %o %f")
         :image-converter
         ("dvipng -fg %F -bg Transparent -D %D -T tight -o %O %f"))
 (dvisvgm :programs
          ("latex" "dvisvgm")
          :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "xdv" :image-output-type "svg" :image-size-adjust
          (1.7 . 1.5)
          :latex-compiler
          ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
          :image-converter
          ("dvisvgm %f -n -b min -c %S -o %O"))
 (imagemagick :programs
              ("latex" "convert")
              :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust
              (1.0 . 1.0)
              :latex-compiler
              ("xelatex -no-pdf -interaction nonstopmode -output-directory %o %f")
              :image-converter
              ("convert -density %D -trim -antialias %f -quality 100 %O")))))

(use-package! cdlatex
    :after (:any org-mode LaTeX-mode)
    :hook
    ((LaTeX-mode . turn-on-cdlatex)
     (org-mode . turn-on-org-cdlatex)))

(use-package! company-math
    :after (:any org-mode TeX-mode)
    :config
    (set-company-backend! 'org-mode 'company-math-symbols-latex)
    (set-company-backend! 'TeX-mode 'company-math-symbols-latex)
    (set-company-backend! 'org-mode 'company-latex-commands)
    (set-company-backend! 'TeX-mode 'company-latex-commands)
    (setq company-tooltip-align-annotations t)
    (setq company-math-allow-latex-symbols-in-faces t))

(setq org-src-preserve-indentation t
      org-edit-src-content-indentation 0)

(use-package! flycheck-package
  :after flycheck
  :config (flycheck-package-setup))

(setq org-ref-notes-directory "~/.megaRefs/Notes"
      org-ref-bibliography-notes "~/.megaRefs/articles.org"
      org-ref-default-bibliography '("~/.megaRefs/Bibliographies/zotLib.bib")
      org-ref-pdf-directory "~/.megaRefs/Papers/")

(setq helm-bibtex-bibliography "~/.megaRefs/Bibliographies/zotLib.bib"
      helm-bibtex-library-path "~/.megaRefs/Papers/"
      helm-bibtex-notes-path "~/.megaRefs/articles.org")

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   ;; org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   org-noter-notes-search-path '("~/Dropbox/notes")
   ;;                                  "~/.megaRefs/"
   ;;                                  "~/Documents")
   )
  )

(setq reftex-default-bibliography '("~/.megaRefs/Bibliographies/zotLib.bib"))

;; Fix some link issues
(defun transform-square-brackets-to-round-ones(string-to-transform)
  "Transforms [ into ( and ] into ), other chars left unchanged."
  (concat
   (mapcar #'(lambda (c) (if (equal c ?\[) ?\( (if (equal c ?\]) ?\) c))) string-to-transform))
  )

;; Actually start using templates
(after! org-capture
  ;; Firefox
  (add-to-list 'org-capture-templates
               '("P" "Protocol" entry
                 (file+headline +org-capture-notes-file "Inbox")
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
                 :prepend t
                 :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry
                 (file+headline +org-capture-notes-file "Inbox")
                 "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n"
                 :prepend t
                 :kill-buffer t))
  ;; Misc
  (add-to-list 'org-capture-templates
         '("a"               ; key
           "Article"         ; name
           entry             ; type
           (file+headline "~/.megaRefs/Notes/consolidated.org" "Article")  ; target
           "* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %a\n:END:\n%i\nBrief description:\n%?"  ; template
           :prepend t        ; properties
           :empty-lines 1    ; properties
           :created t        ; properties
           ))
)
