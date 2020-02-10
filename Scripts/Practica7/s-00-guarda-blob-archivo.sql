connect consultora_bdd/consultora_bdd@calbd_s2
create or replace procedure guarda_blob_en_archivo(
	p_nombre_dir        in varchar2, 
	p_nombre_arch_des in varchar2,
	p_nombre_tabla in varchar2,
	p_nombre_col_blob in  varchar2,
	p_nombre_pk1 in varchar2,
	p_valor_pk1 in varchar2,
	p_nombre_pk2 in varchar2,
	p_valor_pk2 in varchar2
) is

-- declaracion (bloques anonimos declare)
v_query 			varchar2(2000);
vv_nombre_col_blob 	varchar2(30);
vv_nombre_tabla 	varchar2(30);
vv_nombre_pk1 		varchar2(30);
vv_nombre_pk2 		varchar2(30);
v_dato_binario 		blob;

--

 v_file utl_file.FILE_TYPE;
 v_buffer_size number :=32767;--buffer escribo por bloques
 v_buffer RAW(32767);--almacenando el buffer
 v_blob_length number;
 v_position number;--recorriendo el arreglo de bytes

begin

	vv_nombre_col_blob := dbms_assert.simple_sql_name(p_nombre_col_blob);
	vv_nombre_tabla := dbms_assert.simple_sql_name(p_nombre_tabla);
	vv_nombre_pk1 := dbms_assert.simple_sql_name(p_nombre_pk1);
	

	v_query := ' select '
			||vv_nombre_col_blob 
			||' into :ph_blob '
			||' from '
			||vv_nombre_tabla
			||' where '
			||vv_nombre_pk1
			||' = :ph_valor_pk1';

	if p_nombre_pk2 is not null then 
		vv_nombre_pk2 := dbms_assert.simple_sql_name(p_nombre_pk2);

		v_query := v_query
					||' and '
					|| vv_nombre_pk2
					||'= :ph_valor_pk2';
	end if;

	--ejecucion dinamica de la consulta

	if p_nombre_pk2 is not null then

		execute immediate v_query into v_dato_binario using p_valor_pk1,p_valor_pk2;
	else
		execute immediate v_query into v_dato_binario using p_valor_pk1;
	end if;

 v_blob_length := dbms_lob.getlength(v_dato_binario);
 v_position := 1;
 v_file := utl_file.fopen(p_nombre_dir,p_nombre_arch_des,'wb',32767);

	while v_position < v_blob_length loop
 		dbms_lob.read(v_dato_binario,v_buffer_size,v_position,v_buffer);--leemos y cargamos a memoria
 		UTL_FILE.put_raw(v_file,v_buffer,TRUE);--escribe al disco
 		v_position := v_position+v_buffer_size;
		end loop;
		utl_file.fclose(v_file);
 -- cierra el archivo en caso de error y relanza la excepción.
 exception when others then
 --cerrar v_file en caso de error.
	 if utl_file.is_open(v_file) then
 	utl_file.fclose(v_file);
	end if;
 raise;
end;
/
show errors;
