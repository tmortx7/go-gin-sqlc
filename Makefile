DB_URL=postgres://root:root@localhost:5432/dbdata?sslmode=disable

postgres:
	docker run --name postgres14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -d postgres:14-alpine

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root dbdata

dropdb:
	docker exec -it postgres14 dropdb dbdata

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down


sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go



.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server