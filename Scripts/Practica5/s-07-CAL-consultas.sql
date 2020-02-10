--@Elaborado por: Arteaga Lira Carlos Alberto
--@Fecha creacion: 03/03/2018
--@Descripcion: Consulta conteo de registros

prompt Conectando a sitio s1
connect consultora_bdd/consultora_bdd@calbd_s1
prompt Realizando conteo de registros

set linesize 200
select 
	(select count(*) from PAIS) as PAIS_1, 
	(select count(*) from OFICINA) as OFICINA_1,
	(select count(*) from EMPLEADO) as EMPLEADO_1,
	(select count(*) from PROYECTO) as PROYECTO_1,
	(select count(*) from PROYECTO_PDF) as PROYECTO_PDF_1,
	(select count(*) from PAGO_EMPLEADO) as PAGO_EMPLEADO_1
from dual;

prompt LISTO


prompt Conectando a sitio s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt Realizando conteo de registros

set linesize 200
select 
	(select count(*) from PAIS) as PAIS_2,
	(select count(*) from OFICINA) as OFICINA_2,
	(select count(*) from EMPLEADO) as EMPLEADO_2,
	(select count(*) from EMPLEADO2) as EMPLEADO_3,
	(select count(*) from PROYECTO1) as PROYECTO_2,
	(select count(*) from PROYECTO2) as PROYECTO_3,
	(select count(*) from PROYECTO_PDF) as PROYECTO_PDF_2,
	(select count(*) from PAGO_EMPLEADO) as PAGO_EMPLEADO_2
from dual;

prompt LISTO
exit
