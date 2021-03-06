;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; indent style
(setq-default c-indent-level 4)
(setq c-basic-offset 4)
(setq c-label-minimum-indentation 0)
(c-set-offset 'substatement-open 0)
(c-set-offset 'innamespace 0)
(c-set-offset 'arglist-intro '+)
(c-set-offset 'arglist-close 0)

(require 'auto-complete-c-headers)
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))
(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable (expand-file-name "~/.emacs.d/bin/clang-complete"))
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; fly check
(require 'flycheck)
(add-hook 'c-mode-common-hook 'flycheck-mode)

;(setq flycheck-gcc-include-path (getenv "EMACS_FLYCHECK_INCLUDE"))


;; Add custom include paths here
(add-hook 'c++-mode-hook
          (lambda () (flycheck-select-checker
                           'c/c++-gcc)))

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-include-path
                           (list (expand-file-name "/home/nakao/github/iotc_msgpub/include")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/msgpack-c/include")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/mqtt_client_cpp/include")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/mqtt_client_cpp/external/Beast/include")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/unit_test")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/broker")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/expected/include")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/soci/src/core")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/external/soci/src/backends")
                                 (expand-file-name "/usr/include/mysql")
                                 (expand-file-name "/home/nakao/github/iotc_msgpub/build/cryptopp/include")

                                 )
               )
        )
      )

(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-gcc-language-standard
                           "c++1z")))

;(add-to-list 'flycheck-checkers 'c++-gcc)
;(flycheck-select-checker "c/c++-gcc")

;; (defmacro flycheck-define-clike-checker (name command modes)
;;   `(flycheck-define-checker ,(intern (format "%s" name))
;;      ,(format "A %s checker using %s" name (car command))
;;      :command (,@command source-inplace)
;;      :error-patterns
;;      ((warning line-start (file-name) ":" line ":" column ": 警告:" (message) line-end)
;;       (error line-start (file-name) ":" line ":" column ": エラー:" (message) line-end))
;;      :modes ',modes))
;; (flycheck-define-clike-checker c-gcc-ja
;;              ("gcc" "-fsyntax-only" "-Wall" "-Wextra")
;;              c-mode)
;; (add-to-list 'flycheck-checkers 'c-gcc-ja)
;; (flycheck-define-clike-checker c++-g++-ja
;;                    ("g++" "-fsyntax-only" "-Wall" "-Wextra" "-std=c++11")
;;                    c++-mode)
;; (add-to-list 'flycheck-checkers 'c++-g++-ja)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; indent style
;(defun my-c-c++-mode-init ()
;  )

(defun c++-template-args-cont (langelem)
"Control indentation of template parameters handling the special case of '>'.
Possible Values:
0   : The first non-ws character is '>'. Line it up under 'template'.
nil : Otherwise, return nil and run next lineup function."
  (save-excursion
    (beginning-of-line)
    (if (re-search-forward "^[\t ]*>" (line-end-position) t)
        0)))

(add-hook 'c++-mode-hook
          (lambda ()
            (c-set-offset 'template-args-cont
                          '(c++-template-args-cont c-lineup-template-args +))))

;(add-hook 'c-mode-hook 'my-c-c++-mode-init)
;(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
