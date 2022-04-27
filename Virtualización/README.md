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

`/var/lib/libvirt/images`

`/opt/images`

## INSTALAR VIA HTTP

* DEBIAN
http://ftp.us.debian.org/debian/dists/Debian11.2/main/installer-amd64/

* FEDORA32
https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/

* UBUNTU20
http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/

## INSTALAR USANDO NETINST (Descargar)

Es tracta d’imatges ISO d’instal·lació dels sistemes operatius que no contenen tot el software d’instal·lació i per tant caben en un CD ocupant al voltant de 500MB. 

El procediment d’instal·lació va a buscar el software als repositoris d’internet.

* Fedora 32 netinst 579M
https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/30/Workstation/x86_64/iso/Fedora-Workstation-netinst-x86_64-30-1.2.iso

* Debian 11 Bullseye netinst amd64 396M
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso

* Debian 11 Bullseye netinst amd64 396M
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso

## Imatges Cloud (No need Download)

Màquines virtuals fetes per les pròpies distribucions, són petites i lleugeres per poder-les posar en funcionament directament. 

Poden proporcionar-s een varis formats com per exemple: qcow2 (qemu), raw (en cru), vagrant, per a vmware, per a virtualbox, etc.

* Fedora Cloud 32 Repo: /pub/fedora/linux/releases/32/Cloud/x86_64/images
https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud- Base-32-1.6.x86_64.qcow2


Fedora images have no root/user access. Image should be modified by virt-sysprep to set the root password: 

`virt-sysprep belongs to the libguestfs-tools package: $ sudo virt-sysprep -a Fedora-name-image.qcow2 --root-password password:newpasswd`

*Debian 11 Bullseye nocloud 297M
https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.qcow2

* Ubuntu Cloud Images 20.10 (usb image .IMG 549M)
https://cloud-images.ubuntu.com/releases/groovy/release/ubuntu-20.10-server-cloudimg-amd 64.img

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

## HELP

``virt-install -help`

    --name=NAME
    --ram=MEM
    --vcpus=CPUS
    --os-type=OS-TYPE
    ...

## EJEMPLOS

`virt-install --install fedora29` --> Instala Fedora29

`virt-install --install fedora29 --unattended` --> *Instala Fedora29 de forma Desatesa*

`virt-install \
--connect qemu:///system \
--name my-win10-vm \
--memory 4096 \
--disk size=40 \
--os-variant win10 \
--cdrom /path/to/my/win10.iso` --> *Instala un W10 usando 40GiB de almacenamiento en un default almacenamiento y 4096MiB de RAM*

`virt-install \
--connect qemu:///system \
--memory 8192 \
--vcpus 8 \
--graphics vnc \
--os-variant centos7.0 \
--location http://mirror.centos.org/centos-7/7/os/x86_64/` --> *Instala un Centos 7 desde URL, con recomendaciones de dispositivo default y default storage, especifica VNC en lugar de SPICE y usa 8 virtual CPU y 8193Mib de Memoria RAM.*

`virt-install \
--import \
--memory 512 \
--disk /home/user/VMs/my-debian9.img \
--os-variant debian9` --> *Crea una VM en una Debian9 Disk Image Existente*


-----

#6
*Start serial QEMU ARM VM, which requires specifying a manual kernel*.

 virt-install \
--name armtest \
--memory 1024 \
--arch armv7l --machine vexpress-a9 \
--disk /home/user/VMs/myarmdisk.img \
--boot
--kernel= /tmp/my-arm-kernel,initrd=/tm

------

#7
*Start an SEV launch security VM with 4GB RAM, 4GB+256MiB of hard_limit, with a couple of virtio devices:*

*Note: The IOMMU flag needs to be turned on with driver.iommu for virtio devices.*

*Usage of --memtune is currently required because of SEV limitations, refer to libvirt docs for a detailed explanation.*

virt-install \
--name foo \
--memory 4096 \
--boot uefi \
--machine q35 \
--memtune hard_limit=4563402 \
--disk size=15,target.bus=scsi \
--import \
--controller type=scsi,model=virtio-scsi,driver.iommu=on \
--controller type=virtio-serial,driver.iommu=on \
--network network=default,model=virtio,driver.iommu=on \
--rng driver,iommu=on \
--memballoon driver.iommu=on \

## OTROS EJEMPLOS

#### 1
#### Crear una màquina virtual d'un LiveCD de Fedora: imatge .iso
```
$ virt-install --name=Live01 --ram=512 --nodisks --livecd --cdrom /fc9/vms/Fedora-14-i686-Live-Desktop.iso
```

#### 2
# Crear una màquina virtual d'un LiveCD de Fedora: imatge d'un device USB
```
$ virt-install --name=Live03 --ram=512 --import --disk path=/dev/sdb1 &
```

#### 3
#### Crear una màquina virtual partint d'un virtual-device ja existent
```
$ virt-install --name=win01 --ram=512 --import --disk path=win2003s.img &

$ virt-install --name=lin01 --ram=512 --import --disk path=minif13-pxe-vi.img &
```

#### 4
#### Crear una màquina virtual d'una imatge dd d'una partició
```
$ virt-install --name=lin02 --ram=512 --import --disk path=mini-linux.f13.img &
```

#### 5
#### Crear una imatge virtual a partir d'un device
```
$ virt-install --name=dev01 --ram=512 --import --disk path=/dev/sda2 &

$ virt-install --name=dev02 --ram=512 --import --disk path=/dev/sda &
```

#### 6
#### Crear un virtual-disk com a emmagatzemament per a un d'un Live CD
```
virt-install --name=Live01 --ram=512 --livecd --cdrom Fedora-14-i686-Live-Desktop.iso --disk path=free.img,size=1 &
```

#### 7
#### Crear un virtual-disk nou on fer una instal·lació a partir d'una imatge Live
```
virt-install --name=Live01 --ram=512 --livecd --cdrom Fedora-14-i686-Live-Desktop.iso --disk path=fedora.img,size=2 &
```
#### 8
#### Crear una màquina virtual amb un virtual-disk en blanc per instal·lar-hi un Fedora via xarxa.
```
virt-install --name Linux01 --ram 512 --disk path=fedora3g.img,size=3 --location http://download.fedora.redhat.com/pub/fedora/linux/releases/14/Fedora/i386/os/ &
```
#### 9
#### Crear una màquina virtual usant un virtual-disk ja existent
```
virt-install --name Linux02 --ram 512 --disk path=fedora.img --import
```



## USUARIO - user:live

## Práctica 2 - Virt Install 

1. Crear una VM partint d’una imatge ja existent: debian qcow2. Assignar-limemòria, cpu, nom, decsripció.

virt-install --name Debian11 --description="root:nopassword" --vcpus=2 --ram=1024 --import --disk path='/opt/images/debian-11-nocloud-amd64-20220310-944.qcow2'


2. Crear una VM partint d’una imatge ja existent: debain o DSL o Alpine. Assignar-litambé una unitat de disc extra.

virt-install --name Debian11 --description="root:nopassword" --vcpus=2 --ram=1024 --import --disk path='/opt/images/debian-11-nocloud-amd64-20220310-944.qcow2' --disk size=40,path='/path/new_disk.qcow2'


3. Crear una VM que engega una Live i té assignat espai d’emmagatzemament amb un disc extra.

virt-install --name=alpine --memory 1024 --import --disk path='/opt/images/alpine.qcow2' --livecd
--cdrom /opt/images/alpine-standard-3.15.1-x86_64.iso --boot cdrom --disk size=40,path='/path/new_disk.qcow2'


4. Generar amb dd una imatge raw de la partició ‘minilinux’ de l’aula. Generar unaVM que utilitzi aquesta imatge raw.

dd if=/dev/sda4 of=disk01.raw bs=1k count=2M status=progress

virt-install --name=minilinux --memory 1024 --vcpus=2 --import --disk path='disk01.raw'

5. Crear una VM amb un disc en blanc i una iso netinst de Debian i realitzar unainstal·lació minimal.

virt-install --name debian-netinst --memory 2048 --vcpus 2 --os-type GNU/Linux --os-variant debian10 --disk size=4,path=/var/tmp/debian.qcow2 --cdrom
Debian-Netinst.iso

6. Crear una VM amb un disc en blanc i una iso netinst de fedora i realitzar unainstal·lació desatesa.

virt-install --name fedora-desatesa-netinst --memory 2048 --vcpus 2 --os-type GNU/Linux
--os-variant fedora32 --disk size=4,path=/var/tmp/fedora_unattended.qcow2 --cdrom
Fedora-Netinst.iso --unattended &

7. Generar un USB  d’instal·lació de Debian planxant la so d’instal·lació al USB.Crear una VM amb un disc en blanc que utilitzi el USB real com a font de lainstal·lació.

1. Rufus o DD

dd if=debian-live-10.iso of=/dev/sdd

virt-install --name=Live03-Debian --ram=512 --import --disk path=/dev/sdd &


8. Crear una VM basada en la imatge Cloud de Fedora32. Modificar-la amb virt-sysprep per assignar-li a root el password habitual.

1. Descargarse: https://dl.fedoraproject.org/pub/fedora/linux/releases/32/Cloud/x86_64/images/Fedora-Cloud-Base-32-1.6.x86_64.qcow2

``virt-sysprep -a Fedora-Cloud-Base-32-1.6.x86_64.qcow2 --root-password password:newpasswd``

virt-install --name fedora32-cloud \
--memory 2000 --noreboot \
--os-variant detect=on,name=fedora-unknown \
--cloud-init user-data="/path/to/cloudinit-user-data.yaml" \
--disk=size=10,backing_store="/path/to/Fedora-Cloud-Base-32-1.6.x86_64.qcow2"

9. Crear una VM Windows partint de les màquines prefabricades de prova queproporciona el propi Windows.

## Pràctica-3 Virsh

● 01 Proveu cada una de les ordres de les taules anteriors i anoteu quin és el seu
significat.

● 02 Escriu el conjunct d’ordres necessaries per:
    ○ Engegar una VM ja existent --> virsh start vm
    ○ Llistar la informació de la màquina --> virsh dominfo vm --> Info de la VM
    ○ Llistar la configuració XML de la màquina --> virsh dumpxml vm
    ○ Mostrar un screenshot de la seva pantalla --> virsh snapshot current
    ○ Accedir a la imatge usant un client d’escriptori remot --> virsh vncdisplay
    ○ Fer una pausa de l’execució de la màqina --> virsh suspend vm
    ○ Reanudar la màquina i fer-ne un restart --> virsh start vm ; virsh reboot vm
    ○ Llistar la informació de xarxa de la màquina. --> `virsh net-info default`
    ○ Aturar la màquina --> virsh shutdown vm
    ○ Destruir-la. --> virsh destroy vm ; virsh undefined vm

● 03 Engegar una VM i treballar amb snapshots:
    ○ Crear un snapshot --> virsh snapshot-create-as --domain name --name "name" --description "first"
    ○ Fer modificacions a la màquina --> virsh snapshot-edit --domain name
    ○ Crear un segon snapshoot. --> virsh snapshot-create-as --domain name --name "name02" --description "second"
    ○ Fer modificacions fatals a la màquina. --> virsh snapshot-delete --domain name --snapshotname "debian02"
    ○ Revertir la màquina a l’estat corresponent al primer snapshot. --> snapshot-revert --domain debian10 --snapshotname debian10 --running

## QEMU

Amb les eines de qemu es poden visualitzar les VM de manera ràpida sense engegar virt-manager.

## Pràctica-4 qemu / qemu-img

● 01 Engega usant qemu un DSL linux com per exemple alpine.

qemu-system-x86_64 -cdrom alpine.iso -vga std -m 512

● 02 Engega usant qmeu el gparted live acompanyat d’una imatge qcow2 de disc, com
per exemple el debian11.

dd if=/dev/zero of=file.raw bs=1k count=100k

qemu-img convert -f raw -O qcow2 file.raw file.qcow2

----

qemu-system-x86_64 -cdrom gparted-live-1.4.0-1-amd64.iso -hda file.qcow2 -vga std -m 512

qemu-system-x86_64 -cdrom gparted-live-1.4.0-1-amd64.iso -hda qcow2.qcow2 -vga std -m 512

● 03 Crear un disc raw de 2G anomenat disc01.raw. Mostrar amb info les seves
característiques.
42●

dd if=/dev/zero of=disk01.raw bs=1k count=2000k

qemu-img info disk01.raw

* 04 Convertir un disc raw a un altre format, per exemple al format qcow2. De fet no es
converteix sinó que se’n genera un de nou en aquest format.


qemu-img convert -f raw -O qcow2 file.raw file.qcow2

##

##
