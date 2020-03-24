;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq display-line-numbers-type nil)


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


(setq org-brain-path "~/Dropbox/Org/brain")

