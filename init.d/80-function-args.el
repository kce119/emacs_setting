(require 'function-args)
(fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(semantic-add-system-include (expand-file-name "~/work/msgpub/api/cpp") 'c++-mode)
