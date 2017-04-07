(setq el-get-github-default-url-type 'https)
(setq url-proxy-services
      '(("http" . "proxy.tokyo.ogis-ri.co.jp:8080")
    ("https" . "proxy.tokyo.ogis-ri.co.jp:8080")))
(setq url-http-proxy-basic-auth-storage
      (list (list "proxy.tokyo.ogis-ri.co.jp:8080"
          (cons "/"
            (base64-encode-string "p1262591:kce118181")))))
