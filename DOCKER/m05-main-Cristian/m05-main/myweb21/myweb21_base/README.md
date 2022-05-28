## Ejemplo myweb21

__Ficheros__:
- Dockerfile
- index.html
- startup.sh

#### Generar imagen:
```
docker build -t cristiancondolo21/myweb21:v1 .
```

#### Ejecutar interactivo
```
docker run --rm --name web -h web -it cristiancondolo21/myweb21:v2 /bin/bash
```

#### Encender servidor web
```
bash startup.sh
```

#### Comprobar fuera del docker
```
telnet 172.17.0.2 80
```
o en un navegador
```
172.17.0.2
```
