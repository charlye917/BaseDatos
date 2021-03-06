--@Autor: Arteaga Lira Carlos Alberto
--@Fecha creación: 08 de mayo del 2018
--@Descripción: Definición de vistas para manejo de BLOBs en la PDB calbd_s2 y calbd_s1

Prompt connectando a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt ---
Prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---
CREATE OR REPLACE VIEW V_EMPLEADO AS 
	SELECT E1.EMPLEADO_ID, E1.NOMBRE, E1.AP_PATERNO, E1.AP_MATERNO, E1.RFC, E1.EMAIL, E1.JEFE_ID, E2.FOTO, E2.NUM_CUENTA
	FROM(
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_1
		UNION
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_2_1
		) E1
		JOIN (SELECT EMPLEADO_ID, FOTO, NUM_CUENTA FROM EMPLEADO_2_2) E2
		ON E1.EMPLEADO_ID = E2.EMPLEADO_ID;
prompt ---

Prompt Paso 2 creando objetos type para vistas que involucran BLOBs remotos
prompt ---
prompt conectando a calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
CREATE TYPE FOTO_TYPE AS OBJECT(
	EMPLEADO_ID NUMBER(10,0),
	FOTO BLOB,
	NUM_CUENTA VARCHAR(18)
);
/
show errors;
prompt ---

Prompt Paso 3 creando objetos table para vistas que involucran BLOBs remotos
prompt ---
CREATE TYPE FOTO_TABLE AS TABLE OF FOTO_TYPE;
/
show errors;
prompt ---

Prompt Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---
CREATE GLOBAL TEMPORARY TABLE T_CAL_EMPLEADO_2_2(
	EMPLEADO_ID NUMBER(10,0) CONSTRAINT T_CAL_EMPLEADO_2_2_PK PRIMARY KEY,
	FOTO BLOB NOT NULL,
	NUM_CUENTA VARCHAR(18) NOT NULL
) ON COMMIT PRESERVE rows;
prompt ---

Prompt Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---
CREATE OR REPLACE FUNCTION GET_REMOTE_FOTO RETURN FOTO_TABLE PIPELINED IS
PRAGMA AUTONOMOUS_TRANSACTION;
	V_TEMP_FOTO BLOB;
	BEGIN
		DELETE FROM T_CAL_EMPLEADO_2_2;
		INSERT INTO T_CAL_EMPLEADO_2_2 SELECT EMPLEADO_ID, FOTO, NUM_CUENTA
			FROM EMPLEADO_2_2;
		COMMIT;
		FOR CUR IN (SELECT EMPLEADO_ID, FOTO, NUM_CUENTA FROM T_CAL_EMPLEADO_2_2)
		LOOP
			PIPE ROW(FOTO_TYPE(CUR.EMPLEADO_ID, CUR.FOTO, CUR.NUM_CUENTA));
		END LOOP;
		DELETE FROM T_CAL_EMPLEADO_2_2;
		COMMIT;
		RETURN;
	END;
/
show errors;
prompt ---

Prompt Paso 6 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
prompt ---
CREATE OR REPLACE FUNCTION GET_REMOTE_FOTO_BY_ID(V_EMPLEADO_ID IN NUMBER) RETURN BLOB IS
PRAGMA AUTONOMOUS_TRANSACTION;
V_TEMP_FOTO BLOB;
BEGIN
	DELETE FROM T_CAL_EMPLEADO_2_2;
	INSERT INTO T_CAL_EMPLEADO_2_2 SELECT EMPLEADO_ID, FOTO, NUM_CUENTA
		FROM EMPLEADO_2_2 WHERE EMPLEADO_ID = V_EMPLEADO_ID;
	SELECT FOTO INTO V_TEMP_FOTO FROM T_CAL_EMPLEADO_2_2 WHERE EMPLEADO_ID = V_EMPLEADO_ID;
	DELETE FROM T_CAL_EMPLEADO_2_2;
	COMMIT;
	RETURN V_TEMP_FOTO;
	EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE;
	end;
/
show errors;
prompt ---

Prompt Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 1
prompt ---
CREATE OR REPLACE VIEW V_EMPLEADO AS
	SELECT E1.EMPLEADO_ID, E1.NOMBRE, E1.AP_PATERNO, E1.AP_MATERNO, E1.RFC, E1.EMAIL, E1.JEFE_ID, E2.FOTO, E2.NUM_CUENTA
	FROM(
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_1
		UNION
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_2_1
	) E1
	JOIN(
		SELECT * FROM TABLE(GET_REMOTE_FOTO)
	) E2 ON E1.EMPLEADO_ID = E2.EMPLEADO_ID;
prompt ---

Prompt Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---
CREATE OR REPLACE VIEW V_EMPLEADO_BY_ID AS
	SELECT E1.EMPLEADO_ID, E1.NOMBRE, E1.AP_PATERNO, E1.AP_MATERNO, E1.RFC, E1.EMAIL, E1.JEFE_ID, GET_REMOTE_FOTO_BY_ID(EMPLEADO_ID) AS FOTO
	FROM(
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_1
		UNION
		SELECT EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID FROM EMPLEADO_2_1
	) E1;
prompt ---

Prompt Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.
prompt ---
CREATE OR REPLACE SYNONYM EMPLEADO_BY_ID FOR V_EMPLEADO_BY_ID;

Prompt Listo!
exit
