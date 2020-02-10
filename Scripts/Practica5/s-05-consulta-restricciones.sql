--@Autor: Carlos Alberto Arteaga Lira
--@Fecha creacion: 31/03/2018
--@Descripcion: Consulta de restricciones de referencia
prompt mostrando lista de restricciones de referencia
col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A30
set linesize 200
SELECT c.table_name "tabla_padre", u.table_name "tabla_hija", u.constraint_name "nombre_restriccion"
FROM user_constraints u
JOIN all_constraints c ON  u.r_constraint_name = c.constraint_name
WHERE u.constraint_type = 'R'
ORDER BY c.table_name;





