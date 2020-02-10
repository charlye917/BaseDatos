--Creado por: Arteaga Lira Carlos Alberto
--Fecha: 11 de mayo del 2018
--conteo de registros
prompt conectando a calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
prompt Realizando conteo de registros

set linesize 200
SELECT
	(SELECT COUNT(*) FROM V_PAIS) AS PAIS,
	(SELECT COUNT(*) FROM V_OFICINA) AS OFICINA, 
	(SELECT COUNT(*) FROM V_EMPLEADO) AS EMPLEADO, 
	(SELECT COUNT(*) FROM V_PROYECTO) AS PROYECTO, 
	(SELECT COUNT(*) FROM  PROYECTO_PDF_BY_ID) AS PROYECTO_PDF,
	(SELECT COUNT(*) FROM V_PAGO_EMPLEADO) AS PAGO_EMPLEADO 
from dual;

prompt conectando a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt Realizando conteo de registros

set linesize 200
SELECT
	(SELECT COUNT(*) FROM V_PAIS) AS PAIS,
	(SELECT COUNT(*) FROM V_OFICINA) AS OFICINA, 
	(SELECT COUNT(*) FROM V_EMPLEADO) AS EMPLEADO, 
	(SELECT COUNT(*) FROM V_PROYECTO) AS PROYECTO, 
	(SELECT COUNT(*) FROM  PROYECTO_PDF_BY_ID) AS PROYECTO_PDF,
	(SELECT COUNT(*) FROM V_PAGO_EMPLEADO) AS PAGO_EMPLEADO 
from dual;

prompt LISTO
exit

