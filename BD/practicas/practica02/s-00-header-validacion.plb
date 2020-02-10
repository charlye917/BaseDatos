
Prompt =============================================
Prompt Iniciando proceso de validación de respuestas
Prompt Incluir en el reporte a partir de este punto
Prompt =============================================

set serveroutput on
set linesize 200
col host format A30
col os_user format A15
col db_user format A15
col usr_cod_hsh format A7
col con_name format A10
select to_char(sysdate,'dd/mm/yyyy HH24:mi:ss') session_time,
	fv_hash as usr_cod_hsh, 
	sys_context('USERENV','HOST') host,
	sys_context('USERENV','OS_USER') os_user,
	username db_user,
	nvl(sys_context('USERENV','CON_NAME'),'N/A') con_name
from user_users;