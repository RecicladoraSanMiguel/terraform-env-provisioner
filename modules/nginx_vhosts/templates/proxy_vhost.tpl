upstream ${upstream_name}_upstream {
  server ${upstream_name}:${upstream_port};
}

server {
    listen      ${vhost_port};
    server_name ${vhost_hostname};

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;
    client_max_body_size 0;
    proxy_connect_timeout 600s;
    proxy_send_timeout 600s;
    proxy_read_timeout 600s;

    location / {
      proxy_pass  http://${upstream_name}_upstream;
      proxy_next_upstream error timeout invalid_header http_500 http_502 http_503;

      # set headers
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forward-For $proxy_add_x_forwarded_for;
      proxy_redirect off;
    }

    ${upstream_extra_configs}
}