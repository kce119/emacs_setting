(require 'exec-path-from-shell)
(let ((envs '("PATH" "EMACS_FLYCHECK_INCLUDE")))
  (exec-path-from-shell-copy-envs envs))
