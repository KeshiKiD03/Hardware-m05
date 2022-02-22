### Solucions exercicis fitxers tar

Exercicis d'arxivament de fitxers (tar) i compressió/descompressió de fitxers
(gzip, bzip2, xz)

##### Exercici 0

Des de *Fedora* i *Debian* comproveu si teniu instal·lat al vostre sistema la documentació de *postgresql*.

El paquet a *Fedora 24* es diu `postgresql-docs` i a *Debian Stretch* `postgresql-doc`.

Comproveu amb l'ordre adient si està instal·lat el paquet o no. Si no està instal·lat,  baixeu-lo utilitzant el gestor de paquets del sistema en el qual us trobeu **sense instal·lar res**.

No el volem instal·lar. Volem obrir i descomprimir el paquet. Ho farem gràficament amb `file-roller` descomprimint a l'Escriptori. Podeu fer un cop d'ull amb el navegador per veure aquesta ajuda (heu de cercar on es troba el fitxer `index.html`.

**Solució**

A Fedora si existeix el paquet hauria de sortir amb la següent ordre:

```
rpm -qa | grep postgresql-docs
```

Si no hi és, el baixem amb l'ordre:

```
dnf download postgresql-docs
```

El mateix a Debian:

```
dpkg -l | grep postgresql-doc
```

```
apt-get -d install postgresql-doc
```

Vigilem perquè a diferència de Fedora el paquet no es baixa al directori actual sinó a `/var/cache/apt/archives`

Un cop tenim el paquet el descomprimim amb file-roller a l'Escriptori, per exemple.

##### Exercici 1

L'exercici anterior haurà creat un directori `usr` amb diferents subdirectori si fitxers. Quina ordre em crea un fitxer de tipus *tar* (sense comprimir)? (Hint: `man tar`)

**Solució**

Suposant que hem fet l'exercici anterior i per tant tenim el fitxer original descomprimit a l'escriptori, executarem:

```
cd ~/Desktop  
tar cvf postgresql-documentacio.tar usr
```

On *c* crea el fitxer *tar*, *v* (*verbose*) ens mostra informació i *f* per posar el nom del fitxer comprimit.

##### Exercici 2

Quina ordre em fa el mateix d'abans però comprimint amb gzip? I amb bzip2? I amb
xz? Després de comprimir amb les 3 ordres fixa't bé en el procés de compressió
de tots 3. Hi ha alguna diferència de velocitat en l'execució de l'ordre
(recorda que si poses `time` davant d'una ordre et mostra el temps que triga
l'ordre)? I en la mida, hi ha diferències? Pots concloure que un compressor
serà millor que altre sempre? o depén de l'ús que es vulgui fer? (Hint: `man
tar`)

**Solució**

Posem davant l'ordre `time` per veure quan triga cada compressor.

Per `gzip`:

```
time tar czvf postgresql-documentacio.tar.gz   usr
...

real	0m0.742s
user	0m0.732s
sys	0m0.045s
```

Per `bzip2`:

```
time tar cjvf postgresql-documentacio.tar.bz   usr
...
real	0m2.478s
user	0m2.454s
sys	0m0.050s

```

Per `xz`:

```
time tar cJvf postgresql-documentacio.tar.xz   usr
...
real	0m9.072s
user	0m9.003s
sys	0m0.135s

```

Finalment ordenem per veure les mides:

```
ls -lS postgresql-documentacio.*
-rw-r--r--. 1 user1 inf 24668160 Feb  5 10:38 postgresql-documentacio.tar
-rw-r--r--. 1 user1 inf 11526047 Feb  5 10:41 postgresql-documentacio.tar.gz
-rw-r--r--. 1 user1 inf 10540686 Feb  5 10:50 postgresql-documentacio.tar.bz
-rw-r--r--. 1 user1 inf 10120184 Feb  5 10:50 postgresql-documentacio.tar.xz
```

Podem concloure que el que, per defecte comprimeix més és `xz`, però al mateix
temps és el més lent, de la mateix manera que gzip és el més ràpid, però per
defecte el que menys comprimeix.

Podríem dir que `bzip2` és una bona opció intermitja.

Quin és millor? Dependrà de les nostres necessitats. Si l'espai és important
per a nosaltres, i la velocitat no té importància, perquè per exemple és una
tasca que es realitza esporàdicament `xz` és el nostre *amic*. En cas contrari,
o sigui si no tenim problemes d'espai i realitzem la tasca molt sovint de
manera que la velocitat és important `gzip` ens pot funcionar molt bé.

Si volem un estudi més exhaustiu podem visitar [aquest
enllaç](https://www.rootusers.com/gzip-vs-bzip2-vs-xz-performance-comparison/).

##### Exercici 3

Continuem treballant a l'escriptori. Si tenim aquí el directori `usr` d'abans
eliminem-lo. 

+ Descomprimiu el fitxer d'extensió *tar.gz* al mateix escriptori. 

+ Feu el mateix amb el fitxer d'extensió *xz* però sense canviar el directori
  actiu (escriptori) volem que es descomprimeixi a `/tmp`.

**Solució:**

```
rm -rf ~/Desktop/usr
```

```
tar xzvf postgresql-documentacio.tar.gz
usr/
usr/share/
usr/share/doc/
usr/share/doc/postgresql-docs/
usr/share/doc/postgresql-docs/postgresql-9.5.7-US.pdf
usr/share/doc/postgresql-docs/html/
usr/share/doc/postgresql-docs/html/tutorial-populate.html
usr/share/doc/postgresql-docs/html/infoschema-sql-features.html
usr/share/doc/postgresql-docs/html/pgrowlocks.html
...

```

```
tar xJvf postgresql-documentacio.tar.xz -C /tmp/ 
usr/
usr/share/
usr/share/doc/
usr/share/doc/postgresql-docs/
usr/share/doc/postgresql-docs/postgresql-9.5.7-US.pdf
usr/share/doc/postgresql-docs/html/
usr/share/doc/postgresql-docs/html/tutorial-populate.html
usr/share/doc/postgresql-docs/html/infoschema-sql-features.html
usr/share/doc/postgresql-docs/html/pgrowlocks.html
...
```

##### Exercici 4

Quina ordre ens permet llistar el contingut d'un tar sense necessitat de descomprimir-lo?

**Solució**

```
tar tf postgresql-documentacio.tar.bz
usr/
usr/share/
usr/share/doc/
usr/share/doc/postgresql-docs/
usr/share/doc/postgresql-docs/postgresql-9.5.7-US.pdf
usr/share/doc/postgresql-docs/html/
usr/share/doc/postgresql-docs/html/tutorial-populate.html
usr/share/doc/postgresql-docs/html/infoschema-sql-features.html
usr/share/doc/postgresql-docs/html/pgrowlocks.html
...
```

##### Exercici 5

Tenim estructures de directoris transformades en tar's comprimits. Quines ordres aconseguiran només descomprimir els diferents comprimits que tinc? I un cop tingui un tar, com puc passar del tar a l'estructura de directoris original?

**Solució:**

```
gunzip postgresql-documentacio.tar.gz
bunzip postgresql-documentacio.tar.bz
unxz postgresql-documentacio.tar.xz
```

```
tar xvf postgresql-documentacio.tar
usr/
usr/lib64/
usr/lib64/pgsql/
usr/lib64/pgsql/tutorial/
usr/lib64/pgsql/tutorial/syscat.sql
usr/lib64/pgsql/tutorial/funcs.c
usr/lib64/pgsql/tutorial/README
usr/lib64/pgsql/tutorial/basics.source
usr/lib64/pgsql/tutorial/complex.sql
usr/lib64/pgsql/tutorial/basics.sql
usr/lib64/pgsql/tutorial/funcs.o
....
```

##### Exercici 6

Executeu les següents ordres:

```
[john@i02 Desktop]$ cd ~/Desktop/
[john@i02 Desktop]$ mkdir -p  exercici6/dir1/dir11/dir12/{dir121,dir122}
[john@i02 Desktop]$ cd exercici6/
[john@i02 exercici6]$ echo "soc el fitxer fitxer1" > dir1/dir11/dir12/dir121/fitxer1.txt
[john@i02 exercici6]$ tree 
.
└── dir1
    └── dir11
        └── dir12
            ├── dir121
            │   └── fitxer1.txt
            └── dir122

5 directories, 1 file
```

+ Descriu que fa cadascuna d'aquestes ordres.
+ Sense moure'ns de directori, quina ordre crearà un fitxer *tgz* que contigui tota l'estructura de directoris i fitxers (sense el directori *exercici6*)

**Solució:**

```
[john@i02 exercici6]$ tar czvf dir.tgz  *
dir1/
dir1/dir11/
dir1/dir11/dir12/
dir1/dir11/dir12/dir122/
dir1/dir11/dir12/dir121/
dir1/dir11/dir12/dir121/fitxer1.txt
[john@i02 exercici6]$ ls -l 
total 8
drwxr-xr-x. 3 john inf 4096 Feb  5 18:05 dir1
-rw-r--r--. 1 john inf  234 Feb  5 18:05 dir.tgz

```

##### Exercici 7

Es pot indicar el nivell de compressió o de velocitat quan s'utilitzen *gzip*, *bzip2* i *xz*? I per descomprimir?

**Solució**

Si fem `man gzip` trobem:

```
 -# --fast --best
             Regulate  the  speed  of compression using the specified digit #, where -1 or
             --fast indicates the fastest compression method (less compression) and -9  or
             --best  indicates  the  slowest  compression  method (best compression).  The
             default compression level is -6 (that is, biased towards high compression  at
             expense of speed).
```

Si fem `man bzip2` trobem:

```
 -1 (or --fast) to -9 (or --best)
             Set the block size to 100 k, 200 k ..  900 k when compressing.  Has no effect
             when  decompressing.   See  MEMORY  MANAGEMENT  below.  The --fast and --best
             aliases are primarily for GNU  gzip  compatibility.   In  particular,  --fast
             doesn't  make  things  significantly  faster.   And --best merely selects the
             default behaviour.
```

Finalment 

```
 -0 ... -9
             Select  a  compression  preset level.  The default is -6.  If multiple preset
             levels are specified, the last one takes effect.  If a  custom  filter  chain
             was  already  specified, setting a compression preset level clears the custom
             filter chain.
             The differences between the presets are more significant  than  with  gzip(1)
             and  bzip2(1). 
```

De fet aquesta opció és molt més sofisticada a `xz`

Per descomprimir no té sentit indicar cap d'aquests paràmetres.



##### Exercici 8

Baixa el paquet [r.tar.gz](r.tar.gz) i descomprimeix tot el que es pugui descomprimir.

**Solució:**

No es pot, és un comprimit dintre d'un comprimit ... Més informació [aquí](https://research.swtch.com/zip)

##### Extres

A l'*Exercici 0* descomprimim els paquets *rpm* o *deb* gràficament. També ho podríem fer des de la consola, necessitem llavors apuntar algunes característiques d'aquests paquets:

* un paquet *rpm* conté diferents seccions, la secció que té les dades és un fitxer d'arxivament de tipus *cpio* i posteriorment comprimit amb gzip [(wikipedia)](https://en.wikipedia.org/wiki/Rpm_(software)#Format).
* un paquet *deb* és un fitxer de tipus *ar* que conté al seu torn un parell de fitxers *tar* comprimits [(wikipedia)](https://en.wikipedia.org/wiki/Deb_(file_format)).

Per tant per aconseguir extreure les dades d'un *rpm* podem utilitzar l'ordre `rpm2cpio`. Al `man` se'ns recomana executar:

```
rpm2cpio postgresql-docs-XXXXXXXXXXXX.rpm | cpio -dium
```

Mentre que per descomprimir el paquet *deb* podem fer servir l'ordre `ar`:

```
ar postgresql-doc-XXXXXXXXXXXX.deb
```
##### Altres enllaços interessants:

* [tar-versus-zip-versus-gz](https://itsfoss.com/tar-vs-zip-vs-gz/)
* [tar versus cpio](https://superuser.com/questions/343915/tar-vs-cpio-what-is-the-difference/343943#343943)

