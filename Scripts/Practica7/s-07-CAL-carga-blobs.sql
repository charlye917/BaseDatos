--@Elaborado por: Arteaga Lira Carlos Alberto
--@Fecha creación: 24/04/18
--@Descripción: Este script realiza una prueba para validar el manejo de BLOBs en un solo PDB.

--creando un objeto DIRECTORY para acceder al directorio /tmp/bdd
prompt conectando a calbd_s1 con usuario consultora_bdd
connect consultora_bdd/consultora_bdd@calbd_s1


select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from PROYECTO_PDF;

Prompt salvando PDF en directorio
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-1_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '3', 'PROYECTO_ID', '4');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-2_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '5', 'PROYECTO_ID', '6');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-3_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '7', 'PROYECTO_ID', '8');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-4_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '9', 'PROYECTO_ID', '10');
exec guarda_blob_en_archivo('TMP_DIR', 'prueba3_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '7', 'PROYECTO_ID', '12');

prompt mostrantdo el contenido del directoriopara validar la existencia del pdf
Prompt Observar que ambos archivos tienen el mismo tamaño.
!ls -l /tmp/bdd/*.pdf
Prompt Listo!


prompt conectando a calbd_s2 con usuario consultora_bdd
connect consultora_bdd/consultora_bdd@calbd_s2


select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from PROYECTO_PDF;

Prompt salvando PDF en directorio
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-6_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '4', 'PROYECTO_ID', '3');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-7_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '6', 'PROYECTO_ID', '5');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-9_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '8', 'PROYECTO_ID', '7');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-10_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '4', 'PROYECTO_ID', '9');
exec guarda_blob_en_archivo('TMP_DIR', 'practica7-5_out.pdf', 'PROYECTO_PDF', 'ARCHIVO_PDF', 'NUM_PDF', '6', 'PROYECTO_ID', '11');

prompt mostrantdo el contenido del directoriopara validar la existencia del pdf

Prompt Observar que ambos archivos tienen el mismo tamaño.
!ls -l /tmp/bdd/*.pdf

exit
