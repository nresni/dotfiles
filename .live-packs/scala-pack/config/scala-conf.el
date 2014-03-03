(live-add-pack-lib "scala-mode2")
(live-add-pack-lib "sbt-mode")

(require 'scala-mode2)
(require 'sbt-mode)

(add-to-list 'load-path "~/.live-packs/scala-pack/lib/ensime")
(add-to-list 'exec-path "~/.live-packs/scala-pack/lib/ensime/bin")
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
