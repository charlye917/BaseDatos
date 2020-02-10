--@Autor: Carlos Alberto Arteaga Lira
--@Fecha creacion: 30/03/2018
--@Descripcion: Consulta de resgricciones creados en cal-pc

Prompt Conectando a S1 - calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
@s-05-consulta-restricciones.sql

Prompt Conectando a S1 - calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
@s-05-consulta-restricciones.sql
Prompt Listo
exit
