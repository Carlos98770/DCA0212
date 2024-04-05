library ieee;
use ieee.std_logic_1164.all;
entity mux_2x1 is
    port(i0,i1,s0: in bit;
        d : out bit

    );
end mux_2x1;

architecture main of mux_2x1 is
    signal s1: bit;
    signal s2: bit;
    component AndGate is
        port(in_and1,in_and2: in bit;
            out_and: out bit
        ); 

    end component;
    
    component OrGate is
        port(in_or1,in_or2: in bit;
            out_or: out bit
        );
    end component; 

begin

    u1: AndGate port map(in_and1 => i0, in_and2 => NOT(s0),out_and => s1);
    u2: AndGate port map(in_and1 => i1, in_and2 => s0, out_and => s2 );
    u3: OrGate port map(in_or1 => s1,in_or2=>s2, out_or=> d);
-- 
end architecture main;