upstream ${upstream_name}_upstream {
  server ${upstream_name}:${upstream_port};
}

server {
    listen ${port};
    listen [::]:${port};

    server_name ${hostname};

    location '/.well-known/acme-challenge' {
        default_type "text/plain";
        proxy_pass http://${upstream_name}_upstream;
    }

    location / {
        return 301 https://$host$request_uri;
    }
}
