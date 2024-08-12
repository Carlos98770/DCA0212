library ieee;
use ieee.std_logic_1164.all;

entity mux16_1 is
    port(
        i0, i1, i2, i3, i4, i5, i6, i7,
        i8, i9, i10, i11, i12, i13, i14, i15 : in std_logic_vector(7 downto 0);
        s0     : in std_logic_vector(3 downto 0);
        output : out std_logic_vector(7 downto 0)
    );
end mux16_1;

architecture main of mux16_1 is
begin
    process(s0, i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, i10, i11, i12, i13, i14, i15)
    begin
        case s0 is
            when "0000" =>
                output <= i0;
            when "0001" =>
                output <= i1;
            when "0010" =>
                output <= i2;
            when "0011" =>
                output <= i3;
            when "0100" =>
                output <= i4;
            when "0101" =>
                output <= i5;
            when "0110" =>
                output <= i6;
            when "0111" =>
                output <= i7;
            when "1000" =>
                output <= i8;
            when "1001" =>
                output <= i9;
            when "1010" =>
                output <= i10;
            when "1011" =>
                output <= i11;
            when "1100" =>
                output <= i12;
            when "1101" =>
                output <= i13;
            when "1110" =>
                output <= i14;
            when "1111" =>
                output <= i15;
            when others =>
                output <= "00000000"; -- Default case
        end case;
    end process;
end architecture;
