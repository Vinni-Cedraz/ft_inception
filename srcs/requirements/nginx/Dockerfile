FROM alpine:3.19.4
RUN	apk update && apk upgrade && apk add --no-cache nginx openssl
EXPOSE 443
WORKDIR /etc/nginx

RUN if [ ! -f certificate.pem ]; then \
    openssl req \
    -x509 \
    -newkey \
    rsa:4096 \
    -sha256 \
    -days 365 \
    -nodes \
    -keyout certificate.pem \
    -out certificate.pem.pub \
    -subj "/C=BR/ST=SP/L=Vila_Madalena/O=42/OU=42/CN=vcedraz-@42.fr"; \
fi

CMD ["nginx", "-g", "daemon off;"]
