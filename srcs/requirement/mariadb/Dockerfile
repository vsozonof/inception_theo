FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y


COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/config.sh /config.sh
RUN chmod +x /config.sh
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

CMD ["/bin/bash", "./config.sh"]