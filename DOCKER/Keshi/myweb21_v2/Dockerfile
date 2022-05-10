# Web Server Exemple hisix2
FROM fedora:27
LABEL subject="webserver"
LABEL author="@cristiancondolo ASIX M01"
RUN dnf -y install procps iputils iproute nmap httpd
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
EXPOSE 80