FROM ruby:3.2-alpine

WORKDIR /app

COPY Gemfile /app/Gemfile

RUN apk update \
    && apk add --no-cache --virtual build-deps \
    build-base \
    && bundle install \
    && apk del build-deps

RUN apk update \
    && apk add --no-cache \
    chromium \
    font-noto \
    fontconfig \
    && wget https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
    && mkdir -p /usr/share/fonts/NotoSansCJKjp \
    && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
    && rm NotoSansCJKjp-hinted.zip \
    && fc-cache -fv

ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
ENV CHROMIUM_FLAGS "--no-sandbox --disable-setuid-sandbox"
