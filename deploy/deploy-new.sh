#!/bin/bash

set -e

# ==================================================
# LARAVEL DEPLOY SCRIPT
# ==================================================
#
# Save this file:
# .scripts/deploy.sh
#
# Make executable:
# chmod +x .scripts/deploy.sh
#
# Run deployment:
# ./.scripts/deploy.sh
#
# ==================================================
# ONE-TIME SERVER SETUP
# ==================================================
#
# 1. Add deploy user to www-data group:
#
# sudo usermod -aG www-data deploy
#
# 2. Set proper ownership:
#
# sudo chown -R deploy:www-data /var/www/laravel-app
#
# 3. Set proper permissions:
#
# sudo find /var/www/laravel-app -type d -exec chmod 775 {} \;
#
# sudo find /var/www/laravel-app -type f -exec chmod 664 {} \;
#
# 4. Enable group inheritance:
#
# sudo find /var/www/laravel-app -type d -exec chmod g+s {} \;
#
# 5. Logout and login again:
#
# exit
# ssh deploy@SERVER_IP
#
# ==================================================
# OPTIONAL PASSWORDLESS SERVICE RELOADS
# ==================================================
#
# Run:
#
# sudo visudo
#
# Add:
#
# deploy ALL=NOPASSWD:/bin/systemctl reload php8.4-fpm
# deploy ALL=NOPASSWD:/bin/systemctl reload nginx
#
# ==================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$APP_DIR"

CURRENT_BRANCH=$(git branch --show-current)

echo ""
echo "=================================="
echo "Starting Laravel deployment..."
echo "Branch: $CURRENT_BRANCH"
echo "App: $APP_DIR"
echo "=================================="
echo ""

echo "Pulling latest code..."
git pull origin "$CURRENT_BRANCH"

echo ""
echo "Installing composer dependencies..."
composer install --no-dev --optimize-autoloader

echo ""
echo "Running migrations..."
php artisan migrate --force

echo ""
echo "Clearing caches..."
php artisan optimize:clear

echo ""
echo "Caching config..."
php artisan config:cache

echo ""
echo "Caching routes..."
php artisan route:cache

echo ""
echo "Caching views..."
php artisan view:cache

echo ""
echo "Optimizing Laravel..."
php artisan optimize

echo ""
echo "Restarting queue workers..."
php artisan queue:restart

echo ""
echo "Restarting Reverb..."
php artisan reverb:restart || true

echo ""
echo "Reloading PHP-FPM..."
sudo systemctl reload php8.4-fpm

echo ""
echo "Reloading Nginx..."
sudo systemctl reload nginx

echo ""
echo "=================================="
echo "Deployment completed successfully!"
echo "=================================="
echo ""
