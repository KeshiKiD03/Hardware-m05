## Solucions exercicis backups amb tar

### Creació de backups de dades amb tar

##### Exercici 1

Genereu un paquet-1 comprimit (al màxim) amb tota la documentació d'apunts dels
crèdits M01, M05, M07.

Suposarem que tenim una estructura tipus:

```
[eve@pc666 ~]$ tree  prova_public_backup_ASIX/
prova_public_backup_ASIX/
├── M01-Operatius
│   ├── 00-Substitucio
│   │   ├── 1-Introduccio_SO.pdf
│   │   ├── 2-AlgoritmeShell.pdf
│   │   ├── 3-Ordres_Basiques_GNU_Linux.pdf
│   │   ├── 5-exerciciExpresionsRegulars.txt
...

├── M03-Programacio
│   ├── documents
│   │   ├── capsalera.py
│   │   ├── estil_python.odt
│   │   ├── Introducci\303\263n\ a\ la\ programaci\303\263n\ con\ Python.pdf
│   │   └── presentacio_curs_2017-18_2HISX(1).odp
│   ├── examens
│   │   ├── examen1
...
└── M05-Hardware
    ├── exercicis_comprimits.md
    ├── exercicis_deb.md
    ├── exercicis_mastering_time.md
    ├── git_class
    │   ├── 01-primers_passos.md
...
43 directories, 236 files
```

**Solució**


```
tar czvf publicASIX-1.tar.gz prova_public_backup_ASIX	# compressió gzip  
```

A més compressió, més triga a generar el fitxer.

Altres compressions:

```
tar cjvf publicASIX-1.tar.bz2 prova_public_backup_ASIX	# compressió bz2
tar cJvf publicASIX-1.tar.xz prova_public_backup_ASIX	# compressió xz
```

Com ja sabíem, podem comprovar que la màxima compressió l'aconseguim amb el format `xz`:

```
eve@pc666 ~]$ ls -lSr publicASIX-1.t*
-rw-r--r--. 1 eve inf 11611292 Mar  1 12:51 publicASIX-1.tar.xz
-rw-r--r--. 1 eve inf 12923944 Mar  1 12:51 publicASIX-1.tar.bz2
-rw-r--r--. 1 eve inf 13597053 Mar  1 12:50 publicASIX-1.tar.gz
```

En realitat ens demanen per la compressió màxima, com que `bzip2` pre omissió
ja és la que utilitza, només haurem de canviar les altres dues:

A l'antiga:

```
tar cvf - prova_public_backup_ASIX | gzip --best - > publicASIX-1-best.tar.gz
```

O utilitzant una variable de gzip per passar-li opcions:

```
GZIP=-9 tar cvzf publicASIX-1-best.tar.gz prova_public_backup_ASIX
```

Anàlogament per `xz`:

```
XZ_OPT=-9 tar cvJf publicASIX-1-best.tar.xz prova_public_backup_ASIX
```

o també

```
tar cvf - prova_public_backup_ASIX | xz  --best - > publicASIX-1-best.tar.xz
```

(Podem comprovar que les millores no són gran cosa respecte a la que tenen per defecte)


##### Exercici 2

Genereu un paquet-2 comprimit amb tota la documentació pdf respectant la seva
estructura de directoris.

**Solució**

Aquí no farem servir ràtio de compressió màxima, però si es necessites ja sabem
com fer-ho per l'exercici anterior.

```
tar czvf paquet-2.tar.gz $(find ASIX1 -name "*.pdf")
```

##### Exercici 3

Afegiu al paquet anterior tota la documentació .txt i afegir-hi les noves
versions de documents pdf (si cal simular-ne actualitzacions).

**Solució**

Modifiquem la data d'un .pdf:

```
touch ASIX1/M01/TLDP/guia-admin-xarxes.pdf
```

Com que al comprimit no es poden afegir fitxers el que podem fer és:

1. descomprimir
2. afegir els fitxers *.pdf* més nous (modificats després de la data del paquet)
3. tornar a comprimir

El pas 1 de descompressió és:

```
gunzip paquet-2.tar.gz
```

El pas 2 el podem fer de dues maneres:

* Opció 1: trobar amb `find` quins fitxers s'han actualitzat (i.e. modificats després de la data del paquet) i afegir aquests fitxers amb l'opció `-r` *append*:

	```
	tar rvf paquet-2.tar $(find ASIX1 -name *.pdf -newer paquet-2.tar)
	```

* Opció 2: que controli l'actualització l'opció `-u` de tar

	```
	tar uvf paquet-2.tar fitxer.pdf
	```

Tant en un cas com en l'altre el fitxer es guarden totes les versions al fitxer *tar*, però si és fes l'extracció només quedaria la versió més nova. Tot i així si volguéssim eliminar una versió antiga podríem intentar jugar amb les opcions `--compare` i `--delete`.

Per últim hauríem de tornar a comprimir:

```
gzip paquet-2.tar
```

##### Exercici 4

Genereu un paquet-4 comprimit amb tota la documentació dels crèdits M01, M05 i
M07 que permeti la instal·lació automàtica amb ruta absoluta a
`/usr/share/doc/ASIX`.

**Solució**

```
tar --transform="s,ASIX1,/usr/share/ASIX," -czvf paquet-4.tar.gz ASIX1 --show-transformed-names
```

L'anterior opció `--show-transformed-names` ja ens mostra el canvi, però el podem tornar a mostrar amb:

```
tar -tzvf paquet-4.tar.gz
```

##### Exercici 5

Restaureu tots els fitxers txt del paquet-1 a una nova ubicació a tmp.

**Solució**

```
mkdir tmp && tar -xJvf paquet-1.tar.xz *.txt -C tmp 
```

##### Exercici 6

Elimineu del paquet-2 tots els fitxers txt del crèdit M05. 

**Solució**

```
tar -f paquet-2.tar --delete M05*
```

### Tipus de Backups: complet, diferencial, incremental


Estratègia de backup que utilitza el millor dels 3 *mons*: 

	* es fa un backup a l'inici de més. 
	* es fa un incremental cada dos dies.
	* es fa un diferencial cada setmana.

##### Exercici 7

Genera un backup complet (usant `tar`) del home de l'usuari pere complint:

+ El fitxer de backup es dirà "pere-complet-\<data\>.tgz", és a dir,
+ El fitxer tindrà la data en que s'ha fet el backup.
+ Els fitxers de backup es desen a /tmp/backups.

**Solució**

```
tar --listed-incremental=/tmp/backups/complet-$(date +%Y%m%d).snar -czvf /tmp/backups/pere-complet-$(date +%Y%m%d).tgz /home/user/pere
```

Suposem que el fitxer *snar* obtingut (després d'executar-se l'ordre date ... )
és `complet-20180101.snar`, aquest és el que farem servir per referir-nos al
complet.

Ara copiem:

```
cp /tmp/backups/complet-20180101.snar /tmp/backups/base-incremental.snar
```

*Explicació d'aquesta instrucció al següent exercici*

##### Exercici 8

Genera un backup incremental (usant `tar`) del home del'usuari pere. El fitxer
de backup es dirà "pere-incremental-\<data\>.tgz", és a dir, el fitxer tindrà la
data en que s'ha fet el backup. Fer-ne un cada dos dies.

**Solució**

Continuant de l'anterior exercici (a on base-incremental.snar originalment és
el complet):

```
tar --listed-incremental=/tmp/backups/base-incremental.snar -czvf /tmp/backups/pere-incremental-$(date +%Y%m%d).tgz /home/user/pere
```

i això ho executariem cada dos dies.

Per executar aquesta ordre `tar` necessitem tenir el fitxer *snar*
(base-incremental.snar) amb les darreres modificacions. La instrucció que
acabem d'executar llegeix aquest fitxer que conté *metadades* amb informació
relativa als fitxers del backup anterior (en aquest cas el complet). 

##### Exercici 9

Genera un backup diferencial (usant tar) del home de l'usuari pere. El fitxer
de backup es dirà "pere-diferencial-\<data\>.tgz". Fer-ne un passada una setmana
del backup complet. (es fa a partir del complet)

**Solució**

```
cp /tmp/backups/complet-20180101.snar /tmp/backups/base-diferencial.snar
tar --listed-incremental=/tmp/backups/base-diferencial.snar -czvf /tmp/backups/pere-diferencial-$(date +%Y%m%d).tgz /home/user/pere
```

El proper dia que es vulgui fer un diferencial s'haurà de fer un altre cop les
dues instruccions anteriors: fixem-nos que tornaríem a fer servir com a fitxer
*snar* el del complet original.

##### Exercici 10

*Opcional*

Genereu un paquet-10 tar comprimit que conté tots aquells fitxers inclosos en
una llista de fitxers (trajectòries absolutes) a desar. Suposem que el fitxer que conté la llista es files-list.txt

**Solució**

```
tar czvf paquet-10.tar.gz --files-from=files-list.txt
```

##### Exercici 11

*Opcional*

Genereu un paquet-11 tar comprimit que desi tota la documentació dels crèdits
M01, M05 i M07 exceptuant els fitxers .sh, .pka, .img, .tgz i .zip. 

**Solució**

```
tar czvf paquet-11.tar.gz ASIX1 --exclude=*.sh --exclude=*.pka --exclude=*.img -exclude=*.tgz --exclude=*.zip
```

OBS: Recomanable llegir practica_backup.md amb les backups incrementals de nivell n
