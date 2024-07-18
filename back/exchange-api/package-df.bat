docker compose --project-directory .  --file ./docker-compose.yml  up   --build -d
docker tag exchange-api dockerhub.oastu.lan:5000/exchange-api:v230416_1
docker push dockerhub.oastu.lan:5000/exchange-api:v230416_1
docker compose --project-directory .  --file ./docker-compose.yml   down

