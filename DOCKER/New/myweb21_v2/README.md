## Ejemplo myweb21:v2

## Ficheros:
    - Dockerfile
    - startup.sh
    - index.html

#### Generar una imagen
```
docker build -t keshikid03/myweb21_v2 .
```

#### Ejecutar en interactivo
```
docker run --rm --name web -h web -it keshikid03/myweb21_v2 /bin/bash
```

#### Ejecutar en detach
```
docker run --rm --name web -h web -d keshikid03/myweb21_v2
```
