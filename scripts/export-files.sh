#!/bin/bash
rm -rf backup/files
source .env && docker cp "$(docker-compose ps -q app)":/app ./backup/files