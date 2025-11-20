FROM chromedp/headless-shell:latest

# Render przekaże PORT jako zmienną środowiskową (zazwyczaj 10000)
EXPOSE 10000

# WAŻNE: musimy uruchomić przez shell, żeby zmienna $PORT działała
ENTRYPOINT ["/bin/sh", "-c"]

CMD ["/headless-shell/headless-shell \
     --remote-debugging-port=${PORT:-10000} \
     --remote-debugging-address=0.0.0.0 \
     --disable-gpu \
     --no-sandbox \
     --disable-dev-shm-usage"]
