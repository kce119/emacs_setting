(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/bin/clang-complete")
  (setq ac-sources (append ac-sources '(ac-source-clang-async)))
  (ac-clang-launch-completion-process))

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
  (my-ac-config)

(require 'auto-complete-c-headers)
(add-hook 'c++-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-sources (append ac-sources '(ac-source-c-headers))))
