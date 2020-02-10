--@Elaborado por: Arteaga Lira Carlos Alberto
--@Fecha creación: 24/04/18
--@Descripción: Este script realiza una prueba para validar el manejo de BLOBs en un solo PDB.

--creando un objeto DIRECTORY para acceder al directorio /tmp/bdd
Prompt conectando a calbd_s2 como SYS
Prompt Proporcione el password de SYS

connect sys/system@calbd_s1 as sysdba
create or replace directory tmp_dir as '/tmp/bdd';
grant read,write on directory tmp_dir to consultora_bdd;

prompt conectando a calbd_s1 con usuario consultora_bdd
connect consultora_bdd/consultora_bdd@calbd_s1

--ejecutando el procedimiento
exec carga_blob_en_bd('TMP_DIR','prueba.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'PROYECTO_ID', '1', 'NUM_PDF', '1');
prompt mostrando el tamaño del PDF en BD.

select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from PROYECTO_PDF
where proyecto_id = 1
and num_pdf = 1;

Prompt salvando PDF en directorio
exec guarda_blob_en_archivo('TMP_DIR', 'pruebaoutput.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'PROYECTO_ID', '1', 'NUM_PDF', '1');

prompt mostrantdo el contenido del directoriopara validar la existencia del pdf
Prompt Observar que ambos archivos tienen el mismo tamaño.
!ls -l /tmp/bdd/*.pdf

Prompt Listo!
exit
