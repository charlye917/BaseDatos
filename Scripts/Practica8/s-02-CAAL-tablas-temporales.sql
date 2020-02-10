--@Autor: Arteaga Lira Carlos Alberto
--@Fecha creación: 19 de mayo del 2018
--@Descripción: Definición de tablas temporales empleadas por el trigger

prompt conectando pdb1
connect consultora_bdd/consultora_bdd@calbd_s1
prompt creando tabla temporal t_empleado_insert
prompt------
CREATE GLOBAL TEMPORARY TABLE T_EMPLEADO_INSERT(
	EMPLEADO_ID NUMBER(10,0) CONSTRAINT T_EMPLEADO_INSERT_PK PRIMARY KEY,
	FOTO BLOB NOT NULL,
	NUM_CUENTA VARCHAR(18) NOT NULL
) ON COMMIT PRESERVE ROWS;
prompt----
prompt creando tabla temporal t_empleado_update
prompt----
CREATE GLOBAL TEMPORARY TABLE T_EMPLEADO_UPDATE(
	EMPLEADO_ID NUMBER(10,0) CONSTRAINT T_EMPLEADO_DELETE_PK PRIMARY KEY,
	FOTO BLOB NOT NULL,
	NUM_CUENTA VARCHAR(18) NOT NULL
) ON COMMIT PRESERVE ROWS;
prompt----
PROMPT LISTO
exit
