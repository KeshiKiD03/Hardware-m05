### Instal·lació Debian 9 (Stretch) a l'Escola del Treball

##### Sistema d'instal·lació: memòria USB

Farem una instal·lació del sistema operatiu Debian (versió 9: Stretch) des d'un
pen USB. Deixem pendent instal·lació de Debian des de Fedora, molt interessant
però una mica complex i instal·lació via xarxa (requereix configurar fitxers
crítics del nostre sistema).


##### Preparació (partició) disc dur destí 

Tenint en compte la nostra instal·lació actual:

- Taula de particions DOS amb un màxim de 4 particions primàries.
- Una partició primària estesa ja utilitzada per les dues Fedores i la swap

Crearem una 2a partició primària de tipus ext4 de 100 GB a on muntarem el
nostre Debian a `/` i reutilitzarem la swap dels Fedora's.

```
fdisk /dev/sda  # Només creem la partició. El formateig ja el farà la instal·lació de Debian
```

##### Preparació de la memòria USB

Basant-nos en [Preparing Files for USB Memory Stick Booting](https://www.debian.org/releases/stable/amd64/ch04s03.html.en)

Ens baixem la imatge que volguem, al nostre cas utilitzarem la imatge de Debian
(*current* que serà l'estable, l'actual) i de 64 bits. Optarem pel CD
d'instal·lació via xarxa que trobem en [aquest
enllaç](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/)

A la instal·lació que fem des de l'institut per no repetir la mateixa petició
la demanem a gandhi a on ja la tenim baixada:

```
cd /tmp
wget ftp://gandhi/pub/images/debian-9.3.0-amd64-netinst.iso
```

Xequejem amb molta cura (amb `mount` per exemple) quina és la lletra x que
representa la nostra memòria USB: `/dev/sdx`. Si per exemple és la lletra *b* i
la partició és la *1* ja podem desmuntar la memòria:

```
umount /dev/sdb1  # Si n'hi ha més particions de /dev/sdb s'han de desmuntar també
```

Comprovem que ja no n'hi ha cap partició del pen USB muntada amb `mount`

Cremem la imatge de debian. Això **eliminarà tot el que tinguem al pen usb**:

```
cat /tmp/debian-9.3.0-amd64-netinst.iso > /dev/sdb
sync	# Perquè no es deixi per escriure alguna cosa que estigui als buffers
```

Si el maquinari necessita *firmware* privatiu la mateixa pàgina proporciona una
recepta per tenir tot aquest *firmware* ja instal·lat al mateix pen USB. Molt
recomanable per a portàtils. [O fins i tot una imatge amb les dues
coses](https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/9.3.0+nonfree/amd64/iso-cd/)

##### Instal·lació de Debian des del pen USB

Reiniciem el sistema i seleccionem del menu d'arrencada l'opció de la memòria
USB.

Escollim les opcions més semblants possibles a les escollides durant
l'instal·lació de Fedora: 

- instal·lació gràfica
- idioma d'instal·lació anglès
- teclat català
- hora d'Espanya
- instal·lació particions manual:
	+ escollim la partició abans creada per muntar `/` (tipus ext4)
	+ reutilitzem la mateixa *swap* dels fedoras
- **No instal·lar el GRUB**
- temps UTC


##### Post-instal·lació

Com que no hem instal·lat el GRUB (decisió que en un altre entorn de treball
podem canviar) haurem d'afegir les línies al GRUB que ja tenim instal·lat del
nostre Fedora.

Arrancarem el Fedora que té el GRUB (el del matí) i farem servir una eina
gràfica molt senzilla d'utilitzar que prèviament s'haurà d'instal·lar:

```
dnf install grub-customizer
```

L'executem com a root i després d'una estona haurà reconegut el nostre nou
sistema Debian, guardem i sortim.

Finalment xequegem el fitxer que conté la informació dels repositoris dels
nostres paquets: `/etc/apt/sources-list`

Podria ser que aquest fitxer només contingués el component *main* i ens
interessés afegir d'altres com poden ser *contrib* o en algún cas *non-free*.
Més informació: https://wiki.debian.org/SourcesList

És interessant fer un cop d'ull als enllaços que surten al fitxer
`/etc/apt/sources-list` per veure com es fa la *màgia*. 

