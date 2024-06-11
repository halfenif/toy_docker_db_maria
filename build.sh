docker containter stop toy_docker_db_maria
docker containter rm toy_docker_db_maria
docker image rm toy_docker_db_maria

DOCKER_BUILDKIT=1 docker build --tag toy_docker_db_maria .

docker image ls

# docker run -it toy_docker_db_maria /bin/bash