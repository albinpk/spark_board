#### Export postgres schema

##### Docker

```sh
docker exec -it pg bash # connect to container

pg_dump --schema-only -U postgres postgres > schema.sql # export schema
#                                 ^ db name

docker cp pg:/schema.sql ./ # copy from container
```

##### Local

```sh
pg_dump --schema-only postgres > schema.sql
#                     ^ db name
# --schema-only or -s
```

#### Run postgres on docker

```sh
docker run --name pg -p 5432:5432 -e POSTGRES_PASSWORD=1234 -d postgres
```

```sh
# test postgres (docker) from terminal
docker exec -it pg psql -U postgres
```

#### Create postgres tables

```postgres
CREATE TABLE table_name (
	the_uuid UUID NOT NULL DEFAULT uuid_generate_v4 (),
	the_ref UUID NOT NULL REFERENCES tasks (task_id),
	the_data VARCHAR(255) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT now()
)
```
