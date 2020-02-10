connect consultora_bdd/consultora_bdd@calbd_s1
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (3, 4, EMPTY_BLOB(), 2);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (5, 6, EMPTY_BLOB(), 3);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (7, 8, EMPTY_BLOB(), 1);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (9, 10, EMPTY_BLOB(), 3);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (7, 12, EMPTY_BLOB(), 1);
exec carga_blob_en_bd('TMP_DIR', 'practica7-1.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '3', 'PROYECTO_ID', '4');
exec carga_blob_en_bd('TMP_DIR', 'practica7-2.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '5', 'PROYECTO_ID', '6');
exec carga_blob_en_bd('TMP_DIR', 'practica7-3.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '7', 'PROYECTO_ID', '8');
exec carga_blob_en_bd('TMP_DIR', 'practica7-4.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '9', 'PROYECTO_ID', '10');
exec carga_blob_en_bd('TMP_DIR', 'prueba3.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '7', 'PROYECTO_ID', '12');

connect consultora_bdd/consultora_bdd@calbd_s2
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (4, 3, EMPTY_BLOB(), 6);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (6, 5, EMPTY_BLOB(), 5);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (8, 7, EMPTY_BLOB(), 4);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (4, 9, EMPTY_BLOB(), 9);
insert into PROYECTO_PDF(NUM_PDF, PROYECTO_ID, ARCHIVO_PDF, TAMANIO)
values (6, 11, EMPTY_BLOB(), 5);
exec carga_blob_en_bd('TMP_DIR', 'practica7-6.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '4', 'PROYECTO_ID', '3');
exec carga_blob_en_bd('TMP_DIR', 'practica7-7.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '6', 'PROYECTO_ID', '5');
exec carga_blob_en_bd('TMP_DIR', 'practica7-9.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '8', 'PROYECTO_ID', '7');
exec carga_blob_en_bd('TMP_DIR', 'practica7-10.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '4', 'PROYECTO_ID', '9');
exec carga_blob_en_bd('TMP_DIR', 'practica7-5.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '6', 'PROYECTO_ID', '11');
