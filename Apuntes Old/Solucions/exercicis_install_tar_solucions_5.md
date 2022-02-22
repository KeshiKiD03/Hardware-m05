### Solucions exercicis instal·lació de fitxers tar 

Instal·lació de paquets utilitzant fitxers `tarball` (*tgz/tar.gz*,
*tbz/tar.bz*, *txz/tar.xz*)

##### Exercici 1

Aquest tipus de paquet comprimit s'instal·la normalment en 4 etapes que amb
freqüència es descriuen en algun fitxer de tipus README o INSTALL (que es troba
a dintre del mateix paquet)

1. Descomprimir el paquet i entrar al directori pare del paquet descomprimit.
2. Comprovar que el nostre sistema té totes les dependències necessàries d'aquest programa.
3. Compilar/generar l'executable, el binari i altres dades/fitxers necessaris.
4. Instal·lar les binaris (i altres fitxers de configuració) al nostre sistema.

Tot i que poden haver diferències (en funció del llenguatge en el qual està
escrit el programa) quines són les ordres habituals per realitzar cadascuna
d'aquestes etapes?

**Solució**

1. Descompressió del paquet i entrada al directori pare del paquet descomprimit.

	```
	tar xzvf paquet.tgz
	tar zJvf paquet.tar.xz
	...
	```

2. Comprovació de que el nostre sistema té totes les dependències necessàries
d'aquest programa.

	```
	./configure
	```

3. Compilació/generació de l'executable, el binari i altres dades/fitxers necessaris.

	```
	make
	```

4. Instal·lació dels binaris (i altres fitxers de configuració) al nostre sistema.

	```
	make install
	```

##### Exercici 2

Alguna de les etapes anteriors necessita que siguem root (o utilitzar `sudo`)?

**Solució**

Sí, la darrera etapa, necessita que siguem root ja que anem a instal·lar un
binari, la resta no.

##### Exercici 3

L'etapa 2, el `./configure` si existeix, ens dirà el que ens falta, però si
anem a compilar/fabricar un executable necessitarem que el nostre sistema
tingui les *eines de desenvolupament* que ens permetran fabricar un binari a
partir d'un fitxer de C, C++, Python ...

Quina ordre ens instal·laria aquestes *eines de desenvolupament* a una distribució
*Debian*?

I a una *Fedora*?

**Solució**

A *Debian*:

```
apt-get install build-essential
```

*Normalment la instal·lació d'aquest paquet instal·la també el compilador de c,
però a dia d'avui no instal·la python automàticament*

A *Fedora*:

```
dnf groupinstall "Development Tools"
```

##### Exercici 4

Instal·leu a *Debian* el programa *sopcast*. Fes servir [aquesta
adreça](http://ronlut.blogspot.com.es/2014/06/installing-sopcast-on-debian-jessie-64.html)
tenint en compte que les instruccions estan fetes per a una versio anterior.

L'enllaç de *sopcast* està trencat. A la web de [Google Code es troba la versió
0.8.5](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sopcast-player/sopcast-player-0.8.5.tar.gz)

**Solució**

```
dpkg --add-architecture i386
aptitude install libstdc++5:i386
wget http://download.sopcast.com/download/sp-auth.tgz
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sopcast-player/sopcast-player-0.8.5.tar.gz
tar xzvf sp-auth.tgz
cat sp-auth/Readme
mv sp-auth/sp-sc-auth /usr/bin/
rm -r sp-auth/
tar -zxvf sopcast-player-0.8.5.tar.gz 
cd sopcast-player
cat INSTALL
make
apt-file search -F /usr/bin/make					#?
aptitude install python gettext python-setuptools	#?
aptitude install build-essential					#?
aptitude install python-glade2
```

També pot ajudar, entre d'altres coses per solucionar algun problema [aquest
enllaç](https://exdebian.org/articulos/instalar-sopcast-en-debian)

##### Exercici 5

Instal·leu a *Fedora* el programa de consola `jq` per poder tractar els fitxers
[json](https://en.wikipedia.org/wiki/JSON#Example). A qualsevol distribució
*GNU/Linux* ja tenim un paquet que normalment no és la darrera versió del
programa. Si volem la darrera versió hem de baixar-nos el repositori git
corresponent.En aquest cas, que no és el que demanem, podríem seguir les
instruccions que es troben a [la seva pàgina
web](https://stedolan.github.io/jq/download/).

Nosaltres el que farem serà treballar amb el codi (*sources*), per a això ens
baixarem el paquet que es troba en [aquest
enllaç](https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz)
i seguirem les etapes habituals.

Un cop instal·lat podem treballar amb un exemple, farem servir el fitxer JSON
que conté la [informació dels bicings de
Barcelona](http://api.citybik.es/bicing.json).


Podeu fer servir l'ordre:

```
curl http://api.citybik.es/bicing.json > bicing.json
```

I jugar amb aquest fitxer, on cada element representa una estació del bicing.

Per exemple si volgués trobar la següent informació:

1. Mostra quin tipus d'argument (arrai, nombres, objectes ...) representa el
   fitxer *JSON*.
2. Mostra quants elements hi ha. 
3. Mostra tota la informació de tots els elements (sabent que tenim un arrai).
4. Mostra tota la informació de l'element 0 de l'arrai.
5. Mostra el camp *name* de tots els elements (sabent que tenim un arrai).
6. Mostra tota la informació d'aquells elements que tinguin el camp *bikes*
   superior a 30 (més de 30 bicis disponibles)
7. Mostra el nom d'aquells elements que tinguin el camp *bikes* superior a 30
   (més de 30 bicis disponibles)
8. Mostra tota la informació d'aquells elements que al seu camp *name*
   contingui la cadena "ROSSELLÓ" i el camp *bikes* superior a 10.

Hauria d'executar, respectivament les següents ordres a la consola:

```
cat bicing.json  | jq type
cat bicing.json  | jq length
cat bicing.json  | jq '.[]'
cat bicing.json  | jq '.[0]'
cat bicing.json  | jq '.[].name'
cat bicing.json  | jq '.[] | select (.bikes > 30)'
cat bicing.json  | jq '.[] | select (.bikes > 30) | .name'
echo "aquest no me'l diu el profe i l'he de fer jo"
```

**Solució**

Podem instal·lar fent:

```
cd /tmp
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz
tar xzvf jq-1.5.tar.gz 
cd jq-1.5/
./configure	# xequegem si hi ha errors perquè ens falta algun paquet
make 		# Compilem, és a dir generem els binaris
sudo make install # Instal·lem els binaris, i potser algún fitxer de configuració, en els directoris del nostre sistema adient
```

Si volem la darrera versió, podem clonar el repositori git. La manera de fer-ho
s'explica tant a l'enllaç de l'enunciat com al fitxer README (o README.md) que
es troba al directori de `jq` un cop descomprimit.

Pel que fa a jugar amb jq, ens faltava comlpetar la darrera instrucció:

```
cat bicing.json  | jq '.[] | select ( ( .name | contains("ROSSELLÓ")) and .bikes > 10 )'
```

