--@Autor(es):       Jorge Rodríguez
--@Fecha creación:  
--@Descripción:    Bloque PL/SQL anonimo empleado para verificar el 
--                 procedimiento p_reporte_inscritos

set serveroutput on
col nombre_asignatura format a30
col antecedente format a20
declare
    v_semestre_id number(2,0) := 1;
    v_num_registros number(5,0);
begin
    p_reporte_inscritos(v_semestre_id,v_num_registros);
    dbms_output.put_line('Numero de registros: '||v_num_registros);
end;
/