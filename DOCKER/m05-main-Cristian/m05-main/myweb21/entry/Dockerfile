FROM fedora
RUN dnf -y install util-linux
COPY ./opcions.sh /usr/bin/opcions.sh
RUN chmod +x /usr/bin/opcions.sh
ENTRYPOINT ["opcions.sh"]
