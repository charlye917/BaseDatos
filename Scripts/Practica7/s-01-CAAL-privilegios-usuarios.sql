--@Autor:	Carlos Alberto Arteaga Lira
--@Fecha creacion:	05/05/2018
--@Otorgando permisos a cada pdb

prompt conectandose a s1 como usuario sys
connect sys@calbd_s1 as sysdba
prompt otorgando privilegios para crear sinonimos
grant create synonym to consultora_bdd;
prompt privilegios para crear vistas
grant create view to consultora_bdd;
prompt privilegios para crear tipos de datos
grant create type to consultora_bdd;
prompt privilegios para crear procedimientos
grant create procedure to consultora_bdd;

prompt conectandose a s2 como usuario sys
connect sys@calbd_s2 as sysdba
prompt otorgando privilegios para crear sinonimos
grant create synonym to consultora_bdd;
prompt privilegios para crear vistas
grant create view to consultora_bdd;
prompt privilegios para crear tipos de datos
grant create type to consultora_bdd;
prompt privilegios para crear procedimientos
grant create procedure to consultora_bdd;


