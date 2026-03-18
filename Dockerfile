FROM php:8.4-cli

# System deps + PHP extensions
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libpq-dev \
        libzip-dev \
        libsodium-dev \
        libicu-dev \
    && docker-php-ext-install pdo pdo_pgsql bcmath opcache sodium intl zip \
    && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 8000

# Default command: serve Laravel app
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
