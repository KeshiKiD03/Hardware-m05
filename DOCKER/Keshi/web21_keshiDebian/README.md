# web21_keshiDebian
# @keshi ASIX-M05

## Web1_keshiDebian build
```
docker build -t keshikid03/web21:keshiDebian .
```

## Interactiu
```
docker run --rm -it keshikid03/web21:keshiDebian bash
```
```
# Dockerfile
# Web Server Apache2 Debian Detach
FROM debian
LABEL subject = "Web Server"
LABEL author = "@keshi ASIX M05"
RUN apt-get update && apt-get -y install apache2 iputils-ping iproute2 nmap procps
COPY index.html /var/www/html/.
WORKDIR /tmp
CMD apachectl start 
EXPOSE 80

```

# En Detach - apachectl -k start -X

```
docker run --rm -d keshikid03/web21:keshiDebian
```

```

# Web Server Apache2 Debian Detach
FROM debian
LABEL subject = "Web Server"
LABEL author = "@keshi ASIX M05"
RUN apt-get update && apt-get -y install apache2 iputils-ping iproute2 nmap procps
COPY index.html /var/www/html/.
WORKDIR /tmp
CMD apachectl -k start -X
EXPOSE 80
```

# EXTRAS LOG Y TOP

docker logs sad_poitras --> Todos los mensajes en DEATCH
```
isx36579183@j05:~/Documents/m05/DOCKER/Keshi/web21_keshiDebian$ docker logs sad_poitras 
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
```

docker top sad_poitras
```
isx36579183@j05:~/Documents/m05/DOCKER/Keshi/web21_keshiDebian$ docker top sad_poitras 
UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
root                27934               27914               0                   09:24               ?                   00:00:00            /bin/sh -c apachectl -k start -X
root                27968               27934               0                   09:24               ?                   00:00:00            /bin/sh /usr/sbin/apachectl -k start -X
www-data            27977               27968               0                   09:24               ?                   00:00:00            /usr/sbin/apache2 -k start -X
``

docker ps
```
isx36579183@j05:~/Documents/m05/DOCKER/Keshi/web21_keshiDebian$ docker ps
CONTAINER ID   IMAGE                          COMMAND                  CREATED        STATUS        PORTS     NAMES
1d01c9f108e7   keshikid03/web21:keshiDebian   "/bin/sh -c 'apachec…"   1 second ago   Up 1 second   80/tcp    sad_poitras

```

docker cp --> Copia de dentro a fuera y de fuera a dentro. Lo copia con /ruta sino pues ruta relativa especificado en WORKDIR del Dockerfile
```
docker cp index.html sad_poitras:/var/www/html/
````
