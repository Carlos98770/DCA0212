library ieee;
use ieee.std_logic_1164.all;

entity OrGate is
    port(in_or1,in_or2: in bit;
        out_or: out bit
    );
end OrGate;

architecture behav of OrGate is
    begin


    out_or <= in_or1 or in_or2;

end architecture behav;
