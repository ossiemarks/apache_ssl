FROM httpd:2.4
COPY ./public-html/ /usr/local/apache2/htdocs/
MAINTAINER ossiemarks
RUN apt-get -y update
RUN apt-get install -y httpd
WORKDIR /tmp/apache
RUN git clone http://github.com/ossiemarks/apache_ssl.git /tmp/apache
COPY ./public-html/ /usr/local/apache2/htdocs/
RUN ssh-keyscan -t rsa 127.0.0.1 >>/root/.ssh/known_hosts
RUN cat /root/.ssh/id_rsa.pub >>/root/.ssh/authorized_keys 
COPY /tmp/apache/server.* /usr/local/apache2/conf/
EXPOSE 22 3000 443
ENTRYPOINT [“/usr/bin/bash”]
