FROM alpine:3.19

# Zainstaluj Chromium i socat
RUN apk add --no-cache \
    chromium \
    socat \
    bash

EXPOSE 10000

# Stwórz startup script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Start Chrome w tle\n\
chromium-browser \
  --remote-debugging-port=9222 \
  --remote-debugging-address=0.0.0.0 \
  --headless \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage &\n\
\n\
CHROME_PID=$!\n\
\n\
# Poczekaj na Chrome\n\
echo "Waiting for Chrome to start..."\n\
for i in {1..30}; do\n\
  if wget -q -O- http://localhost:9222/json/version > /dev/null 2>&1; then\n\
    echo "Chrome is ready!"\n\
    break\n\
  fi\n\
  sleep 1\n\
done\n\
\n\
# Uruchom socat jako proxy\n\
echo "Starting socat proxy on port ${PORT}..."\n\
exec socat TCP-LISTEN:${PORT},reuseaddr,fork TCP:127.0.0.1:9222\n\
' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
