#!/bin/bash

# Wait for database to become available
until nc -z -v -w30 ${C5_DB_HOST} 3306
do
  echo "Waiting for database connection..."
  # wait for 5 seconds before check again
  sleep 5
done

# Install Concrete
INSTALLED=$(/app/concrete/bin/concrete5 c5:info | grep Installed | cut -d' ' -f 3)

if [ $INSTALLED = "No" ]
then
    /app/concrete/bin/concrete5 c5:install \
        --db-server=$C5_DB_HOST \
        --db-username=$C5_DB_USER \
        --db-password=$C5_DB_PASSWORD \
        --db-database=$C5_DB_NAME \
        --site=$C5_SITE_NAME \
        --starting-point=$C5_THEME \
        --admin-email=$C5_ADMIN_EMAIL \
        --admin-password=$C5_ADMIN_PASSWORD \
        --site-locale=$C5_LOCALE
fi

# Start da ting
/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf