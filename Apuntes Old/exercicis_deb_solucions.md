### Enunciats exercicis gestió de paquets i repositoris en distribucions Debian
 
Instal·lar software amb `aptitude`, `apt-get`, `dpkg`

##### Exercici 1

Quin és el fitxer de configuració dels repositoris (amb trajectòria completa)?
Descriu les diferents parts d'una línia d'aquest fitxer.

```
deb http://site.example.com/debian distribution component1 component2 component3
```

Si volguéssim que la nostra distro fos 100% lliure quin/quins serien els components?

**Solució**

```
/etc/apt/sources.list
```

Tot i que alguns també es poden instal·lar de manera individual al directori `/etc/apt/sources.list.d/` com es fa a `/etc/yum.repos.d` per a `RedHat/Fedora`.
 
```
deb http://site.example.com/debian distribution component1 component2 component3
```

+ `deb` o `deb-src` indica el tipus d'arxiu: binaris o fonts.
+ La URL del repositori
+ El nom/àlies de la versió (*jessie, stretch, buster, sid*) o la classe de la versió (oldstable, stable, testing, unstable)). La primera elecció és estàtica, mentre que la segona és dinàmica.

+  Els components poden ser *main*, el principal 100% lliure, *contrib* pot tenir dependències no lliures i *non-free* que no és lliure. (Llibertat segons Debian: [DFSG](https://www.debian.org/social_contract#guidelines))


Un contingut possible per a una testing seria: 

```
## Debian Testing 
deb http://ftp.caliu.cat/pub/distribucions/debian/ testing main contrib non-free 
deb-src http://ftp.caliu.cat/pub/distribucions/debian/ testing main contrib non-free 
deb http://security.debian.org testing/updates main contrib 
```

Si per exemple volguéssim que la nostra distro fos 100% lliure hauríem
d'eliminar el component *non-free*, i potser també *contrib*: repositori que no
acompleix algun dels requeriments de *Debian*, com podria ser que el paquet es
*free* però depen d'un *non-free* o està construït amb eines *non-free* ...

Més info en [aquest enllaç](https://wiki.debian.org/SourcesList)

##### Exercici 2

A les distribucions derivades de RedHat-Fedora l'ordre `dnf upgrade` (antigament a Fedora i a Centos ara: `yum update`) ens actualitza tots els paquets del sistema, quina/es ordres farien el mateix en una distribució tipus Debian?

**Solució**

Primer hen de fer d'actualitzar els repositoris: 

```
apt-get update 
```
I posteriorment puc demanar que s'instal·li tots els paquets que són actualitzables

```
apt-get upgrade 
```

Amb aptitude interactiu escriuríem:

```
aptitude
```

Si premem la tecla `u` farem un update (dels repositoris) i si fem `U` ens mostrarà els paquets que es poden actualitzar. Per acabar el *upgrade* hem de prémer la tecla `g` la qual cosa ens resol les dependències i si estem d'acord tornme a prémer la tecla `g`.

##### Exercici 3

Instal·leu clementine, vlc, gimp, shotwell, gparted, gnome-disk-utility, libreoffice-writer, libreoffice-calc, libreoffice-impress, xournal, pgmodeler i aptitude

Trobeu algun paquet pel que sigui necessari fer servir *contrib* i/o
*non-free*.

**Solució**

```
apt-get install clementine vlc gimp shotwell gparted gnome-disk-utility libreoffice-writer libreoffice-calc libreoffice-impress xournal pgmodeler aptitude
```

##### Exercici 4

Volem afegir el repositori de *Riot*, per a això podríem afegir una línia al
final del fitxer de configuració d'abans, o fer un nou fitxer per a aquest
repositori. Optarem per aquesta 2a opció. [Ajuda](https://riot.im/desktop.html)
 

Seguiu les recomanacions de l'enllaç i actualitzeu el repositori, importeu les claus que garanteixen que el programa és de fonts fiables i finalment instal·leu el programa.

**Solució**

Seguirem una de les dues recomanacions de l'enllaç de l'enunciat: [aqui](https://github.com/vector-im/riot-web/issues/2845#issuecomment-269720886)

Comprovem la versió del nostre Sistema Operatiu:

```
root@pingui:~#  cat /etc/os-release
...
VERSION="9 (stretch)"
ID=debian
...
```

Creem el fitxer repositori `/etc/apt/sources.list.d/matrix-riot-im.list` amb les dades d'abans:

```
root@pingui:~# echo "deb https://riot.im/packages/debian/ stretch main" > /etc/apt/sources.list.d/matrix-riot-im.list
```

Importem la clau GPG (firma digital) per assegurar l'autenticitat del programari:

```
root@pingui:~# curl -L https://riot.im/packages/debian/repo-key.asc | sudo apt-key add -
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  8239  100  8239    0     0  34315      0 --:--:-- --:--:-- --:--:-- 34329
OK
```

Actualitzem el repositori:
```
root@pingui:~# apt-get update
Hit:1 http://security.debian.org/debian-security stretch/updates InRelease
Get:3 https://riot.im/packages/debian stretch InRelease [3,064 B]
Get:5 https://riot.im/packages/debian stretch/main i386 Packages [421 B]
Get:7 https://riot.im/packages/debian stretch/main amd64 Packages [421 B]
Hit:6 http://cdn-fastly.deb.debian.org/debia stretch Release               
...
```

Podria ser que hi hagués algun problema i fos necessari instal·lar prèviament el paquet `apt-transport-https`. Finalment instal·lem:

```
apt-get  install riot-web
```

##### Exercici 5

Amb aptitude, en mode *interactiu*, instal·la i desinstal·la `mc` (o al revés si ja estava instal·lat) 

**Solució**

```
[root@escola ~]# aptitude
```

Podem **cercar** un paquet amb la barra `/` i escrivint a continuació el nom, podem fer servir expressions regulars tipus `^mc`

Per instal·lar un paquet, el seleccionem de la llista i premem `+`, veurem que apareix la lletra `i` al principi de línia, si premem `g` es resoldran les depèndencies, i si estem d'acord tornem a prèmer `g` i s'instal·larà el paquet.

##### Exercici 6

El concepte de package group (grup de paquets) de Fedora com es diu a Debian ? 

**Solució**

*task* (tasques)

##### Exercici 7

Quin o quines ordres ens permeten instal·lar aquestes tasques ? 

**Solució**

```
tasksel 
```

```
apt-get install nom_de_la_tasca^
```

és important no oblidar el caràcter `^`

##### Exercici 8

Com puc llistar les possibles tasques de que disposo ? 

**Solució**

```
tasksel --list-tasks 
```

##### Exercici 9

Mostra amb `dpkg` el contingut del paquet xterm? I tots els paquets instal·lats, amb la mateixa ordre?

**Solució**

```
dpkg -L xterm
```

```
dpkg -l  # ens mostra tots els paquest instal·lats a ls sistema
```

##### Exercici 10

Tradueix del "llenguatge RPM" al "llenguatge DEB" les següents instruccions: 

**Solució**

dnf upgrade  ----> apt-get upgrade 

dnf downgrade foo-1.0 (downgrade el paquet foo a la versió 1.0) ----> apt-get install foo=1.0 

dnf list --installed  -----> dpkg -l 

dnf search  paquet ----> apt-cache search paquet | apt search paquet
(apt-cache search --names-only paquet  per si volem que només coincideixi amb el nom del paquet i no en la descripció o en algun lloc del contingut del paquet) 

rpm -ql paquet  (o repoquery -l) ----> dpkg -L  paquet 

rpm -qf /bin/ping  (o dnf provides */ping)  ---->  dpkg -S  /bin/ping 


##### Exercici 11

Que fa la següent instrucció ? 

```
aptitude -v moo 
```

i aquesta ? 

```
aptitude -vv moo
```

i aquesta ? 

```
aptitude -vvv moo
```
 
**Solució**

Es mostren diversos missatges i dibuixos fins l'últim que diu:

> Què és això ? Evidentment és una serp menjant-se un elefant

OBS: Per fer aquest exercicis és molt recomanable utilitzar els man corresponents o alguns enllaços com per exemple:

[Package Management Basics: apt, yum, dnf, pkg](https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg)

