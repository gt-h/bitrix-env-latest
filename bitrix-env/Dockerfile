FROM centos:6

RUN curl http://repos.1c-bitrix.ru/yum/bitrix-env.sh > /tmp/bitrix-env.sh \
 && sed -i 's/configure_iptables/#configure_iptables/' /tmp/bitrix-env.sh \
 && sed -i 's/print_e "Cannot configure firewall on the server. PLease see $LOGS_FILE"/# print_e "Cannot configure firewall on the server. PLease see $LOGS_FILE"/' /tmp/bitrix-env.sh \
 && /bin/bash /tmp/bitrix-env.sh -p -H $PROJECT_NAME \
 && yum install -y openssh-server \
 && yum install -y memcached \
 && yum clean all

RUN rm /tmp/bitrix-env.sh \
 && sed -i 's/push_stream_max_channel_id_length.*/#push_stream_max_channel_id_length/' /etc/nginx/bx/conf/push-im_settings.conf \
 && sed -i 's/MAXCONN.*/MAXCONN="1024"/' /etc/sysconfig/memcached \
 && sed -i 's/CACHESIZE.*/CACHESIZE="1024"/' /etc/sysconfig/memcached \
 && sed -i 's/OPTIONS.*/OPTIONS="-t 8"/' /etc/sysconfig/memcached \
 && sed -i 's/.*ssl.conf;/include bx\/conf\/ssl_options.conf;/' /etc/nginx/bx/site_avaliable/ssl.s1.conf \
 && sed -i '/.*ssl_options.conf/a \ssl_certificate   /home/bitrix/dehydrated/certs/project1.gt-o.ru/fullchain.pem;' /etc/nginx/bx/site_avaliable/ssl.s1.conf \
 && sed -i '/.*fullchain.pem;/a \ssl_certificate_key  /home/bitrix/dehydrated/certs/project1.gt-o.ru/privkey.pem;' /etc/nginx/bx/site_avaliable/ssl.s1.conf \
 && sed -i '/.*privkey.pem;/a \ssl_trusted_certificate /home/bitrix/dehydrated/certs/project1.gt-o.ru/chain.pem;' /etc/nginx/bx/site_avaliable/ssl.s1.conf \
 && sed -i 's/MaxClients.*/MaxClients 128/' /etc/httpd/bx/conf/prefork.conf \
 && usermod -u 1000 bitrix \
 && groupmod -g 1000 bitrix

COPY ssl_options.conf /etc/nginx/bx/conf/ssl_options.conf

COPY run.sh /
CMD ["/bin/bash", "/run.sh"]