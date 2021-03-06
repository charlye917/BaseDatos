--Elaborado por: Arteaga Lira Carlos Alberto
--Fecha: 19 de mayo del 2018
--Definicion del trigger Instead of para la vista oficina
prompt creando triggers para oficina
CREATE OR REPLACE TRIGGER TGR_DML_OFICINA
INSTEAD OF INSERT OR UPDATE OR DELETE ON V_OFICINA
DECLARE
	V_COUNT NUMBER;
	V_OFICINA_ID NUMBER(5,0);
	V_NOMBRE VARCHAR(40);
	V_PAIS_ID NUMBER(5,0);
	
BEGIN
	V_OFICINA_ID := :NEW.OFICINA_ID;
	V_NOMBRE := :NEW.NOMBRE;
	V_PAIS_ID := :NEW.PAIS_ID;
	CASE
		WHEN INSERTING THEN	
			--VERIFICA SI HAY CORRESPONDENCIA LOCAL PARA EVITAR ACCESO REMOTO
			SELECT COUNT(*) INTO V_COUNT
			FROM PAIS_2
			WHERE PAIS_ID = V_PAIS_ID;
			--INSERCION LOCAL
			IF V_COUNT > 0 THEN
				INSERT INTO OFICINA_2(OFICINA_ID, NOMBRE, PAIS_ID)
				VALUES(V_OFICINA_ID, V_NOMBRE, V_PAIS_ID);
			--INSERCION REMOTA
			ELSE
				SELECT COUNT(*) INTO V_COUNT
				FROM PAIS_1
				WHERE PAIS_ID = V_PAIS_ID;
				IF V_COUNT > 0 THEN
					INSERT INTO OFICINA_1(OFICINA_ID, NOMBRE, PAIS_ID)
					VALUES(V_OFICINA_ID, V_NOMBRE, V_PAIS_ID);
				ELSE
					RAISE_APPLICATION_ERROR(-20001,
						'ERROR DE INTEGRIDAD PARA EL CAMPO PAIS_ID: '
						|| V_PAIS_ID
						|| ' NO SE ENCONTRO EL REGISTRO PADRE EN FRAGMENTOS');
				END IF;
			END IF;
		WHEN DELETING THEN	
			--VERIFICA SI HAY CORRESPONDENCIA LOCAL PARA EVITAR ACCESO REMOTO
			SELECT COUNT(*) INTO V_COUNT
			FROM PAIS_2
			WHERE PAIS_ID = :OLD.PAIS_ID;
			--DELETE LOCAL
			IF V_COUNT > 0 THEN
				DELETE FROM OFICINA_2 WHERE OFICINA_ID = :OLD.OFICINA_ID;
			--DELETE REMOTA
			ELSE
				SELECT COUNT(*) INTO V_COUNT
				FROM PAIS_1
				WHERE PAIS_ID = :OLD.PAIS_ID;
				IF V_COUNT > 0 THEN
					DELETE FROM OFICINA_1 WHERE OFICINA_ID = :OLD.OFICINA_ID;
				ELSE
					RAISE_APPLICATION_ERROR(-20001,
						'ERROR DE INTEGRIDAD PARA EL CAMPO OFICINA_ID: '
						|| V_PAIS_ID
						|| ' NO SE ENCONTRO EL REGISTRO PADRE EN FRAGMENTOS');
				END IF;
			END IF;
		WHEN UPDATING THEN
			--VERIFICA SI HAY CORRESPONDENCIA LOCAL PARA EVITAR ACCESO REMOTO
			SELECT COUNT(*) INTO V_COUNT
			FROM PAIS_2
			WHERE PAIS_ID = :OLD.PAIS_ID;
			--ACTUALIZACION LOCAL
			IF V_COUNT > 0 THEN
				UPDATE OFICINA_2 SET PAIS_ID = V_PAIS_ID,
				OFICINA_ID = V_OFICINA_ID, NOMBRE = V_NOMBRE
				WHERE OFICINA_ID = :OLD.OFICINA_ID;
			--ACTUALIZACION REMOTA
			ELSE
				SELECT COUNT(*) INTO V_COUNT
				FROM PAIS_1
				WHERE PAIS_ID = :OLD.PAIS_ID;
				IF V_COUNT > 0 THEN
					UPDATE OFICINA_1 SET PAIS_ID = V_PAIS_ID,
					OFICINA_ID = V_OFICINA_ID, NOMBRE = V_NOMBRE
					WHERE OFICINA_ID = :OLD.OFICINA_ID;
				ELSE
					RAISE_APPLICATION_ERROR(-20001,
						'ERROR DE INTEGRIDAD PARA EL CAMPO PAIS_ID: '
						|| V_PAIS_ID
						|| ' NO SE ENCONTRO EL REGISTRO PADRE EN FRAGMENTOS');
				END IF;
			END IF;
	END CASE;
END;
/
PROMPT LISTO


		

		
