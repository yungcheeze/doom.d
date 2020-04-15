;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq display-line-numbers-type nil)
(setq delete-selection-mode nil)

(map! "M-+" nil
      "M-=" nil
      "M--" nil
      "C-;" nil)

(map! :leader
      "t +" #'doom/reset-font-size
      "t =" #'doom/increase-font-size
      "t -" #'doom/decrease-font-size)

(map! "C--" #'negative-argument
      "M--" #'negative-argument)


(setq org-directory "~/Dropbox/Org")
;; smart parens bindings
(map!
 ;; unset old bindings
 (:after smartparens
   :map smartparens-mode-map
   "C-M-a" nil
   "C-M-e" nil
   "C-M-f" nil
   "C-M-b" nil
   "C-M-d" nil
   "C-M-k" nil
   "C-M-t" nil
   "C-<right>" nil
   "M-<right>" nil
   "C-<left>" nil
   "M-<left>" nil)

 (:after smartparens
   :map smartparens-mode-map
   "C-M-f" #'sp-forward-sexp
   "C-M-b" #'sp-backward-sexp

   "C-M-d" #'sp-down-sexp
   "C-M-a" #'sp-backward-down-sexp
   "C-S-d" #'sp-beginning-of-sexp
   "C-S-a" #'sp-end-of-sexp

   "C-M-e" #'sp-up-sexp
   "C-M-u" #'sp-backward-up-sexp
   "C-M-t" #'sp-transpose-sexp

   "C-M-n" #'sp-forward-hybrid-sexp
   "C-M-p" #'sp-backward-hybrid-sexp

   "C-M-k" #'sp-kill-sexp
   "C-M-w" #'sp-copy-sexp

   "M-<delete>" #'sp-unwrap-sexp

   "C-<right>" #'sp-forward-slurp-sexp
   "C-<left>" #'sp-forward-barf-sexp
   "C-M-<left>" #'sp-backward-slurp-sexp
   "C-M-<right>" #'sp-backward-barf-sexp

   "M-D" #'sp-splice-sexp
   "C-M-<delete>" #'sp-splice-sexp-killing-forward
   "C-M-<backspace>" #'sp-splice-sexp-killing-backward
   "C-S-<backspace>" #'sp-splice-sexp-killing-around

   "C-]" #'sp-select-next-thing-exchange
   "C-<left_bracket>" #'sp-select-previous-thing
   "C-M-]" #'sp-select-next-thing

   "M-F" #'sp-forward-symbol
   "M-B" #'sp-backward-symbol

   "C-\"" #'sp-change-inner
   "M-i" #'sp-change-enclosing
   )
 )

;; iedit
(map! "C-;" #'iedit-mode)


(setq avy-all-windows t
      avy-all-windows-alt nil)

(map! :leader
      (:prefix-map ("y" . "avy")
        "l" #'avy-copy-line
        "r" #'avy-copy-region
        "j" #'avy-goto-char-timer))
