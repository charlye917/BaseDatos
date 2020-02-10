prompt conectando a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt Realizando conteo de registros

set serveroutput on
DECLARE
	v_num_paises number;
	v_num_oficina number;
	v_num_proyecto number;
	v_num_proyecto_pdf number;
	v_num_empleado number;
	v_num_pago_empleado number;

begin
	dbms_output.put_line('Realizando consulta empleando ligas');

	--Consulta paises
	select count(*) as into v_num_paises
	from(
		select PAIS_ID
		from PAIS
		union all
		select PAIS_ID
		from PAIS@calbd_s1.fi.unam	
	) p2;
	
	--Consulta oficina
	select count(*) as into v_num_oficina
	from(
		select OFICINA_ID
		from OFICINA
		union all
		select OFICINA_ID
		from OFICINA@calbd_s1.fi.unam
	) o2;
	
	--consulta proyecto
	select count(*) as into v_num_proyecto
	from(
		select PROYECTO_ID
		from PROYECTO1
		union all
		select PROYECTO_ID
		from PROYECTO2
		union all
		select PROYECTO_ID
		from PROYECTO@calbd_s1.fi.unam
	) pro2;

	--consulta proyecto_pdf
	select count(*) as into v_num_proyecto_pdf
	from(
		select NUM_PDF
		from PROYECTO_PDF
		union all
		select NUM_PDF
		from PROYECTO_PDF@calbd_s1.fi.unam
	) pdf2;

	--consulta empleado
	select count(*) as into v_num_empleado
	from(
		select EMPLEADO_ID
		from EMPLEADO
		union all
		select EMPLEADO_ID
		from EMPLEADO@calbd_s1.fi.unam
	) e2;

	--consulta pago_empleado
	select count(*) as into v_num_pago_empleado
	from(
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO
		union all 
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO@calbd_s1.fi.unam
	) pe2;

	dbms_output.put_line('Resultado del conteo de registros');
	dbms_output.put_line('Pais:		'|| v_num_paises);
	dbms_output.put_line('Oficina:	'|| v_num_oficina);
	dbms_output.put_line('Proyecto:	'|| v_num_proyecto);
	dbms_output.put_line('Proyecto_PDF:	'|| v_num_proyecto_pdf);
	dbms_output.put_line('Empleado:	'|| v_num_empleado);
	dbms_output.put_line('Pago_empleado:	'|| v_num_pago_empleado);
	
END;
/
Prompt Listo
exit
