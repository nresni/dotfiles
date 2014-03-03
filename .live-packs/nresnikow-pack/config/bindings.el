;; Place your bindings here.

;; For example:
;;(define-key global-map (kbd "C-+") 'text-scale-increase)
;;(define-key global-map (kbd "C--") 'text-scale-decrease)

(live-add-pack-lib "dirtree")
(require 'dirtree)

(live-add-pack-lib "google-translate")
(require 'google-translate)
(global-set-key "\C-ct" 'google-translate-query-translate)
(global-set-key "\C-cT" 'google-translate-at-point)

(add-to-list 'custom-theme-load-path "~/.live-packs/nresnikow-pack/lib/emacs-color-theme-solarized")
(load-theme 'solarized-dark)

(custom-set-variables
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "fr"))

(set-face-attribute 'default nil :height 102)
