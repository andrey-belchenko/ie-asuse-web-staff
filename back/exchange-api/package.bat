docker compose --project-directory .  --file ./docker-compose.yml  up   --build -d
docker tag exchange-api andreybelchenko/info-exchange-api:v230611_1
@REM docker login -u "andreybelchenko"
docker push andreybelchenko/info-exchange-api:v230611_1
docker compose --project-directory .  --file ./docker-compose.yml   down

