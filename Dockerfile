FROM alpine:3.19

RUN apk add --no-cache \
    chromium \
    socat \
    wget

EXPOSE 10000

# Stwórz skrypt z poprawnymi końcami linii
RUN printf '#!/bin/sh\n\
set -e\n\
\n\
chromium-browser \\\n\
  --remote-debugging-port=9222 \\\n\
  --remote-debugging-address=0.0.0.0 \\\n\
  --headless \\\n\
  --no-sandbox \\\n\
  --disable-gpu \\\n\
  --disable-dev-shm-usage &\n\
\n\
echo "Waiting for Chrome..."\n\
sleep 5\n\
\n\
echo "Starting proxy on port $PORT..."\n\
exec socat TCP-LISTEN:$PORT,reuseaddr,fork TCP:127.0.0.1:9222\n\
' > /start.sh && chmod +x /start.sh

CMD ["/bin/sh", "/start.sh"]
