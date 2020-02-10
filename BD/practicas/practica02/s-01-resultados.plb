
Prompt Proporcionar el password de SYS
connect sys as sysdba
set serveroutput on

@s-00-funciones-validacion.plb

create or replace procedure pv_valida_datos_instancia wrapped 
a000000
1
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
83d 3b9
Kzj0evrxy64s4Ry0b6inoVgEAhMwgzuNmkgTfI7Uv0wmu7jRG/fyPi7rTFnN3/TTF+lmqXSi
mITLU8Wrj0fI8jubKxBGvLTL7q5apyUrpKFG8zPB0Jq/y1JNO7f0rr1Wu9YSp9vzmWYr43rj
AzRwkwSCfGiG76ZVsOIu2V4OBaceE0Ermvu49KH1KHTZgSEMSTdj14Wl1J/tJyFJdyp+Cq1b
XpohB4HyroxBuzZBN05peHwbaivJya6FyFl0KB9c67B3Qa/kx4KG/M597OQh33iwEUpRAkwH
6HnaPSX6gUeyfprHz66VD3Crb4gWYIGJdmWnwGn+ywHt6Pz/XpBxgSZV9DRX2HflDcOSjbm+
Rwv3pHcmjSfsIOs3BVzx0vx+CSkfhMPCVGIPZVxiRFRkANpQICF7DvzcvPKOkGMpMR0cuL94
+cBY1JxC4m7Su6tRc1cjOOv88+UVKZz0Expe8+2n9ZMwcyd6GG3qmyaZxHcpXpL5PIQpvyEr
OLwpmlbTykK88p5v9OSNXLsF7Qll6EuxlKXNWxbu8ovg8z6PVS8KJkTliNG9IcZ/skzVUjZG
CRPL3MaMs33PTVRmTFrLUm+ePkJU59240znNBcHTg0XF1fYghrliAeetW0GWvpGZOfCQyfJq
N3VImIrKtyl2crQay2xehrGP5DZjr/mysGkTVcfn8IFvKi0b5ya8fXwen4M5MTrqgeakjU+1
ZzvegWka2UYftfEeSJod4gv8jIrUup9Og0w6HPyoPGtcKjL63tLRV7RE5p8xVlhWhJesVyPa
tnSY4yCGyKEUXsocPsyUxw/yUtnHdiR8zgODp+YVFc46PoSJl+LIXbSn0HKuAWA+2S+bPHZe
r5FLcIUsnWtdV/AXQ9XyqSK+GTKYnOvGhr601AuiYwBGw6VfgOblBxi+dqeqTTA3agquqvtn
DZZe

/
show errors

@s-00-header-validacion.plb

Prompt==================================
Prompt 1. Obteniendo datos de la instancia.
Prompt ==================================
exec pv_valida_datos_instancia

drop procedure pv_valida_datos_instancia;
drop function fv_hash;
drop function fv_ok_prefix;
drop function fv_list_prefix;
Prompt Listo!
exit