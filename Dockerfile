FROM richarvey/nginx-php-fpm:3.1.6

# Copia todo o projeto para dentro do container
COPY . /var/www/html

# Configurações do ambiente Nginx e PHP
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1
