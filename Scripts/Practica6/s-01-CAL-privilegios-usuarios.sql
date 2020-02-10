--@Autor:	Carlos Alberto Arteaga Lira
--@Fecha creacion:	20/04/2018
--@Descripcion:	PRIVILEGIOS DE USUARIOS

prompt Conectandose a calbd_s1 como usuario SYS
connect sys@calbd_s1 as sysdba
grant create database link to consultora_bdd;
grant create procedure to consultora_bdd;

prompt Conectandose a calbd_s2 como usuario SYS
connect sys@calbd_s2 as sysdba
grant create database link to consultora_bdd;
grant create procedure to consultora_bdd;
