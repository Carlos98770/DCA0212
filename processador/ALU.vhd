library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(
		A,B : in std_logic_vector(7 downto 0);
		ALU_s : in std_logic_vector(1 downto 0);
		S: out std_logic_vector (7 downto 0));
end ALU;

architecture main of ALU is
	signal aluA, aluB: std_logic_vector(7 downto 0);
	signal crry: std_logic;
	
	component somador6 is
		port(
			A, B: in std_logic_vector(7 downto 0);
			cin : in std_logic;
			S: out std_logic_vector(7 downto 0)
		);
		
	end component;
	component extALU is port(
			A, B: in std_logic_vector(7 downto 0);
			X,Y: in std_logic;
			IA, IB: out std_logic_vector(7 downto 0);
			cout: out std_logic
		);
	end component;
	
	begin
		alu: extALU port map(A => A, B => B, X => ALU_S(1), Y => ALU_S(0),IA => aluA, IB => aluB, cout => crry);
		sum: somador6 port map(A => aluA, B => aluB, cin => crry, S => S);
			

end architecture main;