;;起動画面の抑制
(setq inhibit-startup-message t)

(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

;; tab width
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; 画面分割してもデフォルトで折り返す
(setq truncate-partial-width-windows nil)

;; 折り返しする/しないをトグルで切り替える
(defun toggle-truncate-lines ()
    "折り返し表示をトグル"
    (interactive "r")
    (if truncate-lines
        (setq truncate-lines nil)
        (setq truncate-lines t))
    (recenter))

(global-set-key (kbd "C-M-l") 'toggle-truncate-lines)

(global-set-key (kbd "C-M-<right>") 'scroll-left)
(global-set-key (kbd "C-M-<left>") 'scroll-right)

(global-linum-mode)
(defvar my-linum-min-width 4)
(setq linum-format
      (lambda (line)
    (let ((fmt (format
            "%%%dd"
            (max
             my-linum-min-width
             (length (number-to-string
                  (count-lines (point-min) (point-max))))))))
      (propertize (format fmt line) 'face 'linum))))

;====================================
;;全角スペースとかに色を付ける
;====================================
(when window-system
(global-whitespace-mode 1)
(setq whitespace-line-column 250)
(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
(defface my-face-b-1 '((t (:background "LemonChiffon1"))) nil)
(defface my-face-b-2 '((t (:background "cyan"))) nil)
(defface my-face-b-2 '((t (:background "azure2"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
            (font-lock-add-keywords
                 major-mode
                    '(
                           ("　" 0 my-face-b-1 append)
                           ("\t" 0 my-face-b-2 append)
                           ("[ ]+$" 0 my-face-u-1 append)
          )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                             (if font-lock-mode
                               nil
                               (font-lock-mode t))))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Save cursor position
(require 'saveplace)
(setq-default save-place t)

(global-hl-line-mode 1)
(savehist-mode 1)
(display-time)

(line-number-mode 1)
(column-number-mode 1)
(transient-mark-mode 1)
(setq gc-cons-threshold (* 10 gc-cons-threshold))
(setq message-log-max 10000)
(setq enable-secursive-minibuffers t)
(setq use-dialog-box nil)
(setq history-length 1000)
(setq large-file-warning-threshold (* 25 1024 1024))

;;補完を賢く
(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
    try-complete-file-name
    try-expand-all-abbrevs
    try-expand-dabbrev
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol))

;; yes/no => y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; ?
(setq split-height-threshold nil)

;;現在位置のファイル/URLを開く
(ffap-bindings)
