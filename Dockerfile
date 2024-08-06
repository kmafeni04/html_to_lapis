FROM openresty/openresty:jammy

WORKDIR /app

RUN apt update

RUN luarocks install luasec
RUN luarocks install lapis
RUN luarocks install web_sanitize

COPY . .

EXPOSE 80

CMD ["lapis", "server", "production"]

