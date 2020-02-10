--@Autor: Carlos Alberto Arteaga Lira
--@Fecha creacion: 29/03/2018
--@Descripcion: Creacion de los objetos en cada PDB

prompt Conectandose a consultora_bdd de S1
connect consultora_bdd/consultora_bdd@calbd_s1
prompt creando los fragmentos para S1
@s-02-CAL-n1-ddl.sql
prompt LISTO

prompt Conectandose a consultora_bdd de S2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt creando los fragmentos para S2
@s-02-CAL-n2-ddl.sql
prompt LISTO

exit
