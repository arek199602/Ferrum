FROM browserless/chrome:latest

# Render przekaże PORT jako zmienną środowiskową
ENV PORT=9222

EXPOSE $PORT

CMD chromium-browser \
    --remote-debugging-port=$PORT \
    --remote-debugging-address=0.0.0.0 \
    --headless \
    --no-sandbox \
    --disable-gpu \
    --disable-dev-shm-usage \
    --disable-setuid-sandbox
