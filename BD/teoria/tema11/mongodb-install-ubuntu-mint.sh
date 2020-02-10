#!/bin/bash
# Autor:  		Jorge Rodriguez Campos
# Fecha:  		dd/mm/yyyy
# Descripcion:	Script de instalación de Mongo
#               Basado en https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

echo "Instalando MongoDB"

echo "1. Importando llave publica"

sudo apt-key adv --keyserver \
hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

echo "2. Creando archivo list"

echo "deb [ arch=amd64,arm64 ] \
https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 \
multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

echo "3. Actualizando BD de paquetes"

sudo apt-get update

echo "4. Instalando paquetes"

sudo apt-get install -y mongodb-org

echo "Listo!"
