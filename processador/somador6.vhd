library ieee;
use ieee.std_logic_1164.all;

entity somador6 is
	port(
		A ,B: in std_logic_vector(7 downto 0);
		cin : in std_logic;
		S: out std_logic_vector(7 downto 0));
end somador6;

architecture main of somador6 is
	signal carry: std_logic_vector (7 downto 0);

	component somador1 is
		port(
			a, b: in std_logic;
         cin: std_logic;
         co,s : out std_logic
		);
	end component;
	
	begin
		u0 : somador1 port map (a => A(0), b => B(0), cin => cin, co=> carry(0), s => S(0));
		u1 : somador1 port map (a => A(1), b => B(1), cin => carry(0), co=> carry(1), s => S(1));
		u2 : somador1 port map (a => A(2), b => B(2), cin => carry(1), co=> carry(2), s => S(2));
		u3 : somador1 port map (a => A(3), b => B(3), cin => carry(2), co=> carry(3), s => S(3));
		u4 : somador1 port map (a => A(4), b => B(4), cin => carry(3), co=> carry(4), s => S(4));
		u5 : somador1 port map (a => A(5), b => B(5), cin => carry(4), co=> carry(5), s => S(5));
		u6 : somador1 port map (a => A(6), b => B(6), cin => carry(5), co=> carry(6), s => S(6));
		u7 : somador1 port map (a => A(7), b => B(7), cin => carry(6), co=> carry(7), s => S(7));

end architecture main;
