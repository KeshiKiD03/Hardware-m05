### Com fer una còpia de seguretat completa, incremental i diferencial amb *tar*

Recorden que estem parlant de full, incremental & differential backups

##### Definició de nivell de còpia de seguretat n

Extret de la
[wikipedia](https://en.wikipedia.org/wiki/Incremental_backup#Multilevel_incremental):

> A more sophisticated incremental backup scheme involves multiple numbered
> backup levels. A full backup is level 0. A level n backup will back up
> everything that has changed since the most recent level n-1 backup. Suppose
> for instance that a level 0 backup was taken on a Sunday. A level 1 backup
> taken on Monday would include only changes made since Sunday. A level 2
> backup taken on Tuesday would include only changes made since Monday. A level
> 3 backup taken on Wednesday would include only changes made since Tuesday. If
> a level 2 backup was taken on Thursday, it would include all changes made
> since Monday because Monday was the most recent level n-1 backup.


Definim un backup complet com un backup de nivell 0. I direm que un backup de nivell *n* és aquell backup que que conté tot el que ha canviat des del backup més actualitzat de nivell *n-1*.

Imaginem per exemple la següent estratègia:

+ el diumenge es fa un backup de nivell 0
+ el dilluns un incremental respecte el dia anterior
+ el dimarts un incremental respecte el dia anterior
+ el dimecres un incremental especte el dia anterior
+ el dijous un incremental respecte dos dies abans (dilluns)

**Pregunta**

Quins són els respectius backups levels?

**Resposta**

+ el diumenge es fa un backup de nivell 0
+ el dilluns un incremental  (backup de nivell 1)
+ el dimarts un incremental (backup de nivell 2)
+ el dimecres un incremental (backup de nivell 3)
+ el dijous un diferencial respecte el dilluns (backup de nivell 2)

Anem a adaptar a la nostra política més bàsica de backups aquest concepte de nivell de backup.

Si pensem que per a nosaltres:

* un incremental bàsic vol dir que cada dia es fa un backup de les diferències respecte al dia anterior
* un diferencial sempre fa còpia respecte al dia del backup complet.

Podem concloure que:

+ Un backup complet sempre és de nivell 0
+ Un backup diferencial sempre és com un incremental però respecte al dia de backup complet, per tant sempre serà de nivell 1
+ Un backup incremental sempre serà d'un nivell més respecte al dia que es fa.

O sigui que un incremental fa créixer el nivell de backup, mentre que un diferencial sempre és 1.

Una possible política de backups podria ser:

![BackupLevels.png](BackupLevels.png)

**Pregunta:**

Quan s'hagi de restaurar un backup de nivell n, quants fitxers seran necessaris?

**Resposta**

n+1, de nivell 0 (full backup) només 1 fitxer (0+1), per al nivell 1 necessitam
2 backups el del complet i el del dia respecte al complet (1+1) ...

##### Creació de dos scripts per fer proves

Utilitzarem dos scripts per practicar la còpia de seguretat:

+ L'script [crea_estructura_directori.sh](crea_estructura_directori.sh) per
crear aquesta estructura de directori:

	```
	directori_prova
	├── a
	├── bar
	│   └── c
	└── foo
	    ├── b
	    └── baz
		└── d

	3 directories, 4 files
	```

+ L'script [canvia_estructura_directori.sh](canvia_estructura_directori.sh) per actualitzar/canviar aquesta estructura, modificant directoris i fitxers:

	```
	directori_prova
	├── a
	├── bar
	│   ├── c
	│   └── new7577
	│       └── 7577
	├── e
	└── foo
	    └── b
	
	3 directories, 5 files
	```

##### Creació de backup complet

Executem l'script de creació de l'estructura `directori_prova`:

```
./crea_estructura_directori.sh
```

```
tar -czpf prova_backup.tar.gz directori_prova
```

Simulem un desastre al nostre sistema, de manera que perdem aquest directori:

```
rm -r directori_prova
```

Restaurem la còpia de seguretat:

```
tar -xzf prova_backup.tar.gz
```

Aquesta seria la manera de treballar amb backups complets.

##### Creació d'un backup incremental

Ja coneixem el backup incremental. Hi ha diferents opcions i variants. Els
extrems són els que anomenem *incremental* i *diferencial*. Podríem
plantejar-nos un parell d'opcions per fer el backup de tota una setmana:

+ Cas senzill: 7 backups de nivell 1
+ Cas complex: backups de nivell 1 fins a 7

El cas senzill necessita més espai de disc, però té una restauració més
senzilla. Òbviament el cas complex necessita menys espai però per contra
necessitaria una restauració seqüencial per recuperar les dades el setè dia.

Treballem amb el cas senzill, això ens permetrà restaurar el directori del qual
fem el backup a canvi d'utilitzar més espai:

Per utilitzar aquests backups incrementals necessitem l'anterior backup, al
nostre cas sempre serà el backup complet.

Per si de cas hem fet diferents canvis, tornem a començar:

```
rm prova_backup.tar.gz
rm -r directori_prova
./crea_estructura_directori.sh
```

Ara ja ens trobem a la situació inicial:

```
tar --listed-incremental prova_backup.snar -czpf prova_backup_full.tar.gz directori_prova
```

El fitxer _*.snar_ guarda la informació referent als canvis que hi ha respecte al darrer *backup*.

Aquesta ordre sembla exactament igual a la que hem fet servir abans pel backup complet, la única
diferència veiem que és el nou fitxer *snar* que ens ha creat.

En efecte, quan no existeix aquest fitxer *snar* (snapshot+tar) obtenim un backup de nivell 0 (backup complet). Si hagués existit aconseguiríem un backup incremental de nivell 1 més gran que el backup descrit al fitxer tar

Anem a guardar una còpia d'aquest fitxer per futurs backups que vulguin partir d'aquest backup complet:

```
cp prova_backup.snar prova_backup.snar.bak
```

Anem a fer veure que ha passat un dia i que han hagut canvis:

```
./canvia_estructura_directori.sh
directori_prova
├── a
├── bar
│   ├── c
│   └── new7779
│       └── 7779
├── e
└── foo
    └── b

3 directories, 5 files
```

Fem llavors el backup incremental de nivell 1:

```
tar --listed-incremental prova_backup.snar -czpf prova_backup_incremental.tar.gz directori_prova
```

La darrera ordre ens ha creat un altre tar i ha modificat el contingut del
*snar* afegint informació sobre les actualiztacions que han hagut respecte a la
darrera vegada que es va fer un backup.

Com que hem fet una còpia del fitxer snar d'abans (interessant comparar-los i veure
que són diferents) podrem fer un altre backup de nivell 1 per un altre dia.

**Restaurem**

Una manera de fer-ho és per fases, en efecte, primer descomprimim el full i després l'incremental:

```
rm -r directori_prova # elimino el directori simulant un desastre 
tar -xzpf prova_backup_full.tar.gz # descomprimim el complet
tree -C directori_prova # Comprovem que era la situació que teníem el primer dia
tar -xzpf prova_backup_incremental.tar.gz # descomprimim l'incremental
tree -C directori_prova # Comprovem que es la situació del "segon dia"
```

Però alerta, d'aquesta manera em recupera tots els fitxers/directoris, també el
que havia eliminat (directori `baz`)

De manera que si estic plenament segur de que el que volem és reflectir la
situació del 2on dia hauré de fer gairebé el mateix, tan sols afegir una opció a l'incremental:

```
rm -r directori_prova # tornem a simular que partim de zero
tar -xzpf prova_backup_full.tar.gz # descomprimim el complet
tar --incremental -xzpf prova_backup_incremental.tar.gz # descomprimim l'incremental
tree -C directori_prova # Ara sí que és la situació del "segon dia"
```

Ara ja veiem que el directori `baz` no hi és.

Si intentem fer un cop d'ull amb alguna eina gràfica com pot ser el `file-roller` no obtindrem informació dels fitxers que s'eliminaran.
Sí que ho podrem esbrinar jugant amb la següent ordre, que no descomprimeix, sinó que només informa:

```
tar --incremental  -tvvzpf prova_backup_incremental.tar.gz 

drwxrwxr-x pingui/pingui    17 2018-03-12 01:17 directori_prova/
N a
D bar
Y e
D foo

drwxrwxr-x pingui/pingui    13 2018-03-12 01:17 directori_prova/bar/
N c
D new8230

drwxrwxr-x pingui/pingui     7 2018-03-12 01:17 directori_prova/bar/new8230/
Y 8230

drwxrwxr-x pingui/pingui     4 2018-03-12 01:17 directori_prova/foo/
Y b

-rw-rw-r-- pingui/pingui    27 2018-03-12 01:17 directori_prova/e
-rw-rw-r-- pingui/pingui    30 2018-03-12 01:17 directori_prova/bar/new8230/8230
-rw-rw-r-- pingui/pingui    44 2018-03-12 01:17 directori_prova/foo/b
```

A on **N** vol dir que el fitxer **N**o hi és a l'arxiu, **Y** vol dir que *Y*es està a l'arxiu, per a la resta [aquest enllaç](https://www.gnu.org/software/tar/manual/html_node/Dumpdir.html#SEC195)

**Pregunta**

Quin tipus de backup acabem de fer, segons la definició més coneguda, *incremental* o *diferencial*?

**Resposta**

Com que només hem fet el backup complet i un backup el dia següent amb les
actualitzacions, tant podem dir que es tracta d'un diferencial com d'un
incremental de nivell 1.

##### Exercici

Aprofitant els scripts simuleu que passen 3 dies i per tant fabriquem un backup
complet del 1er dia (nivell 0), un incremental del 2on dia (nivell 1) i un
incremental del 3er dia (nivell 2). Haureu d'executar una vegada l'script de
creació de l'estructura i dues vegades l'script que actualitza. Posteriorment
simuleu que s'ha eliminat tot i que heu der restaurar al 3er dia.

**Solució**

```
[pingui@localhost tmp]$ ./crea_estructura_directori.sh
directori_prova
├── a
├── bar
│   └── c
└── foo
    ├── b
    └── baz
        └── d

3 directories, 4 files
```

```
tar --listed-incremental prova_backup.snar -czpf prova_backup_full.tar.gz directori_prova
```

```
[pingui@localhost tmp]$ ./canvia_estructura_directori.sh
directori_prova
├── a
├── bar
│   ├── c
│   └── new4033
│       └── 4033
├── e
└── foo
    └── b

3 directories, 5 files
```

```
tar --listed-incremental prova_backup.snar -czpf prova_backup_incremental_dia1.tar.gz directori_prova
```

```
rm: cannot remove 'directori_prova/foo/baz': No such file or directory
directori_prova
├── a
├── bar
│   ├── c
│   ├── new4033
│   │   └── 4033
│   └── new4078
│       └── 4078
├── e
└── foo
    └── b

4 directories, 6 files
```

```
tar --listed-incremental prova_backup.snar -czpf prova_backup_incremental_dia2.tar.gz directori_prova
```

Amb això tinc 3 fitxers:

```
ls *.tar.gz
prova_backup_full.tar.gz  prova_backup_incremental_dia1.tar.gz  prova_backup_incremental_dia2.tar.gz
```

Restaurem al dia 3:

```
rm -r directori_prova # elimino el directori simulant un desastre
tar -xzvf prova_backup_full.tar.gz # aquí hem restaurat al dia 1
tar --incremental -xzvf prova_backup_incremental_dia1.tar.gz # aquí hem restaurat al dia 2
tar --incremental -xzvf prova_backup_incremental_dia2.tar.gz # aquí hem restaurat al dia 3
```

Comprovem que no tenim la mateixa situació que al dia 3:

```
[pingui@localhost tmp]$ tree -C directori_prova/
directori_prova/
├── a
├── bar
│   ├── c
│   ├── new4033
│   │   └── 4033
│   └── new4078
│       └── 4078
├── e
└── foo
    └── b

4 directories, 6 files
```


Pràctica extreta d'[aquest enllaç](http://paulwhippconsulting.com/blog/using-tar-for-full-and-incremental-backups/)

