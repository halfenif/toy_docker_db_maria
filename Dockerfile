FROM mariadb

ENV MARIADB_ROOT_PASSWORD mariadb
ENV MYSQL_DATABASE mydatabase

# ADD init_db.sh /tmp/init_db.sh
COPY init.sql /docker-entrypoint-initdb.d/

RUN chown -R mysql /docker-entrypoint-initdb.d

#RUN /tmp/init_db.sh