---
layout: post
title: Instalación GNS3 bajo Debian 12
date: 1948-12-12 10:18:00
categories: [Redes, 1ºASIR]
---

![alt](https://imgs.search.brave.com/vdkaF7loGk4diMnkGXVnQzN_i7pWbK7Rd-g6dhz7yCw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9kb2Nz/LmduczMuY29tL2lt/Zy9sb2dvY29sb3Vy/LnBuZw)

# Instalación de GNS3 y componentes

## Paquetes necesarios para la instalación

```bash
sudo apt install python3 python3-pip python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg git make qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system cmake libpcap-dev build-essential libelf-dev
```

---

## Instalación de UBRIDGE

```bash
git clone https://github.com/GNS3/ubridge.git
cd ubridge
make
sudo make install
cd ..
sudo setcap cap_net_admin,cap_net_raw=ep /usr/local/bin/ubridge
rm -rf ubridge
```

---

## Instalación de DYNAMIPS

```bash
git clone https://github.com/GNS3/dynamips.git
cd dynamips
mkdir build
cd build
cmake ..
make
sudo make install
sudo setcap cap_net_admin,cap_net_raw=ep /usr/local/bin/dynamips
cd ../..
rm -rf dynamips
```

---

## Instalación de VPCS

Instalación estándar:

```bash
sudo apt install vpcs
```

Si hay error con la versión (borrar binario previo):

```bash
sudo rm -f /usr/bin/vpcs /usr/local/bin/vpcs
```

Compilación manual:

```bash
git clone https://github.com/GNS3/vpcs.git
cd vpcs/src

rgetopt='int getopt(int argc, char *const *argv, const char *optstr);'
sed -i "s/^int getopt.*/$rgetopt/" getopt.h
sed -i 's/i386/x86_64/' Makefile.linux
sed -i 's/-s -static//' Makefile.linux

make -f Makefile.linux
strip --strip-unneeded vpcs
sudo mv vpcs /usr/local/bin
```

---

## Creación del entorno virtual

```bash
mkdir gns3-project
cd gns3-project
python3 -m venv .
source bin/activate
```

---

## Instalación dentro del entorno virtual

```bash
pip install gns3-gui gns3-server
```

## Arrancar la aplicación

```
gns3
```

---

## Solución de errores comunes

### Error al iniciar SIP o PyQt5

Si aparece un error relacionado con **SIP** o **PyQt5**, ejecutar:

```bash
pip install sip PyQt5
```

### Error con la consola XTERM

Instalar **xterm** fuera del entorno virtual:

```bash
sudo apt install xterm
```

---

## Salir del entorno virtual

```bash
deactivate
```
