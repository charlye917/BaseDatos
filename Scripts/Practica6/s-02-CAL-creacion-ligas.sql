--@Autor:	Carlos Alberto Arteaga Lira
--@Fecha creacion:	20/04/2018
--@Descripcion:	Creacion de ligas

prompt Creando liga en calbd_s1 hacia calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s1
create database link calbd_s2.fi.unam
using 'calbd_s2';
prompt listo

prompt Creando liga en calbd_s2 hacia calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s2
create database link calbd_s1.fi.unam
using 'calbd_s1';
prompt listo

exits
