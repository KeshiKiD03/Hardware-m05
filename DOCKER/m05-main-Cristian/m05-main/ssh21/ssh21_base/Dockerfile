FROM debian
RUN apt-get update && apt-get -y install openssh-client openssh-server procps\
	iproute2 iputils-ping nmap telnet
COPY useradd.sh /tmp
RUN bash /tmp/useradd.sh
WORKDIR /tmp
CMD /etc/init.d/ssh start -D
