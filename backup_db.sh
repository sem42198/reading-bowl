#!/bin/bash
source env/.env
sudo docker-compose exec db pg_dump -U $POSTGRES_USER -d rb-prod > rb-prod_dump_$(date +%Y-%m-%d).sql