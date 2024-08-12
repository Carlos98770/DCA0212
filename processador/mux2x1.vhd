library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
	port(
		i0,i1 : in std_logic_vector(7 downto 0);
		s : in std_logic;
		output: out std_logic_vector(7 downto 0)
	);
end entity;

architecture main of mux2x1 is
signal in_aux : std_logic;

begin	
	in_aux <= s;
	with in_aux select
		output <= i0 when '0',
					 i1 when '1',
					 "00000000" when others;

end main;