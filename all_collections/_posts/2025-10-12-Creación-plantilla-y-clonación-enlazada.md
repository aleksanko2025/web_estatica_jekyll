---
layout: post
title: Plantilla y clonación enlazada KVM/QEMU + libvirt
date: 2025-10-12
categories: [IaC, Virt-Manager, KVM, QEMU, 2ºASIR]
---

![alt](https://pm1.aminoapps.com/6204/eae82405edfa2ffe445941d2e072ade2acfbd518_hq.jpg)

Estos apuntes han sido elaborados a partir de la práctica personal, con inspiración y guía en los materiales creados por **José Domingo Muñoz**, a quien agradezco por compartir sus conocimientos y experiencias en este tema.

Este documento explico cómo crear una **plantilla base de Debian 12** en KVM/QEMU y cómo realizar **clonaciones enlazadas** para ahorrar espacio en disco y acelerar la creación de nuevas máquinas virtuales.

## Instalación y configuración inicial

Primero debemos hacer una **instalación de máquina normal** y configurarla a nuestro gusto con las herramientas básicas que utilizaremos en cualquier máquina que creemos.

Una vez terminada la instalación y configuración, **generalizamos la máquina** para que los clones no hereden configuraciones como claves SSH, hostname, etc.

```bash
sudo virt-sysprep -d debian12 --hostname plantilla-debian12 --firstboot-command "dpkg-reconfigure openssh-server"
```

## Compactar la imagen

Compactamos la imagen para eliminar bloques vacíos y reducir su tamaño en disco:

```bash
sudo virt-sparsify --compress /var/lib/libvirt/images/debian12.qcow2 /var/lib/libvirt/images/plantilla-debian12-comprimida.qcow2
```

Reemplazamos la imagen por la nueva comprimida:

```bash
sudo mv /var/lib/libvirt/images/plantilla-debian12-comprimida.qcow2 /var/lib/libvirt/images/debian12.qcow2
```

### Proteger la plantilla

Para evitar encender accidentalmente la plantilla, configuramos la imagen como solo lectura:

```bash
sudo chmod 444 /var/lib/libvirt/images/debian12.qcow2
```

Podemos también cambiar el nombre de la máquina para mayor claridad:

```bash
virsh domrename debian12 plantilla-debian12
```

## Clonación enlazada

Ahora creamos un volumen enlazado (backing store) basado en la plantilla base.
Este volumen no puede ser mayor que el tamaño de la plantilla.

```bash
virsh domblkinfo plantilla-debian12 vda --human
```

Creamos el nuevo volumen enlazado:

```bash
virsh vol-create-as default debian12-backing.qcow2 5G --format qcow2 --backing-vol debian12.qcow2 --backing-vol-format qcow2
```

También se puede hacer con qemu-img:

```bash
sudo qemu-img create -f qcow2 -b /var/lib/libvirt/images/debian12.qcow2 -F qcow2 /var/lib/libvirt/images/debian12-backing.qcow2 15G

virsh pool-refresh default
```

## Creación de máquina a partir del backing store

Creamos una nueva máquina virtual basada en el backing store utilizando virt-install:

```bash
virt-install --connect qemu:///system \
    --virt-type kvm \
    --name otra-debian12 \
    --os-variant debian12 \
    --disk path=/var/lib/libvirt/images/debian12-backing.qcow2 \
    --memory 2048 \
    --vcpus 2 \
    --import
```

También podemos hacerlo con virt-clone:

```bash
virt-clone --connect=qemu:///system \
    --original plantilla-debian12 \
    --name otra-debian12 \
    --file /var/lib/libvirt/images/debian12-backing.qcow2 \
    --preserve-data
```
