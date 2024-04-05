library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_4bits is
    port(
        a0,a1,a2,a3,b0,b1,b2,b3,z0: in bit;
        out_0,out_1,out_2,out_3: out bit

    );
end mux2x1_4bits;

architecture main of mux2x1_4bits is

    component mux_2x1 is
        port(
            in_a, in_b,s0: in bit;
            d : out bit
        );
    end component;

    begin

        u1: mux_2x1 port map(in_a => a0,in_b=>b0,s0 => z0, d=> out_0);
        u2: mux_2x1 port map(in_a => a1,in_b=>b1,s0 => z0, d=> out_1);
        u3: mux_2x1 port map(in_a => a2,in_b=>b2,s0 => z0, d=> out_2);
        u4: mux_2x1 port map(in_a => a3,in_b=>b3,s0 => z0, d=> out_3);


end architecture main; 
    

