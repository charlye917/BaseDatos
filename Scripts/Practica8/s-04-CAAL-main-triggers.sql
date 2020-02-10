--@Autor: Arteaga Lira Carlos Alberto
--@Fecha creacion: 20 de mayo del 2018
--@Descripcion: Creacion de triggers

prompt creando triggers en S1
connect consultora_bdd/consultora_bdd@calbd_s1
Prompt creando trigger para pais
@s-03-CAAL-pais-trigger.sql
show errors
Prompt creando trigger para oficina
@s-03-CAAL-oficina-n1-trigger.sql
show errors
Prompt creando trigger para empleado
@s-03-CAAL-n1-empleado-trigger.sql
show errors

Prompt creando triggers en S2
connect consultora_bdd/consultora_bdd@calbd_s2
Prompt creando trigger para pais
@s-03-CAAL-pais-trigger.sql
show errors
Prompt creando trigger para oficina
@s-03-CAAL-oficina-n2-trigger.sql
show errors
Prompt creando trigger para empleado
@s-03-CAAL-n2-empleado-trigger.sql
show errors
Prompt Listo!
exit
