library ieee;
use ieee.std_logic_1164.all;

entity cinext is port(
	x, y: in std_logic; -- entradas a e b sao bits somados, cin eh possivel carga anterior
    cout: out std_logic); -- saida co para carga e s para resultado da soma
end cinext;

architecture behav of cinext is
begin
   
    cout <= x and not(y);
	 
end;