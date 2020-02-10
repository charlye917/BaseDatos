--@Autor:	Carlos Alberto Arteaga Lira
--@Fecha creacion:	05/05/2018
--@Consultas empleando transparencia de localizacion

prompt conectandose a calbd_s1
connect consultora_bdd/consultora_bdd@calbd_s1
prompt Realizando conteo de registros
set linesize 200
set serveroutput on
DECLARE
	v_num_paises_1 number;
	v_num_paises_2 number;
	v_num_oficina_1 number;
	v_num_oficina_2 number;
	v_num_proyecto_1 number;
	v_num_proyecto_2_1 number;
	v_num_proyecto_2_2 number;
	v_num_proyecto_pdf_1 number;
	v_num_proyecto_pdf_2 number;
	v_num_empleado_1 number;
	v_num_empleado_2 number;
	v_num_pago_empleado_1 number;
	v_num_pago_empleado_2 number;

begin
	dbms_output.put_line('Realizando consulta empleando ligas');

	--Consulta paises
	select count(*) as into v_num_paises_1
	from(
		select PAIS_ID
		from PAIS_1	
	) p1;

	select count(*) as into v_num_paises_2
	from(
		select PAIS_ID
		from PAIS_2	
	) p2;
	
	--Consulta oficina
	select count(*) as into v_num_oficina_1
	from(
		select OFICINA_ID
		from OFICINA_1
	) o1;

	select count(*) as into v_num_oficina_2
	from(
		select OFICINA_ID
		from OFICINA_2
	) o2;
	
	--consulta proyecto
	select count(*) as into v_num_proyecto_1
	from(
		select PROYECTO_ID
		from PROYECTO_1
	) pro1;

	select count(*) as into v_num_proyecto_2_1
	from(
		select PROYECTO_ID
		from PROYECTO_2_1
	) pro2_1;

	select count(*) as into v_num_proyecto_2_2
	from(
		select PROYECTO_ID
		from PROYECTO_2_2
	) pro2_2;

	--consulta proyecto_pdf
	select count(*) as into v_num_proyecto_pdf_1
	from(
		select NUM_PDF
		from PROYECTO_PDF_1
	) pdf1;
	
	select count(*) as into v_num_proyecto_pdf_2
	from(
		select NUM_PDF
		from PROYECTO_PDF_2
	) pdf2;

	--consulta empleado
	select count(*) as into v_num_empleado_1
	from(
		select EMPLEADO_ID
		from EMPLEADO_1
	) e1;

	select count(*) as into v_num_empleado_2
	from(
		select EMPLEADO_ID
		from EMPLEADO_2_1
	) e2;

	--consulta pago_empleado
	select count(*) as into v_num_pago_empleado_1
	from(
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO
	) pe1;

	select count(*) as into v_num_pago_empleado_2
	from(
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO_2
	) pe2;


	dbms_output.put_line('Resultado del conteo de registros');
	dbms_output.put_line('Pais_1:		'|| v_num_paises_1);
	dbms_output.put_line('Pais_2:		'|| v_num_paises_2);
	dbms_output.put_line('Oficina_1:	'|| v_num_oficina_1);
	dbms_output.put_line('Oficina_2:	'|| v_num_oficina_2);
	dbms_output.put_line('Proyecto_1:	'|| v_num_proyecto_1);
	dbms_output.put_line('Proyecto_2:	'|| v_num_proyecto_2_1);
	dbms_output.put_line('Proyecto_2:	'|| v_num_proyecto_2_2);
	dbms_output.put_line('Proyecto_PDF_1:	'|| v_num_proyecto_pdf_1);
	dbms_output.put_line('Proyecto_PDF_2:	'|| v_num_proyecto_pdf_2);
	dbms_output.put_line('Empleado_1:	'|| v_num_empleado_1);
	dbms_output.put_line('Empleado_2:	'|| v_num_empleado_2);
	dbms_output.put_line('Pago_empleado_1:	'|| v_num_pago_empleado_1);
	dbms_output.put_line('Pago_empleado_2:	'|| v_num_pago_empleado_2);
	
END;
/

prompt conectandose a calbd_s2
connect consultora_bdd/consultora_bdd@calbd_s2
prompt Realizando conteo e registros
prompt Realizando conteo de registros
set linesize 200
set serveroutput on
DECLARE
	v_num_paises_1 number;
	v_num_paises_2 number;
	v_num_oficina_1 number;
	v_num_oficina_2 number;
	v_num_proyecto_1 number;
	v_num_proyecto_2_1 number;
	v_num_proyecto_2_2 number;
	v_num_proyecto_pdf_1 number;
	v_num_proyecto_pdf_2 number;
	v_num_empleado_1 number;
	v_num_empleado_2 number;
	v_num_pago_empleado_1 number;
	v_num_pago_empleado_2 number;

begin
	dbms_output.put_line('Realizando consulta empleando ligas');

	--Consulta paises
	select count(*) as into v_num_paises_1
	from(
		select PAIS_ID
		from PAIS_1	
	) p1;

	select count(*) as into v_num_paises_2
	from(
		select PAIS_ID
		from PAIS_2	
	) p2;
	
	--Consulta oficina
	select count(*) as into v_num_oficina_1
	from(
		select OFICINA_ID
		from OFICINA_1
	) o1;

	select count(*) as into v_num_oficina_2
	from(
		select OFICINA_ID
		from OFICINA_2
	) o2;
	
	--consulta proyecto
	select count(*) as into v_num_proyecto_1
	from(
		select PROYECTO_ID
		from PROYECTO_1
	) pro1;

	select count(*) as into v_num_proyecto_2_1
	from(
		select PROYECTO_ID
		from PROYECTO_2_1
	) pro2_1;

	select count(*) as into v_num_proyecto_2_2
	from(
		select PROYECTO_ID
		from PROYECTO_2_2
	) pro2_2;

	--consulta proyecto_pdf
	select count(*) as into v_num_proyecto_pdf_1
	from(
		select NUM_PDF
		from PROYECTO_PDF_1
	) pdf1;
	
	select count(*) as into v_num_proyecto_pdf_2
	from(
		select NUM_PDF
		from PROYECTO_PDF_2
	) pdf2;

	--consulta empleado
	select count(*) as into v_num_empleado_1
	from(
		select EMPLEADO_ID
		from EMPLEADO_1
	) e1;

	select count(*) as into v_num_empleado_2
	from(
		select EMPLEADO_ID
		from EMPLEADO_2_1
	) e2;

	--consulta pago_empleado
	select count(*) as into v_num_pago_empleado_1
	from(
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO_1
	) pe1;

	select count(*) as into v_num_pago_empleado_2
	from(
		select PAGO_EMPLEADO_ID
		from PAGO_EMPLEADO_2
	) pe2;


	dbms_output.put_line('Resultado del conteo de registros');
	dbms_output.put_line('Pais_1:		'|| v_num_paises_1);
	dbms_output.put_line('Pais_2:		'|| v_num_paises_2);
	dbms_output.put_line('Oficina_1:	'|| v_num_oficina_1);
	dbms_output.put_line('Oficina_2:	'|| v_num_oficina_2);
	dbms_output.put_line('Proyecto_1:	'|| v_num_proyecto_1);
	dbms_output.put_line('Proyecto_2_1:	'|| v_num_proyecto_2_1);
	dbms_output.put_line('Proyecto_2_2:	'|| v_num_proyecto_2_2);
	dbms_output.put_line('Proyecto_PDF_1:	'|| v_num_proyecto_pdf_1);
	dbms_output.put_line('Proyecto_PDF_2:	'|| v_num_proyecto_pdf_2);
	dbms_output.put_line('Empleado_1:	'|| v_num_empleado_1);
	dbms_output.put_line('Empleado_2:	'|| v_num_empleado_2);
	dbms_output.put_line('Pago_empleado_1:	'|| v_num_pago_empleado_1);
	dbms_output.put_line('Pago_empleado_2:	'|| v_num_pago_empleado_2);
	
END;
/

prompt listo 
exit
