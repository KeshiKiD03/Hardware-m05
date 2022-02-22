### Solucions dels exercicis del gestor de paquets rpm

Gestió de paquets i repositoris a Fedora. Instal·lació de software amb *rpm*

#### **Consultes**

##### Exercici 1

Llisteu tots els paquets instal·lats

**Solució**

```
rpm -qa
...
mythes-ca-1.5.0-13.fc24.noarch
ctags-5.8-18.fc24.x86_64
evince-nautilus-3.20.1-3.fc24.x86_64
...
```

Podem fer servir una `|`amb l'ordre `sort` o `grep` per ordenar tots els paquets o buscar un paquet concret.


##### Exercici 2

Descarregeu localment i instal·leu el paquet `tftp-server`.

**Solució**

`rpm` permet instal·lar un paquet a partir d'una adreça *URL*, primer el descarregarà i posteriorment l'intentarà instal·lar, però si el que volem és simplement descarrregar (com fa yumdownloader per a Centos ) l'ordre seria:

```
dnf download tftp-server
...
tftp-server-5.2-18.fc24.x86_64.rpm      86 kB/s |  48 kB     00:00
```

Finalment, per instal·lar faríem:

```
# rpm -ivh tftp-server-5.2-18.fc24.x86_64.rpm
Preparing...                                                           ################################# [100%]
Updating / installing...
   1:tftp-server-5.2-18.fc24                                           ################################# [100%]

```

##### Exercici 3

Llisteu els components del paquet `tftp-server`.

**Solució**

Si el paquet està instal·lat:

```
rpm -ql tftp-server
/usr/lib/systemd/system/tftp.service
/usr/lib/systemd/system/tftp.socket
/usr/sbin/in.tftpd
/usr/share/doc/tftp-server
/usr/share/doc/tftp-server/CHANGES
/usr/share/doc/tftp-server/README
/usr/share/doc/tftp-server/README.security
/usr/share/man/man8/in.tftpd.8.gz
/usr/share/man/man8/tftpd.8.gz
/var/lib/tftpboot
```

Si no està instal·lat però el tenim baixat, des del directori on es troba el paquet podem fer:

```
rpm -qlp tftp-server-5.2-18.fc24.x86_64.rpm  # nom de paquet complet
```

També es podria fer servir l'opció `-v` per donar més informació.

##### Exercici 4

Llisteu els fitxers de documentació del paquet `tftp-server`.

**Solució**

```
rpm -qd tftp-server
/usr/share/doc/tftp-server/CHANGES
/usr/share/doc/tftp-server/README
/usr/share/doc/tftp-server/README.security
/usr/share/man/man8/in.tftpd.8.gz
/usr/share/man/man8/tftpd.8.gz
```

Igual que abans aquesta és la solució si el paquet ja està instal·lat. Si està baixat i no instal·lat es fa servir la `p` i el nom complet del paquet.

##### Exercici 5

Llisteu els fitxers de configuració del paquet `tftp-server`.

**Solució**

```
rpm -qc tftp-server
```

Si no hi ha fitxers de configuració no es mostra res. En canvi, un paquet com `httpd` sí que mostraria fitxers de configuració.


##### Exercici 6

Llisteu els fitxers executables del paquet `tftp-server`.

**Solució**

No hi ha una opció pròpia de `rpm` però es pot aconseguir el que ens demanen jugant una mica:

```
rpm -ql tftp-server | grep bin
-rwxr-xr-x   1 root  root   41304 Mar  3  2016 /usr/sbin/in.tftpd
```

Si entenem per executables els *binaris*. Si entenem els executables, és a dir, tots aquells que tenen permissos d'execució podríem fer una instrucció amb un `for`:

```
for file in $(rpm -ql tftp-server); do test -x $file && echo $file ;done
/usr/sbin/in.tftpd
/usr/share/doc/tftp-server
/var/lib/tftpboot
```

##### Exercici 7

Mostreu informació del paquet `tftp-server`.

```
rpm -qi tftp-server

Name        : tftp-server
Version     : 5.2
Release     : 18.fc24
Architecture: x86_64
Install Date: Mon 22 Jan 2018 10:22:46 AM CET
Group       : System Environment/Daemons
Size        : 61015
License     : BSD
Signature   : RSA/SHA256, Thu 03 Mar 2016 10:09:36 AM CET, Key ID 73bde98381b46521
Source RPM  : tftp-5.2-18.fc24.src.rpm
Build Date  : Thu 03 Mar 2016 09:52:35 AM CET
Build Host  : buildvm-06-nfs.phx2.fedoraproject.org
Relocations : (not relocatable)
Packager    : Fedora Project
Vendor      : Fedora Project
URL         : http://www.kernel.org/pub/software/network/tftp/
Summary     : The server for the Trivial File Transfer Protocol (TFTP)
Description :
The Trivial File Transfer Protocol (TFTP) is normally used only for
booting diskless workstations.  The tftp-server package provides the
server for TFTP, which allows users to transfer files to and from a
remote machine. TFTP provides very little security, and should not be
enabled unless it is expressly needed.  The TFTP server is run by using
systemd socket activation, and is disabled by default.
```



##### Exercici 8

Llisteu les dependències del paquet `dhclient`.

Aquí entenem *dependències* en sentit literal, tot el necessari (no només paquets).

Recordem de que si el paquet no està instal·lat però sí baixat podem fer:

```
rpm -qp --requires dhcp-client-4.3.4-4.fc24.x86_64.rpm

/bin/bash
/bin/sh
coreutils
dhcp-common = 12:4.3.4-4.fc24
dhcp-libs(x86-64) = 12:4.3.4-4.fc24
gawk
grep
ipcalc
iproute
iputils
libc.so.6()(64bit)
```

En canvi amb un d'instal·lat és suficient amb:

```
rpm -q --requires tftp-server

/bin/sh
/bin/sh
/bin/sh
libc.so.6()(64bit)
libc.so.6(GLIBC_2.11)(64bit)
libc.so.6(GLIBC_2.14)(64bit)
libc.so.6(GLIBC_2.15)(64bit)
libc.so.6(GLIBC_2.4)(64bit)
```


D'altra banda si ens demanessin quins paquets fan servir `dhclient` podréim trobar-los amb l'ordre:

```
rpm -q --whatrequires dhclient
NetworkManager-1.2.6-1.fc24.x86_64
dracut-network-044-21.fc24.x86_64
```

##### Exercici 9

Llisteu les capabilities del paquet `dhclient`.

```
rpm -qp --provides dhcp-client-4.3.4-3.fc24.x86_64.rpm
```


##### Exercici 10

Llisteu els scripts pre i post instal·lació del paquet `dhclient`.

```
rpm -qp --scripts dhcp-client-4.3.4-3.fc24.x86_64.rpm
```

Al cas anterior no es mostra cap script (aquest paquet no els necessita), en canvi `tftp-server` sí:

```
rpm -q --scripts tftp-server

postinstall scriptlet (using /bin/sh):

if [ $1 -eq 1 ] ; then 
        # Initial installation 
        systemctl --no-reload preset tftp.socket >/dev/null 2>&1 || : 
fi
preuninstall scriptlet (using /bin/sh):

if [ $1 -eq 0 ] ; then 
        # Package removal, not upgrade 
        systemctl --no-reload disable --now tftp.socket > /dev/null 2>&1 || : 
fi
postuninstall scriptlet (using /bin/sh):

if [ $1 -ge 1 ] ; then 
        # Package upgrade, not uninstall 
        systemctl try-restart tftp.socket >/dev/null 2>&1 || : 
fi

```


##### Exercici 11

Identifiqueu a quin paquet pertany l'ordre `useradd`.

```
rpm -qf /usr/sbin/useradd
shadow-utils-4.2.1-8.fc24.x86_64
```

##### Exercici 12

Identifiqueu a quin paquet pertany el `grub`.

Inicialment podríem executar una ordre com:

```
rpm -qf /*/grub*
```

Però això ens donaria moltes sortides, algunes repetides i hauriem de filtrar amb una `|` i un `sort -u`:

```
rpm -qf /*/grub* | sort -u
grub2-2.02-0.38.fc24.x86_64
grub2-tools-2.02-0.38.fc24.x86_64
grubby-8.40-3.fc24.x86_64
grub-customizer-5.0.6-1.fc24.x86_64

```
 
A partir d'aquí es tractaria de saber quin és el paquet que cerquem.

Una altra opció seria pensar en algun executable concret, per exemple `grub2-install` i buscar a on es troba l'executable per després fer una *query* amb `rpm`:

```
[eve@home ~]$ which grub2-install 
/usr/sbin/grub2-install
[eve@home ~]$ rpm -qf /usr/sbin/grub2-install
grub2-tools-2.02-0.38.fc24.x86_64
```

*Ou tout à la fois*:

```
[eve@home ~]$ rpm -qf $(which grub2-install)
grub2-tools-2.02-0.38.fc24.x86_64

```

#### **Instal·lar, actualitzar i esborrar**

##### Exercici 13

Actualitzeu el paquet `mc`.

```
[root@home ~]$ rpm -U mc-4.8.19-5.fc24.x86_64.rpm 
	package mc-1:4.8.19-5.fc24.x86_64 is already installed
```

##### Exercici 14

Elimineu el paquet `mc`.

```
[root@home ~]$ rpm -evh mc
Preparing...                          ################################# [100%]
Cleaning up / removing...
   1:mc-1:4.8.19-5.fc24               ################################# [100%]
```

L'opció d'eliminació és `e` (d'*erase*).


#### **Rebuild**

##### Exercici 15

Regenereu la base de dades de `rpm`.

```
[root@home ~]$ rpm --rebuilddb
```

