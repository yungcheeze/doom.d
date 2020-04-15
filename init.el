;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom install'
;; will do this for you). The `doom!' block below controls what modules are
;; enabled and in what order they will be loaded. Remember to run 'doom refresh'
;; after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.
(doom! :input

       :completion
       company
       ivy

       :checkers
       syntax
       grammar
       spell

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       hydra
       modeline
       nav-flash
       ophints
       (popup
        +all
        +defaults)
       treemacs
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       file-templates
       fold
       (format)
       multiple-cursors
       rotate-text
       snippets

       :emacs
       dired
       electric
       ibuffer
       vc

       :term
       term

       :tools
       (docker +lsp)
       (eval +overlay)
       (lookup
        +docsets)
       (lsp +peek)
       magit
       make
       pdf

       :lang
       (cc +lsp)
       data
       emacs-lisp
       (haskell +dante)
       (java +lsp)
       latex
       markdown
       nix
       (org
        +brain
        +dragndrop
        +ipython
        +pandoc
        +present
        +journal)
       (python +lsp)
       rest
       sh
       :config
       (default +bindings +smartparens))
