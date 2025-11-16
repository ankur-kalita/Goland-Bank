postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it postgres createdb --username=root --owner=root goland_bank

dropdb:
	docker exec -it postgres dropdb --username=root goland_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/goland_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/goland_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/ankur-kalita/Goland-Bank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock