#!/bin/bash
source .env && docker-compose exec db bash -c "mysqldump -u $C5_DB_USER -p$C5_DB_PASSWORD $C5_DB_NAME | gzip > /docker-entrypoint-initdb.d/database.sql.gz"