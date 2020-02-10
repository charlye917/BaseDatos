--@Autor: Arteaga Lira Carlos Alberto
--@Fecha creación: 09 de mayo del 2018
--@Descripción: Definición de vistas para manejo de BLOBs en la PDB calbd_s1 y calbd_s2 para PROYECTO_PDF

Prompt connectando a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt ---

Prompt Paso 1 creando objetos type para vistas que involucran BLOBs remotos
prompt ---
CREATE TYPE PDF_TYPE AS OBJECT(
	NUM_PDF NUMBER(1,0),
	PROYECTO_ID NUMERIC(10,0),
	ARCHIVO_PDF BLOB,
	TAMANIO NUMERIC(10,0)
);
/
show errors;
prompt ---

Prompt Paso 2 creando objetos table para vistas que involucran BLOBs remotos
prompt ---
CREATE TYPE PDF_TABLE AS TABLE OF PDF_TYPE;
/
show errors;
prompt ---

Prompt Paso 3 creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---
CREATE GLOBAL TEMPORARY TABLE T_PROYECTO_PDF_1(
	NUM_PDF NUMBER(1,0),
	PROYECTO_ID NUMERIC(10,0),
	ARCHIVO_PDF BLOB NOT NULL,
	TAMANIO NUMERIC(10,0),
	CONSTRAINT T_PROYECTO_PDF_1_PK PRIMARY KEY(NUM_PDF, PROYECTO_ID)
) ON COMMIT PRESERVE ROWS;
prompt ---

Prompt Paso 4 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---
CREATE OR REPLACE FUNCTION GET_REMOTE_PDF RETURN PDF_TABLE PIPELINED IS
	PRAGMA AUTONOMOUS_TRANSACTION;
	V_TEMP_PDF BLOB;
	BEGIN
		DELETE FROM T_PROYECTO_PDF_1;
		INSERT INTO T_PROYECTO_PDF_1 SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO 
			FROM PROYECTO_PDF_1;
		COMMIT;
		FOR CUR IN (SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO FROM T_PROYECTO_PDF_1)
		LOOP
			PIPE ROW(PDF_TYPE(CUR.NUM_PDF, CUR.PROYECTO_ID, CUR.ARCHIVO_PDF, CUR.TAMANIO));
		END LOOP;
		DELETE FROM T_PROYECTO_PDF_1;
		COMMIT;
		RETURN;
	END;
/
SHOW ERRORS;
prompt ---

Prompt Paso 5 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
prompt ---
CREATE OR REPLACE FUNCTION GET_REMOTE_PDF_BY_ID(V_NUM_PDF IN NUMBER, V_PROYECTO_ID IN NUMBER) RETURN BLOB IS
	PRAGMA AUTONOMOUS_TRANSACTION;
	V_TEMP_PDF BLOB;
	BEGIN
		DELETE FROM T_PROYECTO_PDF_1;
		INSERT INTO T_PROYECTO_PDF_1 SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO
		FROM PROYECTO_PDF_1 WHERE NUM_PDF = V_NUM_PDF AND PROYECTO_ID = V_PROYECTO_ID;
		SELECT ARCHIVO_PDF INTO V_TEMP_PDF FROM T_PROYECTO_PDF_1 WHERE NUM_PDF = V_NUM_PDF AND PROYECTO_ID = V_PROYECTO_ID;
		DELETE FROM T_PROYECTO_PDF_1;
		COMMIT;
		RETURN V_TEMP_PDF;
		EXCEPTION
		WHEN OTHERS THEN
			ROLLBACK;
			RAISE;
	END;
/
SHOW ERRORS;
prompt ---

Prompt Paso 6 Crear las vistas con datos BLOB remotos empleando estrategia 1
prompt ---
CREATE OR REPLACE VIEW V_PROYECTO_PDF AS
	SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO
	FROM PROYECTO_PDF_2
	UNION ALL
	SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO
	FROM TABLE (GET_REMOTE_PDF);
prompt ---

Prompt Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---
CREATE OR REPLACE VIEW V_PROYECTO_PDF_BY_ID AS
	SELECT NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO
	FROM PROYECTO_PDF_2
	UNION ALL
	SELECT NUM_PDF, PROYECTO_ID, GET_REMOTE_PDF_BY_ID(NUM_PDF, PROYECTO_ID), TAMANIO
	FROM PROYECTO_PDF_1;
prompt ---

Prompt Paso 8 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.
prompt ---
CREATE OR REPLACE SYNONYM PROYECTO_PDF_BY_ID FOR V_PROYECTO_PDF_BY_ID;
Prompt Listo!

