library ieee;
use ieee.std_logic_1164.all;

entity mux3x1 is
	port(
		i0, i1, i2 : in std_logic_vector(7 downto 0);
		s0: in std_logic_vector(1 downto 0);
		output : out std_logic_vector(7 downto 0)
		
	);
end entity;

architecture main of mux3x1 is
signal in_aux	: std_logic_vector (1 downto 0);

begin
in_aux <= s0(1) & s0(0);
	with in_aux select
		output <= i0 when "00",
					 i1 when "01",
					 i2 when "10",
				    "00000000" when others;
		
end main;