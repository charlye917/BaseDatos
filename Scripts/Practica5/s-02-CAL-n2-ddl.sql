--@Autor: Carlos Alberto Arteaga Lira
--@Fecha creacion: 29/03/2018
--@Descripcion: Creacion de fragmentos PDB2

CREATE TABLE PAIS(
PAIS_ID NUMBER(5,0) CONSTRAINT PAIS_PK PRIMARY KEY,
CLAVE VARCHAR(5) NOT NULL,
NOMBRE VARCHAR(40) NOT NULL,
REGION CHAR(1) NOT NULL CONSTRAINT REGION_CHECK CHECK (REGION IN ('B'))
);

CREATE TABLE OFICINA(
OFICINA_ID NUMBER(5,0) CONSTRAINT OFICINA_PK PRIMARY KEY,
NOMBRE VARCHAR(40) NOT NULL,
PAIS_ID NUMBER(5,0) NOT NULL CONSTRAINT PAIS_OFICINA_PAIS_ID_FK REFERENCES PAIS(PAIS_ID)
);

CREATE TABLE PROYECTO1(
PROYECTO_ID NUMBER(10,0) CONSTRAINT PROYECTO1_PK PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL,
CLAVE VARCHAR(5)  NOT NULL,
FECHA_INICIO DATE NOT NULL CONSTRAINT FECHA_INICIO1_CHECK CHECK(TO_CHAR(FECHA_INICIO,'YYYY')<=2010),
FECHA_FIN DATE NOT NULL,
RESPONSABLE_ID NUMBER(10,0) NOT NULL,
OFICINA_ID NUMBER(5,0) NOT NULL CONSTRAINT OFI_PROy1_OFICINA_ID_FK REFERENCES OFICINA(OFICINA_ID)
);

CREATE TABLE PROYECTO2(
PROYECTO_ID NUMBER(10,0) CONSTRAINT PROYECTO2_PK PRIMARY KEY,
NOMBRE VARCHAR(100) NOT NULL,
CLAVE VARCHAR(5)  NOT NULL,
FECHA_INICIO DATE NOT NULL),
FECHA_FIN DATE NULL,
RESPONSABLE_ID NUMBER(10,0) NOT NULL,
OFICINA_ID NUMBER(5,0) NOT NULL CONSTRAINT OFI_PROy2_OFICINA_ID_FK REFERENCES OFICINA(OFICINA_ID)
);

CREATE TABLE PROYECTO_PDF(
NUM_PDF NUMBER(1,0) CONSTRAINT PROYECTO_PDF_PK PRIMARY KEY,
PROYECTO_ID NUMERIC(10,0) NOT NULL,
ARCHIVO_PDF BLOB NOT NULL,
TAMANIO NUMERIC(10,0) CONSTRAINT TAMANIO_CHECK CHECK(TAMANIO>3)
);

CREATE TABLE EMPLEADO(
EMPLEADO_ID NUMBER(10,0) CONSTRAINT EMPLEADO_PK PRIMARY KEY,
NOMBRE VARCHAR(40) NOT NULL,
AP_PATERNO VARCHAR(40) NOT NULL,
AP_MATERNO VARCHAR(40) NULL,
RFC VARCHAR(13) NOT NULL CONSTRAINT RFC_CHECK CHECK(SUBSTR(RFC,1,1) BETWEEN 'N' AND 'Z'),
EMAIL VARCHAR(40) NOT NULL,
JEFE_ID NUMERIC(10,0) NULL
);

CREATE TABLE EMPLEADO2(
EMPLEADO_ID NUMBER(10,0) CONSTRAINT EMPLEADO2_PK PRIMARY KEY,
FOTO BLOB NOT NULL,
NUM_CUENTA VARCHAR(18) NOT NULL
);

CREATE TABLE PAGO_EMPLEADO(
PAGO_EMPLEADO_ID NUMBER(10,0) CONSTRAINT PAGO_EMPLEADO_PK PRIMARY KEY,
IMPORTE NUMBER(10,2) NOT NULL,
FECHA_PAGO DATE NOT NULL,
PROYECTO_ID NUMERIC(10,0) NOT NULL,
EMPLEADO_ID NUMERIC(10,0) NOT NULL CONSTRAINT EMPLEADO_PAGO_EMPLEADO_ID_FK REFERENCES EMPLEADO(EMPLEADO_ID)
);

