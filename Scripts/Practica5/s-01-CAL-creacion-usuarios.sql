--@Autor:	Carlos Alberto Arteaga Lira
--@Fecha creacion:	29/03/2018
--@Descripcion:	Creacion de usuarios para la maquina pc-cal.

prompt Conectandose a calbd_s1 como usuario SYS
connect sys@calbd_s1 as sysdba
prompt creando usuario consultora_bdd
create user consultora_bdd identified by consultora_bdd quota unlimited on USERS;
grant create session, create table to consultora_bdd;


prompt Conectandose a calbd_s2 como usuario SYS
connect sys@calbd_s2 as sysdba
prompt creando usuario consultora_bdd
create user consultora_bdd identified by consultora_bdd quota unlimited on USERS;
grant create session, create table to consultora_bdd;

prompt Listo
exit
