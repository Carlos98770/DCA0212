library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
    port (
        clk, IR_ld: in std_logic;
        IR_in: in std_logic_vector(15 downto 0);
        IR_out: out std_logic_vector(15 downto 0));
end entity IR;

architecture behav of IR is
    signal IR_reg : std_logic_vector(15 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if (IR_ld = '1') then
                IR_reg <= IR_in;
            end if;
        end if;
    end process;

    IR_out <= IR_reg;
end architecture behav;