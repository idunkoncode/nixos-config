;; config.el — Personal Doom Emacs configuration

;; Identity
(setq user-full-name    "Adrian"
      user-mail-address "you@example.com")

;; Theme
(setq doom-theme 'doom-catppuccin)

;; Font
(setq doom-font (font-spec :family "TerminessTTF Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "TerminessTTF Nerd Font" :size 14))

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Org-mode directory
(setq org-directory "~/org/")

;; Better scrolling
(setq scroll-margin 8)

;; Which-key delay
(setq which-key-idle-delay 0.3)
