--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:   Script de pruebas empleado para validar transparencia
--                de distribución empleando operaciones DML.

set serveroutput on
set linesize 200

Prompt 1. Limpieza de datos.
begin
	delete from pago_empleado_1;
	delete from pago_empleado_2;
	delete from proyecto_pdf_1;
	delete from proyecto_pdf_2;
	delete from proyecto_1;
	delete from proyecto_2;
	delete from proyecto_3;	
	delete from empleado_1;
	delete from empleado_2;
	delete from empleado_3;
	delete from oficina_1;
    delete from oficina_2;
	delete from pais_1;
	delete from pais_2;
	--confirma transacción distribuida
	commit;
exception
	when others then
	dbms_output.put_line('error al insertar paises, se hara rollback');
	--rollback distribuido.
	rollback;
	raise;
end;
/

Prompt 2. Operaciones INSERT

begin
	--pais
	insert into pais(pais_id,clave,nombre,region) values (1,'MX','MEXICO','A');
	insert into pais(pais_id,clave,nombre,region) values (2,'JAP','JAPON','B');
	--oficina
	insert into oficina(oficina_id,nombre,pais_id) values(1,'OFICINA 1 DE CDMX',1);
	insert into oficina(oficina_id,nombre,pais_id) values(2,'OFICINA 1 DE TOKIO',2);

	--empleado
	insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,rfc,email,jefe_id,num_cuenta,foto) 
		values (1,'JUAN','LOPEZ','LARA','LOLA890802KML','JUAN@MAIL.COM',null,'09934902',
			load_blob_from_file('TMP_DIR','sample1.jpg'));
	insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,rfc,email,jefe_id,num_cuenta,foto) 
		values (2,'CARLOS','BAEZ','AGUIRRE','BAAGCA982613','CARLOS@MAIL.COM',1,'04449321',
			load_blob_from_file('TMP_DIR','sample2.jpg'));
	insert into empleado(empleado_id,nombre,ap_paterno,ap_materno,rfc,email,jefe_id,num_cuenta,foto) 
		values (3,'EVA','ZAVALA','CORTES','ZACOEV040423','EVA@MAIL.COM',1,'67382342',
			load_blob_from_file('TMP_DIR','sample3.jpg'));
	commit;
exception
	when others then
	dbms_output.put_line('error al realizar inserciones, se hara rollback');
	rollback;
	raise;
end;
/

Prompt 3. Resultados - INSERT
set linesize 300
select  
	(select count(*) from pais_1 ) as pais_1,
	(select count(*) from pais_2) as pais_2,
	(select count(*) from oficina_1) as oficina_1,
	(select count(*) from oficina_2) as oficina_2,
	(select count(*) from empleado_1) as emp_1,
	(select count(*) from empleado_2) as emp_2,
	(select count(*) from empleado_3) as emp_3
from  dual;

Prompt 4. Operaciones UPDATE

declare
	v_count_1 number;
	v_count_2 number;
	v_count_3 number;
begin
	--Datos antes de cambios
	dbms_output.put_line('A. Datos antes de Update - Mismo sitio ');
	for cur in (select nombre,ap_paterno,ap_materno,email,jefe_id,num_cuenta,foto
		from empleado) loop
		
		dbms_output.put_line(
			'=> '
			||cur.nombre
			||' '
			||cur.ap_materno
			||' '
			||cur.email
			||' '
			||cur.jefe_id
			||' '
			||cur.num_cuenta
			||' blob:'
			||dbms_lob.getlength(cur.foto)
		);
	end loop;

	
	update empleado  
	set nombre = lower(nombre), ap_paterno = lower(ap_paterno),
		ap_materno = lower(ap_materno),
		email = lower(email), jefe_id = 2, num_cuenta ='99'||num_cuenta,
		foto = load_blob_from_file('TMP_DIR','sample4.jpg');
	
	commit;

	--Datos despues de cambios
	dbms_output.put_line('B. Datos despues de Update - Mismo sitio ');
	for cur in (select nombre,ap_paterno,ap_materno,email,jefe_id,num_cuenta,foto
		from empleado) loop
		
		dbms_output.put_line(
			'=> '
			||cur.nombre
			||' '
			||cur.ap_materno
			||' '
			||cur.email
			||' '
			||cur.jefe_id
			||' '
			||cur.num_cuenta
			||' blob:'
			||dbms_lob.getlength(cur.foto)
		);
	end loop;

	-- Pruebas para cambio de sitio
	select count(*) into v_count_1 from empleado_1;
	select count(*) into v_count_2 from empleado_2;
	select count(*) into v_count_3 from empleado_3;
	dbms_output.put_line('C. Sin cambio de sitio - Prueba 1:'||v_count_1||','||v_count_2||','||v_count_3);

	update empleado set rfc = 'ZZ'||substr(rfc,3,length(rfc));
	select count(*) into v_count_1 from empleado_1;
	select count(*) into v_count_2 from empleado_2;
	select count(*) into v_count_3 from empleado_3;
	dbms_output.put_line('D. Cambio de sitio  -    prueba 2:'||v_count_1||','||v_count_2||','||v_count_3);

	update empleado set rfc = 'AA'||substr(rfc,3,length(rfc));
	select count(*) into v_count_1 from empleado_1;
	select count(*) into v_count_2 from empleado_2;
	select count(*) into v_count_3 from empleado_3;
	dbms_output.put_line('E. Cambio de sitio  -    prueba 3:'||v_count_1||','||v_count_2||','||v_count_3);

	commit;


exception
	when others then
	dbms_output.put_line('error al mover registros, se hara rollback');
	rollback;
	raise;
end;
/

Prompt 5. Operaciones DELETE

declare
	v_count number;
begin
	delete  from empleado;
	delete  from oficina;
	delete from pais;
	commit;
exception
	when others then
	dbms_output.put_line('error al eliminar revistas, se hara rollback');
	rollback;
	raise;
end;
/

Prompt resultados - delete
set linesize 300
select  
	(select count(*) from pais_1 ) as pais_1,
	(select count(*) from pais_2 ) as pais_2,
	(select count(*) from oficina_1) as oficina_1,
	(select count(*) from oficina_2) as oficina_2,
	(select count(*) from empleado_1) as emp_1,
	(select count(*) from empleado_2) as emp_2,
	(select count(*) from empleado_3) as emp_3
from  dual;