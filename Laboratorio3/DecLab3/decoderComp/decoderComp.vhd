library ieee;
use ieee.std_logic_1164.all;

ENTITY decoderComp IS

    PORT(A1,A2,A3,A4: IN BIT;
        S0,S1,S2,S3,S4,S5,S6 : OUT BIT);
END;

ARCHITECTURE behav OF decoderComp IS

SIGNAL out_aux: BIT_VECTOR(6 DOWNTO 0);
SIGNAL in_aux : BIT_VECTOR(3 DOWNTO 0);

BEGIN
in_aux <= A4 & A3 & A2 & A1; -- Usado para concatenar os sinais de entrada
WITH in_aux SELECT
out_aux <= "1000000" WHEN "0000",
            "1111001" WHEN "0001",
            "0100100" WHEN "0010",
            "0110000" WHEN "0011",
            "0011001" WHEN "0100",
            "0010010" WHEN "0101",
            "0000010" WHEN "0110",
            "1111000" WHEN "0111",
            "0000000" WHEN "1000",
            "0010000" WHEN "1001",
            "1111111" WHEN OTHERS;


S6 <= out_aux(6);
S5 <= out_aux(5);
S4 <= out_aux(4);
S3 <= out_aux(3);
S2 <= out_aux(2);
S1 <= out_aux(1);
S0 <= out_aux(0);
END;