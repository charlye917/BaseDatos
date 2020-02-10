prompt conectando con sys
connect sys/system@calbd_s1 as sysdba
create or replace directory TMP_DIR as '/tmp/bdd';
grant read on directory tmp_dir to consultora_bdd;
grant write on directory tmp_dir to consultora_bdd;

prompt conectando con s1
connect consultora_bdd/consultora_bdd@calbd_s1
exec guarda_blob_en_archivo('TMP_DIR', 'prueba_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '1','PROYECTO_ID', '1');
prompt Listo

connect sys/system@calbd_s2 as sysdba
create or replace directory TMP_DIR as '/tmp/bdd';
grant read on directory tmp_dir to consultora_bdd;
grant write on directory tmp_dir to consultora_bdd;

prompt conectando con s2 
connect consultora_bdd/consultora_bdd@calbd_s2
exec guarda_blob_en_archivo('TMP_DIR', 'prueba2_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '1','PROYECTO_ID', '2');

exit
