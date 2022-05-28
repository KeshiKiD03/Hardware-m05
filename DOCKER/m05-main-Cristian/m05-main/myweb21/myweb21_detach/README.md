## Ejemplo myweb21:v2

## Ficheros:
    - Dockerfile
    - startup.sh
    - index.html

#### Generar una imagen
```
docker build -t cristiancondol21/myweb21:v2 .
```

#### Ejecutar en interactivo
```
docker run --rm --name web -h web -it cristiacondolo21/myweb21:v2 /bin/bash
```

#### Ejecutar en detach
```
docker run --rm --name web -h web -d cristiancondolo21/myweb21:v2
```