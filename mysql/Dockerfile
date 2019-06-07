FROM mysql:5.7

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN sed -i "s/#log-error/log-error/g" /etc/mysql/mysql.conf.d/mysqld.cnf \
# && sed -i 's/max_allowed_packet.*/max_allowed_packet      = 256M/' /etc/mysql/my.cnf \
 && usermod -u 1000 mysql \
 && groupmod -g 1000 mysql
 