--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:  Pruebas Operaciones DML

-----Configuracion de variables, modificar segun corresponda
set verify off
define  pdb_1 = 'calbd_s1'
define  pdb_2 = 'calbd_s2'
define  usuario = 'consultora_bdd'

--evitar estas 2 lineas en sistemas reales.
define  sys_pwd='system'
define  usuario_pwd = 'consultora_bdd'

------------------------------------
-- Paso 1. copiando fotos 
------------------------------------

connect sys/system as sysdba;

-- Se asume que la carpeta fotos se encuentra en el mismo directorio donde se
-- ejecuta este script. La carpeta fotos se copia a /tmp/bdd y despues se le cambian permisos
-- de lectura y ejecución para todos los usuarios.
-- En SQL *Plus se emplea el símbolo '!' para ejecutar comandos en el sistema operativo.
!rm -rf /tmp/bdd
!mkdir -p /tmp/bdd
!chmod 777 /tmp/bdd
!cp fotos/sample*.jpg  /tmp/bdd
!chmod 755 /tmp/bdd/sample*.jpg

------------------------------------
-- Paso 2. Creando objeto tipo directory en pdb 1 
------------------------------------

connect sys/&sys_pwd@&pdb_1 as sysdba
create or replace directory tmp_dir as '/tmp/bdd';
grant read,write on directory tmp_dir to &usuario;	


------------------------------------
-- Paso 2.1 Creando objeto tipo directory en pdb 2 
------------------------------------

connect sys/&sys_pwd@&pdb_2 as sysdba
create or replace directory tmp_dir as '/tmp/bdd';
grant read,write on directory tmp_dir to &usuario;	


Prompt  =================================================================
Prompt             Iniciando ejecucion de pruebas en  &pdb_1
Prompt  =================================================================
connect &usuario/&usuario_pwd@&pdb_1

@s-06-operaciones-dml.sql


Prompt  ================================================================
Prompt              Iniciando ejecucion de pruebas en  &pdb_2
Prompt  ================================================================
connect &usuario/&usuario_pwd@&pdb_2

@s-06-operaciones-dml.sql

Prompt Listo!
exit
