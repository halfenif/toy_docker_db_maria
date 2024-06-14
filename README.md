# Mariadb + Harlequine

목적: mariadb 설정 template

## Install
**Requirements**
- Docker, Docker-Compose or Podman, Podman-Compose


### Clone
```bash
git clone https://github.com/halfenif/toy_docker_db_maria.git
```

### Build
```bash
cd toy_docker_db_maria
./build.sh
```
- build하기 전 기존에 있던 container, image, data를 모두 삭제합니다.
- docker-compose를 호출합니다
- harlequin 호출하는 shell 경로를 출력합니다.

### Config
- Mariadb root password: Dockerfile
- Timezone: Asia/Seoul, Dockerfile
- Charset: utf8mb4, init.sql
- Port: docker-compose.yaml
- volume: docker-compose.yaml # 필수는 아닌데.
- DBMS, User, Password: init.sql


## Feature
- User define function uuidv7() support: init.sql

---
If you feel something isn't working right, I recommend clearing Docker's cached images, containers, and volumes, and then trying again.
뭔가 잘 안된다고 생각되면. Docker의 cache에 해당하는 image, container, volume을 clear하고 해 보는 것을 권합니다.