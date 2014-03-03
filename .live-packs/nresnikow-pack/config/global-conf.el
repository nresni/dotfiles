(live-add-pack-lib "sunrise-commander")
(require 'sunrise-commander)
(require 'sunrise-x-tree)
(require 'sunrise-x-buttons)
(require 'sunrise-x-loop)
(require 'sunrise-x-mirror)

(require 'flymake)

(require 'table)

;;(add-to-list 'load-path "~/.emacs.d/multiple-cursors")
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(add-to-list 'load-path "~/.emacs.d/move-text")
(live-add-pack-lib "move-text")
(require 'move-text)
(move-text-default-bindings)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
;;(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ensime)
(setq ensime-sem-high-faces
  '(
  (var . (:foreground "#ff2222"))
    (val . (:foreground "#dddddd"))
    (varField . (:foreground "#ff3333"))
    (valField . (:foreground "#dddddd"))
    (functionCall . (:foreground "#84BEE3"))
    (param . (:foreground "#ffffff"))
    (class . font-lock-type-face)
    (trait . (:foreground "#084EA8"))
    (object . (:foreground "#026DF7"))
    (package . font-lock-preprocessor-face)
))

(set-default-font "Inconsolata-11")
;;(load-file "~/.emacs.d/find-file-in-project.el")

(global-linum-mode 1)
;;(global-set-key (kbd "s-o") 'find-grep-dired)
(global-set-key (kbd "s-o") 'ensime-search)
(global-set-key (kbd "s-k") 'magit-status)
(global-set-key (kbd "s-D") 'sunrise)
(global-set-key (kbd "s-B") 'list-buffers)
(global-set-key (kbd "s-b") 'ido-switch-buffer)
(global-set-key (kbd "s-/") 'comment-or-uncomment-region)
(global-set-key (kbd "s-O") 'find-file-in-project)
(global-set-key (kbd "C-c C-r r") 'ensime-refactor-rename)
(global-set-key (kbd "C-c C-o i") 'ensime-refactor-organize-imports)
(global-set-key (kbd "C-c C-i l") 'ensime-refactor-inline-local)
(global-set-key (kbd "C-c C-t i") 'ensime-inspect-by-path)
(global-set-key (kbd "s-.") 'ensime-edit-definition-other-window)
(put 'dired-find-alternate-file 'disabled nil)
(menu-bar-mode -1)
(setq ensime-sbt-compile-on-save nil)

(defun save-silently ()
  "Save all buffers without prompting"
  (interactive)
  (save-some-buffers t))
(global-set-key (kbd "s-s") 'save-silently)

(global-set-key (kbd "s-N") 'scala-find-name)
(global-set-key (kbd "s-n") 'scala-find-class)
(global-set-key (kbd "s-i") 'ensime-inspect-type-at-point)
(global-set-key (kbd "s-t") 'scala-test-only)
(global-set-key (kbd "s-T") 'jump-to-test)

(setq project-dir (getenv "PWD"))

(defun scala-find-name ()
  "Find-name-dired in current directory"
  (interactive)
  (find-name-dired (format "%s/src" project-dir) (format "%s%s" (read-from-minibuffer "Scala File:") ".scala")))

(defun scala-test-only ()
  "Run the tests in the current file"
  (setq current-file (format "test-only *.%s" (file-name-nondirectory (file-name-sans-extension buffer-file-name))))
  (interactive)
  (ensime-sbt-switch)
  (insert (format "%s" current-file))
  (comint-send-input))

(defun jump-to-test ()
  "Jump to the corresponding test file"
  (interactive)
  (switch-to-buffer (format "%s%sTest.scala" (replace-regexp-in-string "app\/" "test/" (file-name-directory buffer-file-name)) (file-name-nondirectory (file-name-sans-extension buffer-file-name)))))

(defun scala-find-class ()
  "Find-name-grep in current directory for class trait or object"
  (interactive)
  (setq name (read-from-minibuffer "Class:"))
  (find-grep-dired (format "%s/src" project-dir) (format "class %s" name))
  )

;;(defun make-play-doc-url (type &optional member)
;;  (ensime-make-java-doc-url-helper "http://www.playframework.com/documentation/api/2.2.1/scala/" type member))
;;(add-to-list 'ensime-doc-lookup-map '("^play\\." . make-play-doc-url))

(defun make-play-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper "http://www.playframework.com/documentation/api/2.1.1/scala/" type member))
(add-to-list 'ensime-doc-lookup-map '("^play\\." . make-play-doc-url))

(defun make-slick-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper
      "http://slick.typesafe.com/doc/2.0.0/api/" type member))
(add-to-list 'ensime-doc-lookup-map '("^scala\\.slick\\." . make-slick-doc-url))

(global-set-key [kp-subtract] 'undo) ; [Undo]
(global-set-key [insert]    'overwrite-mode) ; [Ins]
(global-set-key [kp-insert] 'overwrite-mode) ; [Ins]
(global-set-key "\C-l" 'goto-line) ; [Ctrl]-l]
(global-set-key "\C-L" 'recenter-top-bottom)
(global-set-key [f2] 'split-window-vertically)
(global-set-key [f1] 'remove-split)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".scala" ".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

(live-add-pack-lib "dired-details")
(require 'dired-details)
(dired-details-install)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
 t)
(define-key global-map (kbd "C-0") 'ace-jump-mode)
(define-key global-map (kbd "C-1") 'ace-jump-line-mode)
(define-key global-map (kbd "C-2") 'ace-jump-char-mode)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
 t)
(eval-after-load "ace-jump-mode"
'(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(define-key global-map (kbd "RET") 'newline-and-indent)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
    (and (not current-prefix-arg)
      (member major-mode '(scala-mode emacs-lisp-mode lisp-mode clojure-mode scheme-mode haskell-mode ruby-mode rspec-mode python-mode c-mode c++-mode objc-mode latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive transient-mark-mode))
        (indent-region (region-beginning) (region-end) nil))))))
(show-paren-mode 1)
(setq show-paren-delay 0)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq exec-paths (append exec-path (list "/usr/bin/sbt")))

;;(add-to-list 'load-path "~/.emacs.d/key-chord")
;;(require 'key-chord)
;;(key-chord-mode 1)
;;(key-chord-define-global "}}" 'forward-sexp)
;;(key-chord-define-global ".." 'ensime-expand-selection-command)
;;(key-chord-define-global "SL" 'split-line)
;;(key-chord-define-global "DL" 'kill-whole-line)
;;(key-chord-define-global "OO" 'overwrite-mode)

;;(defun search-to-brace ()
;;  "Jump to the next open brace"
;;  (interactive)
;;  (search-forward "{"))
;;(key-chord-define-global "s[" 'search-to-brace)

;;(defun search-to-prev-brace ()
;;    "Jump to the previous brace"
;;    (interactive)
;;    (search-backward "{"))
;;(key-chord-define-global "p[" 'search-to-prev-brace)

;;(defun search-to-close-brace ()
;;  "Jump to the next close brace"
;;  (interactive)
;;  (search-forward "}"))
;;(key-chord-define-global "s]" 'search-to-close-brace)

;;(defun search-to-prev-close-brace ()
;;  "Jump to the previous close brace"
;;  (interactive)
;;  (search-backward "}"))
;;(key-chord-define-global "p]" 'search-to-prev-brace)

;;(defun search-to-next-def ()
;;  "Jump to the next def"
;;  (interactive)
;;  (search-forward "def "))
;;(key-chord-define-global "SD" 'search-to-next-def)

;;(defun search-to-prev-def ()
;;  "Jump to the previous def"
;;  (interactive)
;;  (search-backward "def "))
;;(key-chord-define-global "PD" 'search-to-prev-def)

;;(setq-default indent-tabs-mode nil)
;;(setq-default tab-width 2)
;;(setq indent-line-function 'insert-tab)

(define-key global-map (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)

(require 'whitespace)
(setq whitespace-line-column 120) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

(require 'dirtree)
(global-set-key (kbd "s-d") 'dirtree)

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;;(load-theme 'solarized-dark)

;; Always pick up the most recent file from the filesystem
(global-auto-revert-mode 1)
(global-set-key (kbd "s-j") 'dired-jump)
