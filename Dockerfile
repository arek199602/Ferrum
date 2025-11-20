FROM browserless/chrome:latest

# Lub alternatywnie
# FROM zenika/alpine-chrome:latest

EXPOSE 9222

CMD ["chromium-browser", \
     "--remote-debugging-port=9222", \
     "--remote-debugging-address=0.0.0.0", \
     "--headless", \
     "--no-sandbox", \
     "--disable-gpu", \
     "--disable-dev-shm-usage", \
     "--disable-setuid-sandbox"]
