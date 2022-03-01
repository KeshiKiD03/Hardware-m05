# M05 - Fonaments de Maquinari
## Escola Del Treball
### 2HISX 2021-2022
### Aaron Andal

https://gitlab.com/edtasixm05/m05-hardware/-/tree/master/UF2_3_Virtualization

## INSTALAR EL LIBVIRT

* apt-get install virt-manager

## MODIFICAR EL LIBVIRT para usuario nomrla

* sudo getent group libvirt

* sudo systemctl stop libvirtd

* usermod -a G libvirt $(whoami)

* sudo nano /etc/libvirt/libvirt.conf

unix_sock_group = "libvirt"

unix_sock_rw_perms = "0770"

* sudo systemctl restart libvirtd

* systemctl status libvirtd

## REPASO DE CONFIGURACIÓN

$ uname -a

$ cat /etc/os-release

## RUTA DE LAS MÁQUINAS

/var/lib/libvirt/images

/opt/images

## INSTALAR VIA HTTP

* DEBIAN
http://ftp.us.debian.org/debian/dists/Debian11.2/main/installer-amd64/

* FEDORA32
https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/

* UBUNTU20
http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/

## INSTALAR USANDO NETINST (Descargar)

* Fedora 32 netinst 579M
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/30/Workstation/x86_64/iso/Fedora-Workstation-netinst-x86_64-30-1.2.iso

* Debian 11 Bullseye netinst amd64 396M
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso

* Debian 11 Bullseye netinst amd64 396M
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso

## Imatges Cloud (No need Download)

## Eines 

virtVirt-manager

Virt-install

Virt-shell

qemu-xxxx

Virt-clone

Virt-image

Virt-convert

Virt-top

Virt-viewer

## USUARIO - user:live

## Práctica 2 - Virt Install 

1. Crear una VM partint d’una imatge ja existent: debian qcow2. Assignar-limemòria, cpu, nom, decsripció.

virt-install --name=Debian11 --description=root:nopassword --vcpus=2 --ram=1024 --import --disk path=/opt/imatges/debian-11-nocloud-amd64-20220121-894.qcow2 &

2. Crear una VM partint d’una imatge ja existent: debain o DSL o Alpine. Assignar-litambé una unitat de disc extra.

virt-install --name=Debian11 --description=root:nopassword --vcpus=2 --ram=1024 --import --disk size=4 --disk path=/opt/imatges/debian-11-nocloud-amd64-20220121-894.qcow2 &

3. Crear una VM que engega una Live i té assignat espai d’emmagatzemament amb un disc extra.

virt-install --name=Debian11 --description=root:nopassword --vcpus=2 --ram=1024 --import --disk size=4 --disk path=/opt/imatges/debian-11-nocloud-amd64-20220121-894.qcow2 &

4. Generar amb dd una imatge raw de la partició ‘minilinux’ de l’aula. Generar unaVM que utilitzi aquesta imatge raw.

dd if= of=

5. Crear una VM amb un disc en blanc i una iso netinst de Debian i realitzar unainstal·lació minimal.

6. Crear una VM amb un disc en blanc i una iso netinst de fedora i realitzar unainstal·lació desatesa.

7. Generar un USB  d’instal·lació de Debian planxant la so d’instal·lació al USB.Crear una VM amb un disc en blanc que utilitzi el USB real com a font de lainstal·lació.

8. Crear una VM basada en la imatge Cloud de Fedora32. Modificar-la ambvirt-sysprep per assignar-li a root el password habitual.

9. Crear una VM Windows partint de les màquines prefabricades de prova queproporciona el propi Windows.

## 

##

##

##

##