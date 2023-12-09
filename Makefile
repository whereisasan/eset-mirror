default: run

build:
	docker build -t whereisasan/eset-mirror:latest . --platform=linux/amd64

build-mac:
	docker build -t whereisasan/eset-mirror:latest .

docker-push:
	docker push whereisasan/eset-mirror:latest

run:
	docker-compose up -d
	
update:
	docker exec eset-mirror php update.php