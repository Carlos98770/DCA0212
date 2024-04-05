library ieee;
use ieee.std_logic_1164.all;
entity AndGate is
    port(in_and1,in_and2: in bit;
        out_and: out bit
    );
end AndGate;

architecture behav of AndGate is
    begin

    out_and <= in_and1 and in_and2;

end architecture behav;
    