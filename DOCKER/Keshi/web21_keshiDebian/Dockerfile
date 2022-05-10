# Web Server Apache2 Debian Detach
FROM debian
LABEL subject = "Web Server"
LABEL author = "@keshi ASIX M05"
RUN apt-get update && apt-get -y install apache2 iputils-ping iproute2 nmap procps
COPY index.html /var/www/html/.
WORKDIR /tmp
CMD apachectl -k start -X
EXPOSE 80
