#### Export postgres schema

```sh
pg_dump --schema-only [db] > schema.sql
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
