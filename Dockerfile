FROM alpine:3.19

RUN apk add --no-cache \
    chromium \
    nginx \
    wget

EXPOSE 10000

# Stwórz konfigurację nginx jako proxy
RUN printf 'events { worker_connections 1024; }\n\
http {\n\
  server {\n\
    listen 10000;\n\
    \n\
    location / {\n\
      proxy_pass http://127.0.0.1:9222;\n\
      proxy_http_version 1.1;\n\
      proxy_set_header Upgrade $http_upgrade;\n\
      proxy_set_header Connection "upgrade";\n\
      proxy_set_header Host $host;\n\
      proxy_set_header X-Real-IP $remote_addr;\n\
      proxy_read_timeout 3600s;\n\
      proxy_send_timeout 3600s;\n\
    }\n\
  }\n\
}\n\
' > /etc/nginx/nginx.conf

RUN printf '#!/bin/sh\n\
set -e\n\
\n\
chromium-browser \\\n\
  --remote-debugging-port=9222 \\\n\
  --remote-debugging-address=127.0.0.1 \\\n\
  --headless \\\n\
  --no-sandbox \\\n\
  --disable-gpu \\\n\
  --disable-dev-shm-usage &\n\
\n\
echo "Waiting for Chrome..."\n\
sleep 5\n\
\n\
echo "Starting nginx proxy..."\n\
exec nginx -g "daemon off;"\n\
' > /start.sh && chmod +x /start.sh

CMD ["/bin/sh", "/start.sh"]
