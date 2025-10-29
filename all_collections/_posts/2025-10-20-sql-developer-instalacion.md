---
layout: post
title: Instalación SQL Developer y conexión TNS
date: 2025-10-29
categories: [Base de datos, Oracle, 2ºASIR]
---

# 🧩 Instalación

```bash
sudo apt update
sudo apt install openjdk-17-jdk
```

Descargamos **SQL Developer** desde la página oficial de Oracle:  
👉 [https://www.oracle.com/database/sqldeveloper/technologies/download/](https://www.oracle.com/database/sqldeveloper/technologies/download/)

Elegimos la opción **“Other Platforms”**.

También podemos hacerlo desde la terminal:

```bash
wget https://download.oracle.com/otn_software/java/sqldeveloper/sqldeveloper-24.3.1.347.1826-no-jre.zip
```

Se descargará un archivo `.zip`.  
Lo descomprimimos, lo cual generará un directorio llamado `sqldeveloper`.

Para arrancar **SQL Developer**:

```bash
bash sqldeveloper/sqldeveloper.sh
```

![alt](https://i0.wp.com/www.sismonda.com.ar/wp-content/uploads/2020/11/image-2.png?w=606&ssl=1)

---

# 🔌 Conexión TNS

Primero comprobamos desde el servidor si el **listener** está activo y vemos el nombre del servicio:

```bash
lsnrctl status
```

Esto nos dará una salida similar a la siguiente (ejemplo):

```
Service "ORCLCDB" has 1 instance(s).
  Instance "ORCLCDB", status READY, has 1 handler(s) for this service...
```

Nos quedamos con el nombre de la instancia **`ORCLCDB`**, que necesitaremos luego para configurar la conexión.

---

## Crear el archivo de configuración TNS

En el cliente, creamos un directorio y un fichero `.ora` donde definiremos la configuración de la conexión:

```bash
mkdir -p ~/.oracle
nano ~/.oracle/tnsnames.ora
```

Dentro del fichero añadimos:

```ora
ORCL =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.122.1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = ORCLCDB)
    )
  )
```

---

## Configurar conexión en SQL Developer

Abrimos **SQL Developer** y vamos a:

**Herramientas → Preferencias → Bases de datos → Avanzada**

Ahí indicamos la ruta del directorio donde se encuentra el fichero `tnsnames.ora`.

---

## Crear la conexión

Creamos una nueva conexión con el alias definido (por ejemplo, `ORCL`), el usuario y la contraseña.

Hacemos clic en **Probar**, y si el estado es **Correcto**, damos a **Conectar** y **Guardar la conexión**.

---

Ya podemos acceder a nuestro **servidor Oracle** con el usuario especificado y empezar a trabajar con nuestras **tablas, registros**, etc. 🗃️
