FROM php:8.5-cli

RUN apt-get update && apt-get install -y git unzip libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction \
    && chmod -R 775 storage bootstrap/cache

ENV PHP_CLI_SERVER_WORKERS=4

CMD touch database/database.sqlite \
    && php artisan migrate:fresh --seed --force \
    && php artisan storage:link \
    && php artisan config:cache \
    && php artisan serve --host=0.0.0.0 --port=${PORT:-10000}
