FROM php:8.4-fpm-alpine

RUN apk add --no-cache \
git bash curl libzip-dev zip icu-dev oniguruma-dev \
libpng-dev libjpeg-turbo-dev libwebp-dev freetype-dev \
sqlite sqlite-dev

RUN docker-php-ext-configure intl \
&& docker-php-ext-install -j$(nproc) intl pdo pdo_sqlite \
opcache gd zip

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## Chromium
#RUN apk add --no-cache chromium chromium-chromedriver nss
#ENV PANTHER_NO_SANDBOX=1

WORKDIR /app
