--Elaborado por: Arteaga Lira Carlos Alberto
--Fecha: 19 de mayo del 2018
--Definicion del trigger Instead of para la vista empleado
prompt creando trigger para la vista empleado
create or replace trigger TGR_DML_EMPLEADO
instead of insert or update or delete on V_EMPLEADO
declare
	V_EMPLEADO_ID NUMBER(10,0);
	V_NOMBRE VARCHAR(40);
	V_AP_PATERNO VARCHAR(40);
	V_AP_MATERNO VARCHAR(40);
	V_RFC VARCHAR(13);
	V_EMAIL VARCHAR(40);
	V_JEFE_ID NUMERIC(10,0);
	V_FOTO BLOB;
	V_NUM_CUENTA VARCHAR(18);
begin
	V_EMPLEADO_ID := :NEW.EMPLEADO_ID;
	V_NOMBRE := :NEW.NOMBRE;
	V_AP_PATERNO := :NEW.AP_PATERNO;
	V_AP_MATERNO := :NEW.AP_MATERNO;
	V_RFC := :NEW.RFC;
	V_EMAIL := :NEW.EMAIL;
	V_JEFE_ID := :NEW.JEFE_ID;
	V_FOTO := :NEW.FOTO;
	V_NUM_CUENTA := :NEW.NUM_CUENTA;
	case
		when INSERTING then
			IF SUBSTR(V_RFC,1,1) BETWEEN 'N' AND 'Z' THEN
				INSERT INTO EMPLEADO_2_1(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
				VALUES (V_EMPLEADO_ID, V_NOMBRE, V_AP_PATERNO, V_AP_MATERNO, V_RFC, V_EMAIL, V_JEFE_ID);
			ELSIF SUBSTR(V_RFC,1,1) BETWEEN 'A' AND 'M' THEN
				INSERT INTO EMPLEADO_1(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
				VALUES (V_EMPLEADO_ID, V_NOMBRE, V_AP_PATERNO, V_AP_MATERNO, V_RFC, V_EMAIL, V_JEFE_ID);
			ELSE
				raise_application_error(20001,
					'Valor incorrecto para el campo RFC : '
					|| V_RFC);
			END IF;
			INSERT INTO EMPLEADO_2_2(EMPLEADO_ID, FOTO, NUM_CUENTA)
			VALUES(V_EMPLEADO_ID, V_FOTO, V_NUM_CUENTA);

		WHEN DELETING THEN
			IF SUBSTR(V_RFC,1,1) BETWEEN 'N' AND 'Z' THEN
				DELETE FROM EMPLEADO_2_1 WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
			ELSIF SUBSTR(V_RFC,1,1) BETWEEN 'A' AND 'M' THEN
				DELETE FROM EMPLEADO_1 WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
			ELSE
				raise_application_error(-20001,
					'Valor incorrecto para el campo tipo : '
					|| :OLD.RFC);
			end if;
			--ELIMINANDO EL BINARIO
			DELETE FROM EMPLEADO_2_2 WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;

		WHEN UPDATING THEN
			--EL REGISTRO SE QUEDA EN EL SITIO 2
			IF (SUBSTR(V_RFC,1,1) BETWEEN 'N' AND 'Z') AND (SUBSTR(:OLD.RFC,1,1) BETWEEN 'N' AND 'Z') THEN
				UPDATE EMPLEADO_2_1 SET EMPLEADO_ID = V_EMPLEADO_ID, NOMBRE = V_NOMBRE, 
				AP_PATERNO = V_AP_PATERNO, AP_MATERNO = V_AP_MATERNO, RFC = V_RFC, 
				EMAIL = V_EMAIL, JEFE_ID = V_JEFE_ID
				WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
			--EL REGISTRO CAMBIA DE SITIO 2 A 1
			ELSIF (SUBSTR(V_RFC,1,1) BETWEEN 'N' AND 'Z') AND (SUBSTR(:OLD.RFC,1,1) BETWEEN 'A' AND 'M') THEN
				DELETE EMPLEADO_2_1 WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
				INSERT INTO EMPLEADO_1(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
				VALUES (V_EMPLEADO_ID, V_NOMBRE, V_AP_PATERNO, V_AP_MATERNO, V_RFC, V_EMAIL, V_JEFE_ID);
			--EL REGISTRO SE QUEDA EN EL SITIO 1
			ELSIF (SUBSTR(V_RFC,1,1) BETWEEN 'A' AND 'M') AND (SUBSTR(:OLD.RFC,1,1) BETWEEN 'A' AND 'M') THEN
				UPDATE EMPLEADO_1 SET EMPLEADO_ID = V_EMPLEADO_ID,
				NOMBRE = V_NOMBRE, AP_PATERNO = V_AP_PATERNO, 
				AP_MATERNO = V_AP_MATERNO, RFC = V_RFC, EMAIL = V_EMAIL, 
				JEFE_ID = V_JEFE_ID
				WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
			--EL REGISTRO CAMBIA DE SITIO 1 A 2
			ELSIF (SUBSTR(V_RFC,1,1) BETWEEN 'A' AND 'M') AND (SUBSTR(:OLD.RFC,1,1) BETWEEN 'N' AND 'Z') THEN
				DELETE EMPLEADO_1 WHERE EMPLEADO_ID = :OLD.EMPLEADO_ID;
				INSERT INTO EMPLEADO_2_1(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
				VALUES (V_EMPLEADO_ID, V_NOMBRE, V_AP_PATERNO, V_AP_MATERNO, V_RFC, V_EMAIL, V_JEFE_ID);			
			--VALORES INVALIDOS
			ELSE
				raise_application_error(-20001,
					'Valor incorrecto para el campo tipo : '
					|| :OLD.RFC);
			end if;
			--ACTUALIZA EL BINARIO EMPLEANDO TABLA TEMPORAL PARA UPDATE
			update EMPLEADO_2_2 set EMPLEADO_ID = V_EMPLEADO_ID,
			FOTO = V_FOTO where EMPLEADO_ID = :OLD.EMPLEADO_ID;
		end case;
	end;
/