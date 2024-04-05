library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
    port(i0_mux4x1,i1_mux4x1,i2_mux4x1,i3_mux4x1, s0_mux4x1,s1_mux4x1: in bit;
        out_mux4x1: out bit
    );
end mux4x1;

architecture behav of mux4x1 is

    signal s1_mux2x1: bit;
    signal s2_mux2x1: bit;
   

    component mux_2x1 is
        port(i0,i1,s0: in bit;
             d : out bit

    );
	 end component;


begin

    a1: mux_2x1 port map(i0 => i0_mux4x1, i1 => i1_mux4x1, d => s1_mux2x1, s0 => s1_mux4x1);
    a2: mux_2x1 port map(i0 => i2_mux4x1, i1 => i3_mux4x1, d=> s2_mux2x1, s0 => s1_mux4x1);
    a3: mux_2x1 port map(i0 =>s1_mux2x1 , i1 => s2_mux2x1, d => out_mux4x1, s0 => s0_mux4x1);

end architecture behav;