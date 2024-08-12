library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port (
        clk, PC_ld, PC_clr, PC_inc: in std_logic;
		PC_set, PC_offset: in std_logic_vector(7 DOWNTO 0);
        PC_out: out std_logic_vector(7 downto 0));
end entity PC;

architecture behav of PC is
    signal PC_reg : integer RANGE 0 to 31;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if (PC_clr = '1') then
                PC_reg <= 0;
            elsif (PC_ld = '1') then
			    PC_reg <= PC_reg + to_integer(signed(PC_offset)) - 1;
            elsif (PC_inc = '1') then
                PC_reg <= PC_reg + 1;
            end if;
        end if;
    end process;

    PC_out <= std_logic_vector(to_signed(PC_reg, 8));
end architecture behav;