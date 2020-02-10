clear screen
--Habilitar esta instruccion si se desea salir de sqlplus al obtener un error
whenever sqlerror exit rollback;

--copia un PDF de muestra (modificar segun corresponda)
!rm -rf  /tmp/bdd/sample.pdf
!mkdir -p /tmp/bdd
!cp  sample.pdf /tmp/bdd/
!chmod 755 /tmp/bdd/sample.pdf

--Cambiar la ruta segun corresponda (ruta donde esta el script para cargar Blobs)
define blob_script = 's-00-carga-blob-en-bd.sql';

--Usuarios
connect sys/system@jrcbd_s1 as sysdba
drop user ejemplo_revistas cascade;
create user ejemplo_revistas identified by ejemplo_revistas quota unlimited on users; 
grant create session, create view, create procedure, create trigger to ejemplo_revistas;
grant create synonym, create type, create table,create database link to ejemplo_revistas;
grant read on directory tmp_dir to ejemplo_revistas;
--modificar el directorio segun corresponda
create or replace directory tmp_dir as '/tmp/bdd'; 

connect sys/system@jrcbd_s2 as sysdba
drop user ejemplo_revistas cascade;
create user ejemplo_revistas identified by ejemplo_revistas quota unlimited on users; 
grant create session, create view, create procedure, create trigger to ejemplo_revistas;
grant create synonym, create type, create table,create database link to ejemplo_revistas;
grant read on directory tmp_dir to ejemplo_revistas;
--modificar el directorio segun corresponda  
create or replace directory tmp_dir as '/tmp/bdd'; 


connect ejemplo_revistas/ejemplo_revistas@jrcbd_s1
Prompt creando ligas y procedimiento para cargar BLOBs en S1
create database link jrcbd_s2.fi.unam using 'JRCBD_S2';
--crea procedimiento para cargar BLOBs (modificar la ruta segun corresponda)
@ &blob_script;
Prompt creando fragmentos en S1
create table f_jrc_revista_1(
	revista_id number(10,0) constraint revista_pk1 primary key,
	tipo  char(1) not null,
	nombre varchar2(40) not null,
  pdf blob not null
);

connect ejemplo_revistas/ejemplo_revistas@jrcbd_s2
Prompt creando ligas y procedimiento para cargar BLOBs en S2
create database link jrcbd_s1.fi.unam using 'JRCBD_S1';
--crea procedimiento para cargar BLOBs (modificar la ruta segun corresponda)
@ &blob_script;

Prompt creando fragmentos en S2
create table f_jrc_revista_2(
	revista_id number(10,0) constraint revista_pk2 primary key,
	tipo  char(1) not null,
	nombre varchar2(40) not null,
  pdf blob not null
);

Prompt creando sinonimos para  S1
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s1
create or replace synonym revista_1 for f_jrc_revista_1;
create or replace synonym revista_2 for f_jrc_revista_2@jrcbd_s2;

Prompt creando sinonimos para  S2
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s2
create or replace synonym revista_1 for f_jrc_revista_1@jrcbd_s1;
create or replace synonym revista_2 for f_jrc_revista_2;
  
--
-- En S1 se necesita manejo especial de BLOBs, inicia la creación de objetos
--
Prompt creando objetos para manejo de blob en s1 
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s1

create type revista_type as object (
	revista_id number(10,0),
  tipo  char(1),
  nombre varchar2(40),
  pdf blob
);
/
show errors;

create or replace type revista_table as table of revista_type;
/
show errors;

--tabla temporal para manejar blobs - transparencia para select
create global temporary table t_revista_2(
	revista_id number(10,0) constraint t_revista_2_pk  primary key,
  tipo  char(1) not null,
  nombre varchar2(40) not null,
	pdf blob not null
) on commit preserve rows;

-- función que implementa la estrategia 1
create or replace function get_remote_pdf return revista_table pipelined is
	pragma autonomous_transaction;
	v_temp_pdf blob;
	begin
    	--asegura que no haya registros
    	delete from t_revista_2;
    	--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    	insert into t_revista_2 select revista_id,tipo,nombre,pdf from revista_2;
    	commit;
    	--obtiene los registros de la tabla temporal y los regresa como objetos tipo revista_type
    	for cur in (select revista_id,tipo,nombre,pdf from t_revista_2) 
    	loop
    		pipe row(revista_type(cur.revista_id,cur.tipo,cur.nombre,cur.pdf));
    	end loop;
    	--elimina los registros de la tabla temporal una vez que han sido obtenidos.
    	delete from t_revista_2;
    	commit;
   		return;
  end;
  /
show errors;

--funcion que implementa la estrategia 2
create or replace function get_remote_pdf_by_id(v_revista_id in number ) return blob is
	pragma autonomous_transaction;
	v_temp_pdf blob;
	begin
    	--asegura que no haya registros
    	delete from t_revista_2;
    	--inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    	insert into t_revista_2 select revista_id,tipo,nombre,pdf 
    		from revista_2 where revista_id = v_revista_id;
    	--obtiene el registro de la tabla temporal y lo regresa como blob
    	select pdf into v_temp_pdf from t_revista_2 where revista_id = v_revista_id;
    	--elimina los registros de la tabla temporal una vez que han sido obtenidos.
    	delete from t_revista_2;
    	commit;
   		return v_temp_pdf;
   	exception
   		when others then
   			rollback;
   			raise;
  end;
  /
show errors;

--creando la vista en s1 con la estrategia 1
Prompt creando vistas en S1 para acceso remoto de blobs
create or replace view revista_e1 as
  select revista_id,tipo,nombre,pdf
  from revista_1
  union all
  select revista_id,tipo,nombre,pdf from table (get_remote_pdf);

--creando la vista en s1 con la estrategia 2
create or replace view revista_e2 as
    select revista_id,tipo,nombre,pdf
    from revista_1
    union all
    select revista_id,tipo,nombre,get_remote_pdf_by_id(revista_id)
    from revista_2;

--
-- En S2 se necesita manejo especial de BLOBs similar a S1 ya que
-- en ambos sitios se encuentran las columnas BLOB. Inicia la creación de objetos
--
Prompt creando objetos para manejo de blob en s2
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s2

create type revista_type as object (
  revista_id number(10,0),
  tipo  char(1),
  nombre varchar2(40),
  pdf blob
);
/
show errors;


create or replace type revista_table as table of revista_type;
/
show errors;

--tabla temporal para manejar blobs - transparencia para select
create global temporary table t_revista_1(
  revista_id number(10,0) constraint t_revista_1_pk  primary key,
  tipo  char(1) not null,
  nombre varchar2(40) not null,
  pdf blob not null
) on commit preserve rows;

-- función que implementa la estrategia 1
create or replace function get_remote_pdf return revista_table pipelined is
  pragma autonomous_transaction;
  v_temp_pdf blob;
  begin
      --asegura que no haya registros
      delete from t_revista_1;
      --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
      insert into t_revista_1 select revista_id,tipo,nombre,pdf from revista_1;
      commit;
      --obtiene los registros de la tabla temporal y los regresa como objetos tipo revista_type
      for cur in (select revista_id,tipo,nombre,pdf from t_revista_1) 
      loop
        pipe row(revista_type(cur.revista_id,cur.tipo,cur.nombre,cur.pdf));
      end loop;
      --elimina los registros de la tabla temporal una vez que han sido obtenidos.
      delete from t_revista_1;
      commit;
      return;
  end;
  /
  show errors;


--funcion que implementa la estrategia 2
create or replace function get_remote_pdf_by_id(v_revista_id in number ) return blob is
  pragma autonomous_transaction;
  v_temp_pdf blob;
  begin
      --dbms_output.put_line('invocando fx '||v_revista_id);
      --asegura que no haya registros
      delete from t_revista_1;
      --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
      insert into t_revista_1 select revista_id,tipo,nombre,pdf 
        from revista_1 where revista_id = v_revista_id;
      --obtiene el registro de la tabla temporal y lo regresa como blob
      select pdf into v_temp_pdf from t_revista_1 where revista_id = v_revista_id;
      --elimina los registros de la tabla temporal una vez que han sido obtenidos.
      delete from t_revista_1;
      commit;
      return v_temp_pdf;
    exception
      when others then
        rollback;
        raise;
  end;
  /
show errors;

--creando la vista en s1 con la estrategia 1
Prompt creando vistas en s2 para acceso remoto de blobs
create or replace view revista_e1 as
  select revista_id,tipo,nombre,pdf
  from revista_2
  union all
  select revista_id,tipo,nombre,pdf from table (get_remote_pdf);

--creando la vista en s1 con la estrategia 2
create or replace view revista_e2 as
    select revista_id,tipo,nombre,pdf
    from revista_2
    union all
    select revista_id,tipo,nombre,get_remote_pdf_by_id(revista_id)
    from revista_1;

----
----Realiza carga de datos para probar
----
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s1
prompt  poblando revista en jrcbd_s1
insert into revista_1(revista_id,tipo,nombre,pdf) values(1,'A','Revista 1',empty_blob());
insert into revista_1(revista_id,tipo,nombre,pdf) values(2,'A','Revista 2',empty_blob());
insert into revista_1(revista_id,tipo,nombre,pdf) values(3,'A','Revista 3',empty_blob());
insert into revista_1(revista_id,tipo,nombre,pdf) values(4,'A','Revista 4',empty_blob());
insert into revista_1(revista_id,tipo,nombre,pdf) values(5,'A','Revista 5',empty_blob());
Prompt cargando BLOBs
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_1','pdf','revista_id','1',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_1','pdf','revista_id','2',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_1','pdf','revista_id','3',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_1','pdf','revista_id','4',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_1','pdf','revista_id','5',null,null);

commit;

connect ejemplo_revistas/ejemplo_revistas@jrcbd_s2
prompt  poblando revista en jrcbd_s2
insert into revista_2(revista_id,tipo,nombre,pdf) values(6,'B','Revista 6',empty_blob());
insert into revista_2(revista_id,tipo,nombre,pdf) values(7,'B','Revista 7',empty_blob());
insert into revista_2(revista_id,tipo,nombre,pdf) values(8,'B','Revista 8',empty_blob());
insert into revista_2(revista_id,tipo,nombre,pdf) values(9,'B','Revista 9',empty_blob());
insert into revista_2(revista_id,tipo,nombre,pdf) values(10,'B','Revista 10',empty_blob());
Prompt cargando BLOBs
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_2','pdf','revista_id','6',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_2','pdf','revista_id','7',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_2','pdf','revista_id','8',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_2','pdf','revista_id','9',null,null);
exec carga_blob_en_bd('TMP_DIR','sample.pdf','f_jrc_revista_2','pdf','revista_id','10',null,null);
commit;

Prompt verificando resultados:
connect ejemplo_revistas/ejemplo_revistas@jrcbd_s1;
-- Aqui se distuingue entre las 2 vistas para poder probar ambas estrategias: revista_e1 y revista_e2
Prompt probando  con estrategia 1 en sitio 1
select revista_id,tipo,nombre,dbms_lob.getlength(pdf) as longitud from revista_e1;
Prompt Probando con estrategia 2 en sitio 1
select revista_id,tipo,nombre,dbms_lob.getlength(pdf) as longitud from revista_e2;

connect ejemplo_revistas/ejemplo_revistas@jrcbd_s2;
Prompt probando  con estrategia 1 en sitio 2
select revista_id,tipo,nombre,dbms_lob.getlength(pdf) as longitud from revista_e1;
Prompt Probando con estrategia 2 en sitio 2
select revista_id,tipo,nombre,dbms_lob.getlength(pdf) as longitud from revista_e2;

Prompt Listo!
exit
