--@Autor: Carlos Alberto Arteaga Lira
--@Fecha creacion: 30/03/2018
--@Descripcion: COnsulta de fragmentos creados en cal-pc

Prompt Conectando a S1 - calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
Prompt mostrando lista de fragmentos
select table_name from user_tables order by table_name;

Prompt Conectando a S1 - calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt mostrando lista de fragmentos	
select table_name from user_tables order by table_name;

Prompt Listo
exit
