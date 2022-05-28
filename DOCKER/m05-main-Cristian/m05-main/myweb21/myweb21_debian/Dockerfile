# Web Server apache2
# debian detach
FROM debian
LABEL subject="web server"
LABEL author="@fercrisjicon ASIX-M05"
LABEL verdura="bledes"
RUN apt-get update && apt-get -y install apache2 iputils-ping iproute2 nmap procps
COPY index.html /var/www/html
WORKDIR /tmp
CMD apachectl -k start -X
EXPOSE 80