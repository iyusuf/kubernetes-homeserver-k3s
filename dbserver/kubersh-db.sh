docker build -t iyusuf/dbserver  -f Dockerfile-db .
docker tag iyusuf/dbserver  iyusuf/dbserver:latest
docker push iyusuf/dbserver:latest


kubectl apply -f database-pg-db.yaml


# docker run -p 5432:5432 --name pg-db -d --rm iyusuf/pg-db:v1
# docker exec -it pg-db psql -U myuser -d mydatabase