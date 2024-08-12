library ieee;
use ieee.std_logic_1164.all;

entity extALU is port(
	A, B: in std_logic_vector(7 downto 0); -- entradas A e B sao vetores a ser operados
    X, Y: in std_logic; -- seletores
    IA, IB: out std_logic_vector(7 downto 0); -- IA e IB sao vetores a ir para o somador
    cout: out std_logic); -- cout eh carry inicial quando necessario
end extALU;

architecture behav of extALU is
    component abext is
		port(
			x, y, a, b: in std_logic;
            ia, ib: out std_logic
		);
    end component;
    
    component cinext is
        port(
	        x, y: in std_logic;
            cout: out std_logic
        );
    end component;
begin
    i0: abext port map(x => X, y => Y,a => A(0), b => B(0), ia => IA(0), ib => IB(0));
    i1: abext port map(x => X, y => Y,a => A(1), b => B(1), ia => IA(1), ib => IB(1));
    i2: abext port map(x => X, y => Y,a => A(2), b => B(2), ia => IA(2), ib => IB(2));
    i3: abext port map(x => X, y => Y,a => A(3), b => B(3), ia => IA(3), ib => IB(3));
    i4: abext port map(x => X, y => Y,a => A(4), b => B(4), ia => IA(4), ib => IB(4));
    i5: abext port map(x => X, y => Y,a => A(5), b => B(5), ia => IA(5), ib => IB(5));
	 i6: abext port map(x => X, y => Y,a => A(6), b => B(6), ia => IA(6), ib => IB(6));
	 i7: abext port map(x => X, y => Y,a => A(7), b => B(7), ia => IA(7), ib => IB(7));
	 
    c: cinext port map(x => X, y => Y,cout => cout);

end;