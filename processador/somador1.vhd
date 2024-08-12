library ieee;
use ieee.std_logic_1164.all;

entity somador1 is
    port(a, b: in std_logic;
         cin: std_logic;
         co, s: out std_logic);
end somador1;

architecture main of somador1 is
begin
    co <= (a and b) or (a and cin) or (b and cin);
    s <= (not(a) and not(b) and cin) or (not(a) and b and not(cin)) or (a and not(b) and not(cin)) or (a and b and cin);

end architecture main;