library ieee;
use ieee.std_logic_1164.all;

entity decoderPortas is
    PORT(A4,A3,A2,A1: IN BIT;
        S0,S1,S2,S3,S4,S5,S6 : OUT BIT);
    
end decoderPortas;


architecture behav of decoderPortas is

begin

     process(A4, A3, A2, A1)
    begin
        if (A4 = '1' and A3 = '0' and A2 = '1' and A1 = '0') or  -- 10
           (A4 = '1' and A3 = '0' and A2 = '1' and A1 = '1') or  -- 11
           (A4 = '1' and A3 = '1' and A2 = '0' and A1 = '0') or  -- 12
           (A4 = '1' and A3 = '1' and A2 = '0' and A1 = '1') or  -- 13
           (A4 = '1' and A3 = '1' and A2 = '1' and A1 = '0') or  -- 14
           (A4 = '1' and A3 = '1' and A2 = '1' and A1 = '1') then -- 15
            S0 <= '1';
            S1 <= '1';
            S2 <= '1';
            S3 <= '1';
            S4 <= '1';
            S5 <= '1';
            S6 <= '1';
        else
            S6 <= (not(A4) and not(A3) and not(A2)) or (A3 and A2 and A1);
            S5 <= (not(A4) and not(A3) and A2) or (not(A4) and A2 and A1) or (not(A4) and not(A3) and A1);
            S4 <= (A1 and not(A4)) or (A3 and not(A4) and not(A2)) or (A1 and not(A3) and not(A2));
            S3 <= not(A4) and ((A3 and A2 and A1) or (A3 and not(A2) and not(A1)) or (A1 and not(A3) and not(A2)));
            S2 <= not(A4) and not(A3) and A2 and not(A1);
            S1 <= (not(A4) and A3 and not(A2) and A1) or (not(A4) and A3 and A2 and not(A1));
            S0 <= (not(A4) and not(A3) and not(A2) and A1) or (not(A4)and A3 and not(A2) and not(A1));
    	
        end if;
    end process;
    
    
end architecture behav;