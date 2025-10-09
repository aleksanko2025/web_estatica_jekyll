---
layout: post
title: Instalación MongoDB (Debian 13)
date: 2025-10-08
categories: [Bases de Datos, mongodb, 2ºASIR]
---

![alt](https://imgs.search.brave.com/rIljDd3e-JZc7DhL7Hs79Ut1ctqPYeMwviiERXYrfo8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9yYXcu/Z2l0aHVidXNlcmNv/bnRlbnQuY29tL0pv/bkRvdHNveS9WZWN0/b3ItTG9nby9tYXN0/ZXIvTG9nb3MvbW9u/Z29kYi9Nb25nb0RC/LnN2Zw)

# Instalación de servidor MongoDB

Un pequeño tutorial para la instalación de MongoDB bajo Debian 13 (trixie).

## Instalación de paquetería necesaria

```bash
sudo apt install curl gnupg
```

## Importamos clave GPG (al no estar Mongo en los repositorios oficiales de Debian)

```
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
```

## Añadimos los repositorios al sources list

```bash
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

## Instalamos los paquetes de MongoDB

```bash
sudo apt update
sudo apt install -y mongodb-org
```

## Aseguramos que el servicio inicie al arrancar

```bash
sudo systemctl enable mongod.service
```

## Acceder a la shell de Mongo

```bash
mongosh
```
