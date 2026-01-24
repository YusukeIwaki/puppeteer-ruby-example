FROM ruby:3.2-alpine

WORKDIR /app

COPY Gemfile /app/Gemfile

RUN apk update \
    && apk add --no-cache --virtual build-deps \
    build-base \
    && bundle install \
    && apk del build-deps

# Install Chromium and fonts (including CJK support)
RUN apk update \
    && apk add --no-cache \
    chromium \
    font-noto \
    font-noto-cjk \
    fontconfig \
    && fc-cache -fv

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV CHROMIUM_FLAGS="--no-sandbox --disable-setuid-sandbox"
