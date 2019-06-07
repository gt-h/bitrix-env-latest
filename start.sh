#!/bin/bash
set -e

./stop.sh

if ! [[ -d cert ]]; then
  mkdir -p cert
fi

if ! [[ -d logs/apache ]]; then
  mkdir -p logs/apache
fi

if ! [[ -d logs/nginx ]]; then
  mkdir -p logs/nginx
fi

if ! [[ -d logs/mysql ]]; then
  mkdir -p logs/mysql
fi

if ! [[ -d www ]]; then
  tar zxvf www.tar.gz
  wget http://www.1c-bitrix.ru/download/scripts/restore.php -O www/restore.php
fi

#if [[ -d www ]]; then
#  mv www www.$(date +%d%m%y%H%M%S) && tar zxvf www.tar.gz
#fi

if ! [[ -d db ]]; then
  mkdir -p db
fi

docker-compose up -d --build