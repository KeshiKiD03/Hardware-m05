### Solucions dels exercicis del gestor de paquets DNF

Gestió de paquets i repositoris a Fedora. Instal·lació de software amb *dnf*

##### Exercici 1.

Llisteu tots els paquets instal·lats.

```
dnf list installed
```

```
Installed Packages
GConf2.x86_64                        3.2.6-16.fc24              @koji-override-0
GeoIP.x86_64                         1.6.11-1.fc24              @updates        
GeoIP-GeoLite-data.noarch            2017.07-1.fc24             @updates        
ImageMagick.x86_64                   6.9.3.0-2.fc24             @fedora         
ImageMagick-c++.x86_64               6.9.3.0-2.fc24             @fedora         
ImageMagick-libs.x86_64              6.9.3.0-2.fc24             @fedora         
LibRaw.x86_64                        0.17.2-1.fc24              @koji-override-0
ModemManager.x86_64                  1.6.4-1.fc24               @updates        
ModemManager-glib.x86_64             1.6.4-1.fc24               @updates        
NetworkManager.x86_64                1:1.2.6-1.fc24             @updates   
...
```

##### Exercici 2.

Amb quina opció `dnf` ens mostra a quin paquet pertany l’ordre `useradd`?

```
dnf provides */useradd
```

```
Last metadata expiration check: 6 days, 22:10:09 ago on Sun Jan  7 23:31:33 2018.
shadow-utils-2:4.2.1-8.fc24.x86_64 : Utilities for managing accounts and shadow password files
Repo        : @System

shadow-utils-2:4.2.1-8.fc24.x86_64 : Utilities for managing accounts and shadow password files
Repo        : fedora
```

##### Exercici 3.

Instal·leu el paquet mc.

```
[root@honolulu ~]# dnf install mc -y
Last metadata expiration check: 3:24:49 ago on Sun Jan 14 19:20:42 2018.
Dependencies resolved.
================================================================================
 Package     Arch            Version                     Repository        Size
================================================================================
Installing:
 mc          x86_64          1:4.8.19-5.fc24             updates          1.9 M

Transaction Summary
================================================================================
Install  1 Package

Total download size: 1.9 M
Installed size: 6.7 M
Downloading Packages:
mc-4.8.19-5.fc24.x86_64.rpm                     459 kB/s | 1.9 MB     00:04    
--------------------------------------------------------------------------------
Total                                           406 kB/s | 1.9 MB     00:04     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Installing  : mc-1:4.8.19-5.fc24.x86_64                                   1/1 
  Verifying   : mc-1:4.8.19-5.fc24.x86_64                                   1/1 

Installed:
  mc.x86_64 1:4.8.19-5.fc24                                                     

Complete!
```

##### Exercici 4.

Intenteu instal·lar de nou del paquet mc.

```
dnf reinstall mc  # es torna a instal·lar
```

##### Exercici 5.

Quina ordre em troba tots els paquets que continguin la cadena libreoffice? (Filtra el langpack de català)

```
dnf search libreoffice
```

```
dnf search libreoffice | grep langpack-ca
```

##### Exercici 6.

Actualitzeu (que no instal·leu) el pack de català de libreoffice a la darrera versió. Com actualitzaries tot el sistema?

```
dnf upgrade libreoffice-langpack-ca
```

```
dnf upgrade
```

##### Exercici 7.

Instal·leu el grup Virtualization, al menys de dues maneres diferents.

```
dnf install @Virtualization
dnf group install Virtualization
dnf groupinstall Virtualization
```

##### Exercici 8.

Llisteu tots els grups de paquets.

```
dnf group list
```

##### Exercici 9.

Llisteu tots els repositoris configurats

```
dnf repolist
```

```
repo id                     repo name                                     status
adobe-linux-x86_64          Adobe Systems Incorporated                         3
*fedora                     Fedora 24 - x86_64                            49,722
google-chrome               google-chrome                                      3
isv_ownCloud_desktop        The ownCloud Desktop Client (Fedora_24)          270
jitsi                       Jitsi                                              8
mosquito-atom               Copr repo for atom owned by mosquito               8
rommon-telegram             Copr repo for telegram owned by rommon             2
*rpmfusion-free             RPM Fusion for Fedora 24 - Free                  352
*rpmfusion-free-updates     RPM Fusion for Fedora 24 - Free - Updates        400
*rpmfusion-nonfree          RPM Fusion for Fedora 24 - Nonfree                89
*rpmfusion-nonfree-updates  RPM Fusion for Fedora 24 - Nonfree - Updates     155
spideroak-one-stable        SpiderOakONE Stable Distribution                  14
taw-Riot                    Copr repo for Riot owned by taw                    2
*updates                    Fedora 24 - x86_64 - Updates                  16,498
```

- Per defecte, que ens surt? És a dir, l'ordre que hem utilitzat ens mostra tots els repositoris o només els habilitats (*enabled*)?

	Els que estan habilitats, es pot llegir al *man*:

	> ... Lists all enabled repositories by default.

- si els volem tots, tants els habilitats com els que no (enabled/disabled), quina seria l'ordre?

	```
	dnf repolist [enabled|disabled|all]
	```

##### Exercici 10.

Instal·leu el repositori necessari per poder instal·lar després `riot` (un client del protocol matrix)

```
dnf copr enable taw/Riot
```

En realitat, que hem fet instal·lant aquest repositori? Quines variables em diuen si el respoitori està activat? Quina variable em diu a quina adreça va a buscar els paquets del repositori?

Es crea el fitxer d'extensió _.repo_ corresponent al directori `/etc/yum.repos.d`

```
...
baseurl=https://copr-be.cloud.fedoraproject.org/results/taw/Riot/fedora-$releasever-$basearch/
...
enabled=1
...
```

##### Exercici 11.

Deshabiliteu el repositori anterior amb una ordre des de la consola i després comproveu que ha canviat la variable a la que es feia referència abans. 
Torneu a activar-lo després i instal·leu riot.

```
dnf config-manager --set-disabled taw-Riot
cat /etc/yum.repos.d/_copr_taw-Riot.repo
dnf config-manager --set-enabled taw-Riot
dnf install riot
```

OBS: @System no és un repositori sinó la manera d'indicar que el paquet està instal·lat al sistema
