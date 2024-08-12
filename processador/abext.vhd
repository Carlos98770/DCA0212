library ieee;
use ieee.std_logic_1164.all;

entity abext is port(
	x, y,a, b: in std_logic; -- entradas a e b sao bits individuais dos vetores de entrada, ix, iy e iz sao bits do seletor
    ia, ib: out std_logic); -- saida ia e ib para bits individuais dos vetores para o somador
end abext;

architecture behav of abext is
begin
	ia <= (not(x) and not(y) and a) or (not(x) and y and a and not(b)) or (not(x) and  y and a and b) or (x and not(y) and a and not(b)) or (x and not(y) and a and b);
	
	ib <= (not(x) and y and not(a) and b) or (not(x) and y and a and b) or (x and not(y) and not(a) and not(b)) or (x and not(y) and a and not(b));
	
end;