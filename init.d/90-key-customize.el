;;対応するカッコにジャンプ
(define-key global-map (kbd "C-{") 'backward-list)
(define-key global-map (kbd "C-}") 'forward-list)

;; キーボードマクロ再生
(define-key global-map (kbd "C-<f3>") 'kmacro-call-macro)

;; XML整形表示
(define-key global-map (kbd "C-M-<f12>") 'sgml-pretty-print)

;; 最近使ったふぁいる
(global-set-key (kbd "C-]") 'recentf-open-files)

;;カーソル位置の記憶
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)

;;対応するカッコにジャンプ
(define-key global-map (kbd "C-{") 'backward-list)
(define-key global-map (kbd "C-}") 'forward-list)

;; 検索時操作 isearch-mode-map
(define-key isearch-mode-map (kbd "C-<left>") 'isearch-del-char)
(define-key isearch-mode-map (kbd "C-<right>") 'isearch-yank-char)

;; 折り返しする/しないをトグルで切り替える
(global-set-key (kbd "C-M-l") 'toggle-truncate-lines)
(global-set-key (kbd "C-M-<right>") 'scroll-left)
(global-set-key (kbd "C-M-<left>") 'scroll-right)

;;最後の変更箇所にジャンプ
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)

;;指定行にジャンプ
(define-key global-map (kbd "C-M-g") 'goto-line)

;;補完のキー変更
(global-set-key (kbd "C-t") 'dabbrev-expand)

;;undo
(global-set-key (kbd "C-z") 'undo)

;;redo
(global-set-key (kbd "C-M-/") 'redo)

;;行と列をハイライト
(global-set-key (kbd "C-M-\\") 'crosshairs-flash)

;;find-grep
(global-set-key (kbd "C-M-S-g") 'find-grep)

;;indent-region
(global-set-key (kbd "C-M-S-i") 'indent-region)

(global-set-key (kbd "C-h") 'delete-backward-char)

;;ブックマーク
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-<f11>") 'bm-previous)
(global-set-key (kbd "M-<f12>") 'bm-next)

;; 折り返しする/しないをトグルで切り替える
(global-set-key (kbd "C-M-l") 'toggle-truncate-lines)

(global-set-key (kbd "C-M-<right>") 'scroll-left)
(global-set-key (kbd "C-M-<left>") 'scroll-right)

;; tabbar
(global-set-key (kbd "M-<left>") 'tabbar-backward)
(global-set-key (kbd "M-<right>") 'tabbar-forward)
