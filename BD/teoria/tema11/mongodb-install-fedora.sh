#!/bin/bash
# Autor:  		Jorge Rodriguez Campos
# Fecha:  		dd/mm/yyyy
# Descripcion:	Script de instalación de Mongo
#               Basado en https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/

echo "Instalando MongoDB"


echo "1. Creando archivo repo"

sudo touch  /etc/yum.repos.d/mongodb-org-3.6.repo 

echo "2. Escribiendo contenido"

sudo -u root bash << EOF
echo "[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc" > /etc/yum.repos.d/mongodb-org-3.6.repo
EOF

echo "3. Instalando paquetes"

sudo yum install -y mongodb-org