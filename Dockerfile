FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  chromium-browser \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 10000

CMD chromium-browser \
  --remote-debugging-port=${PORT:-10000} \
  --remote-debugging-address=0.0.0.0 \
  --headless \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --disable-setuid-sandbox
