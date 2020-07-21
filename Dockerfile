FROM alpine:3.5
RUN apk add --no-cache --virtual .build-deps curl git \
 && mkdir /etc/caddy \
 && touch /etc/caddy/Caddyfile \
 && curl -L -o /caddy.tar.gz --insecure https://github.com/caddyserver/caddy/releases/download/v1.0.3/caddy_v1.0.3_linux_amd64.tar.gz \
 && tar -zxvf /caddy.tar.gz caddy \
 && mv caddy /usr/bin \
 && rm -rf /caddy*
RUN mkdir /wwwroot
RUN git clone https://github.com/xiongbao/we.dog
RUN mv we.dog/* /wwwroot
RUN rm -rf /we.dog
ADD Caddyfile /etc/caddy/Caddyfile
CMD ["/usr/bin/caddy", "--conf=/etc/caddy/Caddyfile"]
EXPOSE 8080
