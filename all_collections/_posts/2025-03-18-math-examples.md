---
layout: post
title: Instalación MongoDB (Debian 13)
date: 2025-10-7
categories: [Bases de Datos, 2ºASIR]
---

# Instalación de servidor MongoDB

Un pequeño tutorial para la instalación de MongoDB bajo Debian 13 (trixie).

## Instalación de paquetería necesaria

```
sudo apt install curl gnupg
```

## Importamos clave GPG (al no estar Mongo en los repositorios oficiales de Debian)

```
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
```

## Añadimos el repositorios al sources list

```
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg] https://repo.mongodb.org/apt/debian bookworm/mongodb-org/8.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
```

## Instalamos los paquetes de MongoDB

```
sudo apt update
sudo apt install -y mongodb-org
```

## Aseguramos que el servicio inicie al arrancar

```
sudo systemctl enable mongod.service
```

## Acceder a la shell de Mongo

```
mongosh
```
