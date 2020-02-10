--Elaborado por: Arteaga Lira Carlos Alberto
--Fecha: 19 de mayo dle 2018
--Otorgando privilegios a cada PDB para otorgar privilegios de creacion de triggers

prompt Conectando a calbd_s1 con usuairo sys
connect sys/system@calbd_s1 as sysdba
prompt otorgando privilegios para crear triggers
grant create any trigger to consultora_bdd;
prompt Listo

prompt Conectando a calbd_s2 con usuairo sys
connect sys/system@calbd_s2 as sysdba
prompt otorgando privilegios para crear triggers
grant create any trigger to consultora_bdd;
prompt Listo

exit
