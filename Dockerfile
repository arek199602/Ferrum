FROM chromedp/headless-shell:latest

ENV PORT=9222

EXPOSE $PORT

CMD ["/headless-shell/headless-shell", \
     "--remote-debugging-port=9222", \
     "--remote-debugging-address=0.0.0.0", \
     "--disable-gpu", \
     "--no-sandbox"]
