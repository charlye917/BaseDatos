--@Autor:          Jorge A. Rodríguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Archivo de carga inicial.

Prompt ======================================
Prompt validando transparencia de eliminacion
Prompt ======================================

Prompt seleciconar la PDB para validar
connect netmax_bdd/netmax_bdd@&pdb

whenever sqlerror exit rollback;

set serveroutput on

create or replace procedure p_valida_eliminacion(
	v_count in number, v_tabla in varchar2
) is
begin
	if(v_count >0 ) then
		raise_application_error(-20004,'Se encontraron '
			||v_count 
			||' registros en '
			||v_tabla);
	else
		dbms_output.put_line('0 registros para '||v_tabla);
	end if;
end;
/
show errors

Prompt validando registros eliminados ...

declare
	v_count number(10,0);
begin

		--verifica playlist
	select count(*) into v_count from playlist_f1;
	p_valida_eliminacion(v_count,'playlist_f1');
	select count(*) into v_count from playlist_f2;
	p_valida_eliminacion(v_count,'playlist_f2');
	select count(*) into v_count from playlist_f3;
	p_valida_eliminacion(v_count,'playlist_f3');
	select count(*) into v_count from playlist;
	p_valida_eliminacion(v_count,'playlist');

	--verifica usuario
	select count(*) into v_count from usuario_f1;
	p_valida_eliminacion(v_count,'usuario_f1');
	select count(*) into v_count from usuario_f2;
	p_valida_eliminacion(v_count,'usuario_f2');
	select count(*) into v_count from usuario_f3;
	p_valida_eliminacion(v_count,'usuario_f3');
	select count(*) into v_count from usuario_f4;
	p_valida_eliminacion(v_count,'usuario_f4');
	select count(*) into v_count from usuario_f5;
	p_valida_eliminacion(v_count,'usuario_f5');
		select count(*) into v_count from usuario;
	p_valida_eliminacion(v_count,'usuario');

    --verifica archivo_programa
	select count(*) into v_count from archivo_programa_f1;
	p_valida_eliminacion(v_count,'archivo_programa_f1');
	select count(*) into v_count from archivo_programa_f2;
	p_valida_eliminacion(v_count,'archivo_programa_f2');
	select count(*) into v_count from archivo_programa;
	p_valida_eliminacion(v_count,'archivo_programa');
	

	--verifica historico
	select count(*) into v_count from historico_status_programa_f1;
	p_valida_eliminacion(v_count,'historico_status_programa_f1');
	select count(*) into v_count from historico_status_programa;
	p_valida_eliminacion(v_count,'historico_status_programa');


	--verifica documental
	select count(*) into v_count from documental_f1;
	p_valida_eliminacion(v_count,'documental_f1');
	select count(*) into v_count from documental_f2;
	p_valida_eliminacion(v_count,'documental_f2');
	select count(*) into v_count from documental_f3;
	p_valida_eliminacion(v_count,'documental_f3');
	select count(*) into v_count from documental;
	p_valida_eliminacion(v_count,'documental');

		--verifica pelicula
	select count(*) into v_count from pelicula_f1;
	p_valida_eliminacion(v_count,'pelicula_f1');
	select count(*) into v_count from pelicula_f2;
	p_valida_eliminacion(v_count,'pelicula_f2');
	select count(*) into v_count from pelicula_f3;
	p_valida_eliminacion(v_count,'pelicula_f3');
	select count(*) into v_count from pelicula;
	p_valida_eliminacion(v_count,'pelicula');

	--verifica serie
	select count(*) into v_count from serie_f1;
	p_valida_eliminacion(v_count,'serie_f1');
	select count(*) into v_count from serie_f2;
	p_valida_eliminacion(v_count,'serie_f2');
	select count(*) into v_count from serie_f3;
	p_valida_eliminacion(v_count,'serie_f3');
	select count(*) into v_count from serie;
	p_valida_eliminacion(v_count,'serie');


	--verifica programa
	select count(*) into v_count from programa_f1;
	p_valida_eliminacion(v_count,'programa_f1');
	select count(*) into v_count from programa_f2;
	p_valida_eliminacion(v_count,'programa_f2');
	select count(*) into v_count from programa_f3;
	p_valida_eliminacion(v_count,'programa_f3');
	select count(*) into v_count from programa;
	p_valida_eliminacion(v_count,'programa');

end;
/

prompt Listo!
exit



