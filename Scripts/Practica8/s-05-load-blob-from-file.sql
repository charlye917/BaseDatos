create or replace function load_blob_from_file(
	v_directory_name in varchar2,
	v_src_file_name in varchar2 ) return blob is--se regresa un dato BLOB
	
	--variables
	v_src_blob bfile:=bfilename(v_directory_name,v_src_file_name);
	v_dest_blob blob := empty_blob();
	v_src_offset number := 1;
	v_dest_offset number :=1;
	v_src_blob_size number;
	
	begin
	--abre el archivo
	if dbms_lob.fileexists(v_src_blob)=1 and not dbms_lob.isopen(v_src_blob)=1 then
	v_src_blob_size := dbms_lob.getlength(v_src_blob);
	dbms_lob.open(v_src_blob,dbms_lob.LOB_READONLY);
	else
	raise_application_error(-20001, v_src_file_name
		||' El archivo no existe o esta abierto');
	end if;

	--crea un objeto lob temporal
	dbms_lob.createtemporary(
		lob_loc => v_dest_blob
		, cache => true
		, dur => dbms_lob.call
	);
	--lee el archivo y escribe en la variable v_dest_blob
	dbms_lob.loadblobfromfile(
		dest_lob => v_dest_blob,
		src_bfile => v_src_blob,
		amount => dbms_lob.getlength(v_src_blob),
		dest_offset => v_dest_offset,
		src_offset => v_src_offset
	);

	--cerrando blob
	dbms_lob.close(v_src_blob);
	if v_src_blob_size = dbms_lob.getlength(v_dest_blob) then
		dbms_output.put_line('done '|| v_src_blob_size || ' bytes read.' );
	else
		raise_application_error(-20104,'Invalid blob size. Expected: '
		||v_src_blob_size||', actual: '|| dbms_lob.getlength(v_dest_blob));
	end if;
	return v_dest_blob;
end;
/
