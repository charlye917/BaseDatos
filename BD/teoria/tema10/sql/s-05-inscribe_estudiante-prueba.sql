set serveroutput on
declare
    v_curso_id number;
    v_resultado number;
begin

--parametros del procedimiento:
--  p_estudiante_id, p_semestre_id, p_asignatura_id,
--  p_grupo, p_curso_id, p_resultado

dbms_output.put_line(' inscribiendo al estudiante 1, asignatura 5');

p_inscribe_estudiante(1,1,5,'001',v_curso_id,v_resultado);
--inscribe_estudiante(1,1,1,'001',v_curso_id,v_resultado);

--hacer update
--update curso set cupo_maximo=0 where curso_id=11;
--inscribe_estudiante(3,1,5,'001',v_curso_id,v_resultado);


dbms_output.put_line('Resultado: '||v_resultado||', curso_id: '||v_curso_id);

end;
/

select ei.*,c.asignatura_id,c.clave_grupo 
from estudiante_inscrito ei,curso c
where ei.curso_id = c.curso_id 
and c.curso_id = 11
order by ei.estudiante_id,ei.curso_id;

