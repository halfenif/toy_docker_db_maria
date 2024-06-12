FROM mariadb


# Init Package
RUN apt update

#Timezone
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul
RUN apt-get install -y tzdata

# harlequin
RUN apt-get install -y pip pipx
RUN pipx install harlequin-mysql --include-deps

# Setting
ENV MARIADB_ROOT_PASSWORD mariadb

# Init SQL
#COPY a_uuidv7.sql  /docker-entrypoint-initdb.d/
COPY init.sql      /docker-entrypoint-initdb.d/

# Harlequin Script
RUN mkdir /app
COPY harlequin.sh /app


