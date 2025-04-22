FROM php:8.3.20-fpm-alpine

RUN apk update && apk add --no-cache \
    libpq \
    libpng \
    libjpeg-turbo \
    freetype \
    libzip \
    postgresql-libs \
    && apk add --no-cache --virtual .build-deps \
        libpng-dev \
        libjpeg-turbo-dev \
        freetype-dev \
        libzip-dev \
        postgresql-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_pgsql \
    && apk del --no-cache .build-deps \
    && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /tmp/* /root/.composer

WORKDIR /var/www

COPY composer.json composer.lock ./
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction \
    && rm -rf /root/.composer /tmp/* \
    && chown -R www-data:www-data /var/www \
    && find /var/www -type d -exec chmod 755 {} \; \
    && find /var/www -type f -exec chmod 644 {} \; \
    && chmod -R 775 storage bootstrap/cache

COPY docker/php-fpm.conf /usr/local/etc/php-fpm.d/zzz-custom.conf

COPY docker/startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

CMD ["/usr/local/bin/startup.sh"]
