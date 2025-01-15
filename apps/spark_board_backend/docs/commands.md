#### Export postgres schema

```sh
# Docker
docker exec -it pg bash # connect to container
pg_dump --schema-only -U postgres postgres > schema.sql # export schema
#                                 ^ db name
docker cp pg:/schema.sql ./ # copy from container

# Local
pg_dump --schema-only postgres > schema.sql
#                     ^ db name
# --schema-only or -s
```

```sh
# run postgres on docker
docker run --name pg -p 5432:5432 -e POSTGRES_PASSWORD=1234 -d postgres
```

```sh
# test postgres (docker) from terminal
docker exec -it pg psql -U postgres
```
