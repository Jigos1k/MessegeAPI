# Используем официальный образ PHP с Apache
FROM php:8.2-apache

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install pdo_mysql zip mbstring exif pcntl bcmath gd

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Копируем исходный код приложения
COPY . /var/www/html

# Устанавливаем права на папки
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Устанавливаем зависимости
RUN composer install --optimize-autoloader --no-dev

# Настраиваем Apache
RUN a2enmod rewrite
COPY docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Указываем рабочую директорию
WORKDIR /var/www/html

# Открываем порт 80
EXPOSE 80

# Запускаем Apache
CMD ["apache2-foreground"]