prompt conectando a calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1

prompt proyecto_pdf estategia 1
select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from V_PROYECTO_PDF
order by proyecto_id;

prompt proyecto_pdf estategia 2
select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from V_PROYECTO_PDF_BY_ID
order by proyecto_id;

prompt conectando a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2

prompt proyecto_pdf estategia 1
select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from V_PROYECTO_PDF
order by proyecto_id;

prompt proyecto_pdf estategia 2
select proyecto_id,num_pdf,dbms_lob.getlength(archivo_pdf) as longitud
from V_PROYECTO_PDF_BY_ID
order by proyecto_id;

