#!/bin/sh

# Output to check if the script is running
# echo "Running startup script..."

# # Clear caches
# php artisan config:clear
# php artisan cache:clear
# php artisan route:clear
# php artisan view:clear
# php artisan optimize:clear

# # Re-cache configurations for performance
# php artisan config:cache
# php artisan route:cache
# php artisan view:cache

# # Run database migrations
php artisan migrate --force

# # Optionally seed the database (only if you need initial data)
# # php artisan db:seed --force


# # Clear compiled views and autoload files
# composer dump-autoload
# php artisan view:clear

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm
