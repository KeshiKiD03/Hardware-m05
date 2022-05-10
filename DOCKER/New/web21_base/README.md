# web21 # Keshi
## @edt ASIX-M05 Curs 2021-2022

Exemple d'imatge docker per a un servidor web, basada en *fedora27*
amb apache funcionant al port 80 amb una pàgina d'inici bàsica.

Fitxers:

 * Dockerfile
 * index.html
 * startup.sh

#### Generar imatge:
```
docker build -t keshikid03/web21_base .
```

#### Executar interactiu
```
docker run --rm --name web -h web -it keshikid03/web21_base /bin/bash
```

#### Executar en detach
```
docker run --rm --name web -h web -d keshikid03/web21_base
```



