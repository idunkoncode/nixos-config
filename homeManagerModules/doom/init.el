;; init.el — Doom Emacs module configuration
;; Docs: https://docs.doomemacs.org/latest/modules/

(doom! :input
       ;;bidi
       ;;chinese
       ;;japanese
       ;;layout

       :completion
       company             ; auto-completion
       vertico             ; fuzzy find with orderless

       :ui
       doom                ; doom theme
       doom-dashboard      ; a nifty splash screen
       hl-todo             ; highlight TODO/FIXME/etc.
       modeline            ; snazzy, Atom-inspired modeline
       ophints             ; highlight affected regions
       (popup +defaults)   ; tame sudden windows
       treemacs            ; a project drawer
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe     ; show ~ on empty lines
       workspaces          ; tab emulation, persistence & restore

       :editor
       (evil +everywhere)  ; vim keybindings everywhere
       file-templates
       fold
       snippets

       :emacs
       dired
       electric
       ibuffer
       undo
       vc

       :term
       vterm

       :checkers
       syntax
       (spell +flyspell)

       :tools
       editorconfig
       (eval +overlay)
       lookup
       lsp
       magit
       rgb

       :os
       (:if IS-LINUX tty)

       :lang
       emacs-lisp
       (json +lsp)
       (lua +lsp)
       markdown
       nix
       (python +lsp)
       (rust +lsp)
       (sh +lsp)
       (yaml +lsp)
       (web +lsp)

       :config
       (default +bindings +smartparens))
