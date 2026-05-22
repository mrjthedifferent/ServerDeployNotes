#!/bin/bash

set -e

# ==================================================
# ONE-TIME SERVER SETUP
# ==================================================
#
# Run these commands ONCE after initial server setup:
#
# sudo chown -R deploy:www-data /var/www/laravel-app
#
# sudo find /var/www/laravel-app -type d -exec chmod 775 {} \;
#
# sudo find /var/www/laravel-app -type f -exec chmod 664 {} \;
#
# sudo find /var/www/laravel-app -type d -exec chmod g+s {} \;
#
# sudo usermod -aG www-data deploy
#
# Optional passwordless service reloads:
#
# sudo visudo
#
# Add:
#
# deploy ALL=NOPASSWD:/bin/systemctl reload php8.3-fpm
# deploy ALL=NOPASSWD:/bin/systemctl reload nginx
#
# Then logout/login again:
#
# exit
# ssh deploy@SERVER_IP
#
# ==================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$APP_DIR"

CURRENT_BRANCH=$(git branch --show-current)

echo "=================================="
echo "Starting Laravel deployment..."
echo "=================================="

echo "Pulling latest code..."
git pull origin "$CURRENT_BRANCH"

echo "Installing composer dependencies..."
composer install --no-dev --optimize-autoloader

echo "Running migrations..."
php artisan migrate --force

echo "Clearing caches..."
php artisan optimize:clear

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Caching views..."
php artisan view:cache

echo "Optimizing Laravel..."
php artisan optimize

echo "Restarting queue workers..."
php artisan queue:restart

echo "Fixing writable permissions..."
chmod -R 775 storage bootstrap/cache

echo "Reloading PHP-FPM..."
sudo systemctl reload php8.3-fpm

echo "Reloading Nginx..."
sudo systemctl reload nginx

echo "=================================="
echo "Deployment completed successfully!"
echo "=================================="
