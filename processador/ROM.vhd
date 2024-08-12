LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
-- usado ROM como memoria de instrucoes
ENTITY ROM IS
PORT(
           clock : IN STD_LOGIC; 
           rom_enable : IN STD_LOGIC;
           address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           data_output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
END ROM;
ARCHITECTURE behav OF ROM IS
    TYPE rom_type IS ARRAY(0 to 15) OF STD_LOGIC_VECTOR(15 DOWNTO 0); -- ampliado largura para 16 bits
-- 15-12 = opcode | 11-8 = bloco 1 | 7-4 = bloco 2 | 3-0 = bloco 3
    CONSTANT mem: rom_type :=
           (0 => "0011000000000100", -- RF[0] = 4
            1 => "0011000100000001", -- RF[1] = 1
            2 => "0001000000000001", -- D[1] = RF[0]
            3 => "0110000000100001", -- RF[2] = D[RF[1]]
            4 => "0010001100000010", -- RF[3] = RF[0] + RF[2]
            5 => "0001001100000010", -- D[2] = RF[3]
            others => "0000000000000000" -- resto = intrucao nula
           );

BEGIN
PROCESS(clock) IS
BEGIN
    IF (RISING_EDGE(clock) AND rom_enable = '1') THEN
           data_output <= mem(conv_integer(unsigned(address)));
    END IF;
END PROCESS;
END behav;