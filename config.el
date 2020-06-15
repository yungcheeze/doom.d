;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq display-line-numbers-type nil)
(setq delete-selection-mode nil)

(map! "M-+" nil
      "M-=" nil
      "M--" nil)

;; unbind C-; (used for iedit-mode)
(map! "C-;" nil)
(map! :map flyspell-mode-map
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

(map! :leader
      "g p" #'xref-pop-marker-stack)
;; iedit
(map! "C-;" #'iedit-mode)
(map! :leader "i e" #'iedit-mode)


(setq avy-all-windows t
      avy-all-windows-alt nil)

(map! :leader
      (:prefix-map ("y" . "avy")
       "l" #'avy-copy-line
       "r" #'avy-copy-region
       "j" #'avy-goto-char-timer))

(map! :after lsp
      :map lsp-mode-map
      :leader
      (:prefix-map ("," . "lsp")
       "r" #'personal/lsp-restart-workspace))

(defun personal/lsp-restart-workspace ()
  (interactive)
  (lsp-restart-workspace)
  (sleep-for 0 500)
  (lsp t))


(defun personal/reload-pipenv-environment ()
  (interactive)
  (pyvenv-deactivate)
  (pipenv-activate)
  (personal/lsp-restart-workspace))

(defun personal/reload-poetry-environment ()
  (interactive)
  (pyvenv-deactivate)
  (poetry-venv-workon)
  (personal/lsp-restart-workspace))

(defun personal/reload-pyvenv-environment ()
  (interactive)
  (pyvenv-deactivate)
  (pyvenv-activate)
  (personal/lsp-restart-workspace))

(map! :after python
      :map python-mode-map
      :localleader
      (:prefix-map ("r" . "reload environment")
       (:prefix-map("p" . "...")
        "i" #'personal/reload-pipenv-environment
        "o" #'personal/reload-poetry-environment
        "v" #'personal/reload-pyvenv-environment)))

(defcustom python-pytest-root nil
  "The name of the project root executable."
  :group 'python-pytest
  :type 'string)

;; override python-pytest--project-root to return python-pytest-root if set
(eval-after-load "python-pytest"
  '(defun python-pytest--project-root ()
     "Find the project root directory."
     (if python-pytest-root
         (symbol-value 'python-pytest-root)
       (projectile-project-root)))
  )

(after! python-pytest
  (setq-default python-pytest-executable "python -m pytest"
                python-pytest-arguments (list "-x" "-s" "-vv")))

(map! :leader
      (:prefix-map ("b" . "buffers")
       "d" #'ace-delete-window
       "r" #'revert-buffer))
(map! :leader
      "TAB" #'ace-window
      "w ;" #'+hydra/window-nav/body)
(map! "C-x C-o" #'ace-window
      "C-x w" #'+hydra/window-nav/body
      "C-x C-3" #'personal/split-and-switch-window-right
      "C-x C-2" #'personal/split-and-switch-window-below)

(defun personal/split-and-switch-window-right ()
  (interactive)
  (select-window (split-window-right)))

(defun personal/split-and-switch-window-below ()
  (interactive)
  (select-window (split-window-below)))

(map! (:desc "next-buffer" "C-x <C-right>" #'personal/hydra-buffer-nav/next-buffer)
      (:desc "next-buffer" "C-x <right>" #'personal/hydra-buffer-nav/next-buffer)
      (:desc "previous-buffer" "C-x <C-left>" #'personal/hydra-buffer-nav/previous-buffer)
      (:desc "previous-buffer" "C-x <left>" #'personal/hydra-buffer-nav/previous-buffer))

(defhydra personal/hydra-buffer-nav nil
  "buffers"
  ("<right>" next-buffer "next")
  ("<C-right>" next-buffer "next")
  ("<left>" previous-buffer "previous")
  ("<C-left>" previous-buffer "previous")
  ("k" doom/kill-this-buffer-in-all-windows "kill"))

(map! "C-x t" #'treemacs)
(map! :leader
      "t t" #'treemacs)

(after! groovy-mode
  (setq groovy-indent-offset 2)
  )

(setq ispell-dictionary "en_GB")

(setq-default ebal-operation-mode 'stack)

(map! :after haskell-mode
      :map haskell-mode-map
      :localleader
      "e" #'ebal-execute
      "r" #'personal/lsp-restart-workspace
      (:prefix-map ("s" . "hasky-stack")
       "s" #'hasky-stack-execute
       "a" #'hasky-stack-package-action
       "i" #'hasky-stack-new
       (:prefix-map ("t" . "test")
        "t" #'personal/hasky-stack-test-thing-at-point
        "a" #'personal/hasky-stack-test-all)))


(defun personal/string-at-point ()
  "Kill the quoted string or the list that includes the point"
  (interactive)
  (let ((p (nth 8 (syntax-ppss))))
    (when (eq (char-after p) ?\")
      (progn
        (goto-char p)
        (thing-at-point 'sexp)))))


(after! hasky-stack
  (defun personal/hasky-stack-test-thing-at-point (target)
    (interactive
     (progn
       (hasky-stack--prepare)
       (list (hasky-stack--select-target "Test target: " ":test:"))))

    (let ((test-filter (personal/string-at-point)))
      (if test-filter
          (apply
           #'hasky-stack--exec-command
           hasky-stack--project-name
           hasky-stack--last-directory
           "test"
           target
           (list (format "--test-arguments=-m %s" test-filter)))
        (message "failed to extract test filter"))))

  (defun personal/hasky-stack-test-all (target)
    (interactive
     (progn
       (hasky-stack--prepare)
       (list (hasky-stack--select-target "Test target: " ":test:"))))
    (apply
     #'hasky-stack--exec-command
     hasky-stack--project-name
     hasky-stack--last-directory
     "test"
     target
     (list))))

(autoload 'personal/hasky-stack-test-thing-at-point "hasky-stack" "" t)
(autoload 'personal/hasky-stack-test-all "hasky-stack" "" t)

(defhydra personal/hydra-fold nil
  "fold"
  ("C" +fold/close-all "close-all")
  ("n" +fold/next "next")
  ("o" +fold/open "open")
  ("c" +fold/close "close")
  ("SPC" +fold/toggle "toggle")
  ("O" +fold/open-all "open-all")
  ("p" +fold/previous "previous"))

(map! :leader
      (:desc "fold" "z" #'personal/hydra-fold/body))

(add-to-list 'auto-mode-alist '("/Pipfile\\'" . conf-toml-mode))
(add-to-list 'auto-mode-alist '("/poetry.lock\\'" . conf-toml-mode))
(add-to-list 'auto-mode-alist '("\\.restclient\\'" . restclient-mode))
(set-file-template! "\\.restclient$" :trigger "__.restclient" :mode 'restclient-mode)

;; (add-to-list 'projectile-globally-ignored-directories ".mypy_cache")
;; Macros
(fset 'clean-verse
      "\C-a\C-k\336\C-a\C-k\336\336\373\C-p \C-y")

;; Setup: 2 windows, left window has org-brain heading, right window is on heading you'd like to add friend to
(defun org-brain-insert-verse-and-link-as-friend()
  (interactive)
  (clean-verse)
  (org-brain-ensure-ids-in-buffer)
  (save-buffer)
  (other-window)
  (org-brain-add-friendship))
