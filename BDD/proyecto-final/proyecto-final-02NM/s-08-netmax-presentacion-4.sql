--@Autor:          Jorge A. Rodríguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Archivo de carga inicial.

Prompt ======================================
Prompt validando transparencia de insercion
Prompt ======================================

Prompt seleciconar la PDB para validar
connect netmax_bdd/netmax_bdd@&pdb

whenever sqlerror exit rollback;

set serveroutput on

create or replace procedure p_valida_insercion(
	v_expected in number, v_actual in number, v_tabla in varchar2
) is
begin
	if v_actual <> v_expected then
		raise_application_error(-20004,'Se encontraron '
			||v_actual
			||' Registros en '
			||v_tabla
			||', se esperaban '
			||v_expected);
	else
		dbms_output.put_line('obtenidos:'
			||chr(9)
			||v_actual
			||chr(9)
			||'esperados:'
			||chr(9)
			||v_expected
			||chr(9)
			||'tabla: '
			||v_tabla);
	end if;
end;
/
show errors

--valida que al menos un registro tenga datos.
create or replace procedure p_valida_insercion_blob(
	v_count in number, v_tabla in varchar2
) is
begin
	if v_count = 0  then
		raise_application_error(-20004,'Se encontraron '
			||' 0 Registros en '
			||v_tabla
			||', se esperaba al menos 1 ');
	else
		dbms_output.put_line('obtenidos:'
			||chr(9)
			||v_count
			||chr(9)
			||'esperados:'
			||chr(9)
			||'> 0'
			||chr(9)
			||'tabla: '
			||v_tabla);
	end if;
end;
/
show errors

Prompt Validando inserciones ...

declare
	v_count number(10,0);
	
begin
	
	--verifica usuario
	select count(*) into v_count from usuario_f1;
	p_valida_insercion(263,v_count,'usuario_f1');

	select count(*) into v_count from usuario_f2;
	p_valida_insercion(258,v_count,'usuario_f2');
	
	select count(*) into v_count from usuario_f3;
	p_valida_insercion(300,v_count,'usuario_f3');
	
	select count(*) into v_count from usuario_f4;
	p_valida_insercion(179,v_count,'usuario_f4');
	
	select count(*) into v_count from usuario_f5;
	p_valida_insercion(1000,v_count,'usuario_f5');
	
	select count(*) into v_count from usuario;
	p_valida_insercion(1000,v_count,'usuario');

	--verifica programa
	select count(*) into v_count from programa_f1;
	p_valida_insercion(1514,v_count,'programa_f1');

	select count(*) into v_count from programa_f2;
	p_valida_insercion(870,v_count,'programa_f2');

	select count(*) into v_count from programa_f3;
	p_valida_insercion(616,v_count,'programa_f3');

	select count(*) into v_count from programa;
	p_valida_insercion(3000,v_count,'programa');

	--verifica documental
	select count(*) into v_count from documental_f1;
	p_valida_insercion(529,v_count,'documental_f1');
	
	select count(*) into v_count from documental_f2;
	p_valida_insercion(266,v_count,'documental_f2');
	
	select count(*) into v_count from documental_f3;
	p_valida_insercion(205,v_count,'documental_f3');
	
	select count(*) into v_count from documental;
	p_valida_insercion(1000,v_count,'documental');

		--verifica pelicula
	select count(*) into v_count from pelicula_f1;
	p_valida_insercion(499,v_count,'pelicula_f1');

	select count(*) into v_count from pelicula_f2;
	p_valida_insercion(293,v_count,'pelicula_f2');

	select count(*) into v_count from pelicula_f3;
	p_valida_insercion(208,v_count,'pelicula_f3');

	select count(*) into v_count from pelicula;
	p_valida_insercion(1000,v_count,'pelicula');

	--verifica serie
	select count(*) into v_count from serie_f1;
	p_valida_insercion(486,v_count,'serie_f1');

	select count(*) into v_count from serie_f2;
	p_valida_insercion(311,v_count,'serie_f2');
	
	select count(*) into v_count from serie_f3;
	p_valida_insercion(203,v_count,'serie_f3');
	
	select count(*) into v_count from serie;
	p_valida_insercion(1000,v_count,'serie');

	--verifica historico
	select count(*) into v_count from historico_status_programa_f1;
	p_valida_insercion(1000,v_count,'historico_status_programa_f1');
	
	select count(*) into v_count from historico_status_programa;
	p_valida_insercion(1000,v_count,'historico_status_programa');
	--verifica archivo_programa
	select count(*) into v_count from archivo_programa_f1;
	p_valida_insercion(535,v_count,'archivo_programa_f1');
	
	select count(*) into v_count from archivo_programa_f2;
	p_valida_insercion(465,v_count,'archivo_programa_f2');
	
	select count(*) into v_count from archivo_programa;
	p_valida_insercion(1000,v_count,'archivo_programa');

	--verifica playlist (solo la tabla global ya que puede variar)
	select count(*) into v_count from playlist;
	p_valida_insercion(1000,v_count,'playlist');

	--valida binarios para documental
	select count(*) into v_count from documental where dbms_lob.getlength(trailer) >0;
	p_valida_insercion_blob(v_count,'documental con BLOBs');

	--valida binarios para archivo_programa
	select count(*) into v_count from archivo_programa where dbms_lob.getlength(archivo) >0;
	p_valida_insercion_blob(v_count,'archivo_programa con BLOBs');

end;
/

prompt Listo!
exit



