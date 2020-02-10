--@Autor(es):       Jorge Rodríguez
--@Fecha creación:  
--@Descripción:     Script de prueba para validar el trigger tr_valida_extraordinarios
set serveroutput on
prompt insertando examenes para en usuario 22

declare
	v_codigo number;
	v_mensaje varchar2(1000);
begin

	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,3,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,4,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,5,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,6,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,7,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,8,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,9,5,15);
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,10,5,15);
	--este examen ya no se debería insertar.
	insert into estudiante_extraordinario(estudiante_id,num_examen,calificacion,asignatura_id)
		values(22,11,5,15);
exception
	when others then
	dbms_output.put_line('Manejando excepcion');
    v_codigo := sqlcode;
    v_mensaje := sqlerrm;
    dbms_output.put_line('Codigo:  ' || v_codigo);
    dbms_output.put_line('Mensaje: ' || v_mensaje);
end;
/

Prompt mostrando los examenes del estudiante 22
select estudiante_id,num_examen,calificacion,asignatura_id
from estudiante_extraordinario
where estudiante_id = 22
order by 2;

Prompt intentando modificar una calificacion
update estudiante_extraordinario
set calificacion = 10
where estudiante_id = 22
and num_examen = 10;

Prompt mostrando los datos de autitoria
set linesize 500
col usuario format a20
select *  from
auditoria_extraordinario
where estudiante_id = 22;

Prompt intentando eliminar un extraordinario 
delete from estudiante_extraordinario
where estudiante_id = 22
and num_examen = 10;