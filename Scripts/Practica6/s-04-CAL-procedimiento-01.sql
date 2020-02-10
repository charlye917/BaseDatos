--Elabora por Arteaga lira carlos alberto
--fecha: 21/04/2018
--script para insertar pdf
connect sys/system@calbd_s1 as sysdba
create or replace directory tmp_dir as '/tmp/bdd';
grant read on directory tmp_dir to consultora_bdd;

Prompt conectandose a consultora_bdd de s1
connect consultora_bdd/consultora_bdd@calbd_s1

exec carga_blob_en_bd('TMP_DIR', 'prueba.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '1', 'PROYECTO_ID', '1');
prompt Listo


connect sys/system@calbd_s2 as sysdba
create or replace directory tmp_dir as '/tmp/bdd';
grant read on directory tmp_dir to consultora_bdd;
Prompt conectandose a consultora_bdd de s2
connect consultora_bdd/consultora_bdd@calbd_s2

exec carga_blob_en_bd('TMP_DIR', 'prueba2.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '1', 'PROYECTO_ID', '2');
prompt Listo



exit


exit

