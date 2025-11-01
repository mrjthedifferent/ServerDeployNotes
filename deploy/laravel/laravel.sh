#!/bin/bash

# Stop execution on any error
set -e

echo "🚀 Optimizing Laravel application..."

# Check if required commands exist
command -v php >/dev/null 2>&1 || { echo "❌ PHP is not installed. Aborting." >&2; exit 1; }
command -v composer >/dev/null 2>&1 || { echo "❌ Composer is not installed. Aborting." >&2; exit 1; }

# Ensure storage and cache folders exist
mkdir -p bootstrap/cache
mkdir -p storage/framework/cache
mkdir -p storage/framework/sessions
mkdir -p storage/framework/views
mkdir -p storage/framework/cache/data

# Clear cached bootstrap files to prevent "class not found" errors
# This is safe - they will be regenerated after composer install
echo "🧹 Clearing bootstrap cache files..."
rm -f bootstrap/cache/*.php 2>/dev/null || true

# Backup database before deployment
# php artisan backup:run --only-db --disable-notifications || echo "⚠️ Backup failed, continuing..."

# Enable maintenance mode (may fail if cache is corrupted, but we'll handle it)
# Temporarily disable exit on error for this command
set +e
php artisan down 2>/dev/null
MAINTENANCE_STATUS=$?
set -e
if [ $MAINTENANCE_STATUS -ne 0 ]; then
    echo "⚠️ Could not enable maintenance mode (cache may be cleared). Continuing..."
fi

# Install composer dependencies
echo "📦 Installing dependencies..."
COMPOSER_ALLOW_SUPERUSER=1 composer install --optimize-autoloader --no-dev --no-interaction --prefer-dist

# Run database migrations
echo "🗄️ Running migrations..."
php artisan migrate --force

# Clear and rebuild caches
echo "🧹 Clearing and rebuilding caches..."
php artisan optimize:clear

# Fix permissions (more secure: 775 for directories, 664 for files)
echo "🔒 Fixing permissions..."
sudo chmod -R 775 storage bootstrap/cache
sudo find storage bootstrap/cache -type f -exec chmod 664 {} \;
sudo chown -R www-data:www-data storage bootstrap/cache

# Optimize application
echo "⚡ Optimizing application..."
php artisan optimize

# Run permission seeder
echo "🔒 Running permission seeder..."
php artisan db:seed --class=PermissionSeeder

# Bring application back up
echo "✅ Bringing application back up..."
php artisan up

echo "🎉 Deployment completed successfully!"
