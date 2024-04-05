library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_comportamental is
    port(in0,in1, SO: in bit; 
        o: out bit
    );

end mux2x1_comportamental;

architecture behav of mux2x1_comportamental is

begin

with SO select

    o <= in0 when '0',
         in1 when '1';


end architecture behav;

