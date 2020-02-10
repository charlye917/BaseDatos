--@Elaborado por: Arteaga Lira Carlos Alberto
--@Fecha elbaoracion: 01/04/2018
--@Descripcion: Carga inicial de datos

prompt Conectando a S1 - calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1

--si ocurre un error, la ejecucion se detiene
whenever sqlerror exit rollback;

prompt limpiando.
delete from PAGO_EMPLEADO;
delete from PROYECTO_PDF;
delete from PROYECTO;
delete from EMPLEADO;
delete from OFICINA;
delete from PAIS;

prompt Cargando datos
insert into PAIS(PAIS_ID, CLAVE, NOMBRE, REGION)
values (1,'MX','MEXICO','A');

insert into OFICINA(OFICINA_ID, NOMBRE, PAIS_ID)
values (1,'OFICINA 1 DE CDMX', 1);

insert into EMPLEADO(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
values (1, 'JUAN', 'LOPEZ', 'LARA', 'LOLA890802KML', 'juanq@m.com',NULL);
insert into EMPLEADO(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
values (2, 'CARLOS', 'BAEZ', 'AGUIRRE', 'BAAGCA982613', 'carlos@m.com',1);
insert into EMPLEADO(EMPLEADO_ID, NOMBRE, AP_PATERNO, AP_MATERNO, RFC, EMAIL, JEFE_ID)
values (3, 'MIGUEL', 'JIMIENEZ', 'ORTIZ', 'BJIORMI090721', 'cmike@m.com',1);

insert into PROYECTO(PROYECTO_ID, NOMBRE, CLAVE, FECHA_INICIO, FECHA_FIN, RESPONSABLE_ID, OFICINA_ID)
values (1, 'PROYECTO A', 'P00A', TO_DATE('16/02/2009', 'DD/MM/YYYY'), TO_DATE('31/12/2012', 'DD/MM/YYYY'), 1, 1);

insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (1, 1, EMPTY_BLOB(), 2);

insert into PAGO_EMPLEADO(PAGO_EMPLEADO_ID, IMPORTE, FECHA_PAGO, PROYECTO_ID, EMPLEADO_ID)
values (1, 1500.45, TO_DATE('01/02/2017', 'DD/MM/YYYY'), 1, 1);
insert into PAGO_EMPLEADO(PAGO_EMPLEADO_ID, IMPORTE, FECHA_PAGO, PROYECTO_ID, EMPLEADO_ID)
values (2, 5490.45, TO_DATE('01/08/2017', 'DD/MM/YYYY'), 3, 2);
insert into PAGO_EMPLEADO(PAGO_EMPLEADO_ID, IMPORTE, FECHA_PAGO, PROYECTO_ID, EMPLEADO_ID)
values (3, 760.67, TO_DATE('31/12/2016', 'DD/MM/YYYY'), 2, 3);

commit;


Prompt Conectando a S1 - calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2

--si ocurre un error, la ejecucion se detiene
whenever sqlerror exit rollback;

prompt limpiando.
delete from PAGO_EMPLEADO;
delete from PROYECTO_PDF;
delete from PROYECTO2;
delete from PROYECTO1;
delete from EMPLEADO2;
delete from EMPLEADO;
delete from OFICINA;
delete from PAIS;

prompt Cargando datos
insert into PAIS(PAIS_ID, CLAVE, NOMBRE, REGION)
values (2,'JAP','JAPON','B');

insert into OFICINA(OFICINA_ID, NOMBRE, PAIS_ID)
values (2,'OFICINA 1 DE TOKIO', 2);

insert into EMPLEADO2(EMPLEADO_ID, FOTO, NUM_CUENTA)
values (1, Empty_blob(), 09934902);
insert into EMPLEADO2(EMPLEADO_ID, FOTO, NUM_CUENTA)
values (2, Empty_blob(), 04449321);
insert into EMPLEADO2(EMPLEADO_ID, FOTO, NUM_CUENTA)
values (3, Empty_blob(), 67382342);

insert into PROYECTO2(PROYECTO_ID, NOMBRE, CLAVE, FECHA_INICIO, FECHA_FIN, RESPONSABLE_ID, OFICINA_ID)
values (2, 'PROYECTO B', 'P00B',TO_DATE('14/01/2011', 'DD/MM/YYYY'), TO_DATE('31/12/2013', 'DD/MM/YYYY'), 2, 2);
insert into PROYECTO2(PROYECTO_ID, NOMBRE, CLAVE, FECHA_INICIO, FECHA_FIN, RESPONSABLE_ID, OFICINA_ID)
values (3, 'PROYECTO C', 'P00C', TO_DATE('06/05/2008', 'DD/MM/YYYY'), NULL, 3, 2);

insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (1, 2, EMPTY_BLOB(), 4);

commit;
Prompt Listo
exit

