--@Autor:Arteaga Lira Carlos Alberto
--@Fecha creación: 05/05/2018
--@Descripción:Script de ejecución para crear de vistas en ambas PDBs

Prompt conectandose a calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
Prompt creando vistas en calbd_s1
@s-04-CAAL-def-vistas.sql

Prompt conectandose a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
Prompt creando vistas en calbd_s2
@s-04-CAAL-def-vistas.sql

Prompt Listo
exit
