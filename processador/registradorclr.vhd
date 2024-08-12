library ieee;
use ieee.std_logic_1164.all;

entity registradorclr is
port (
    I    : in std_logic_vector(7 downto 0); 
    CLK  : in std_logic;
    load : in std_logic;
    clr  : in std_logic;
    Q    : out std_logic_vector(7 downto 0)
);
end registradorclr;

architecture behav of registradorclr is
    signal Q_internal : std_logic_vector(7 downto 0);
begin
    process(CLK, clr)
    begin
        if clr = '1' then
            Q_internal <= (others => '0');  -- Clear assíncrono
        elsif rising_edge(CLK) then
            if load = '1' then
                Q_internal <= I;  -- Carrega novo valor
            end if;
        end if;
    end process;

    Q <= Q_internal;
end architecture behav;