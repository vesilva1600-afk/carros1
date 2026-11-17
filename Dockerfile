FROM richarvey/nginx-php-fpm:3.1.6

# Copia todo o projeto (incluindo a pasta vendor e public já geradas)
COPY . /var/www/html

# Configura o Nginx para apontar para a pasta public do Laravel
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Cria a base de dados SQLite vazia e ajusta as permissões de escrita
RUN mkdir -p database \
    && touch database/database.sqlite \
    && chown -R nginx:nginx /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/database