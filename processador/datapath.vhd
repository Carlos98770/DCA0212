library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(
		clk : in std_logic;
		R_data		: in std_logic_vector(7 downto 0);
		RF_W_data	: in std_logic_vector(7 downto 0);
		RF_W_addr	: in std_logic_vector(3 downto 0);
		RF_W_wr		: in std_logic;
		RF_s			: in std_logic_vector(1 downto 0);
		RF_Rp_addr	: in std_logic_vector(3 downto 0);
		RF_Rp_rd		: in std_logic;
		RF_Rq_addr	: in std_logic_vector(3 downto 0);
		RF_Rq_rd		: in std_logic;
		ALU_s			: in std_logic_vector(1 downto 0);
		W_data		: out std_logic_vector(7 downto 0);
		jump 			: out std_logic;
		D_addr		: in std_logic_vector(7 downto 0);
		DP_addr     : out std_logic_vector(7 downto 0);
		DP_addr_s   : in  std_logic;
		DP_addr_ld  : in std_logic;
		DP_addr_clr : in std_logic
	);

end entity;
architecture main of datapath is

signal aux_DP_addr : std_logic_vector(7 downto 0);
signal aux_W_data: std_logic_vector(7 downto 0);
signal aux_S : std_logic_vector (7 downto 0);
signal aux_A : std_logic_vector (7 downto 0);
signal aux_B : std_logic_vector (7 downto 0);

component Mux2x1 is
	port(
		i0,i1 : in std_logic_vector(7 downto 0);
		s : in std_logic;
		output: out std_logic_vector(7 downto 0)
	);
end component;
component registradorclr is
	port(
		I    : in std_logic_vector(7 downto 0); 
		CLK  : in std_logic;
		load : in std_logic;
		clr  : in std_logic;
		Q    : out std_logic_vector(7 downto 0)
	
	);
	
end component;

component Mux3x1 is
	port(
		i0, i1, i2 : in std_logic_vector(7 downto 0);
		s0: in std_logic_vector(1 downto 0);
		output : out std_logic_vector(7 downto 0)
		
	);
end component;

component regfile is
	Port(
		clk		: in std_logic;
		W_data	: in std_logic_vector(7 downto 0);
		W_addr	: in std_logic_vector(3 downto 0);
		W_en		: in std_logic;
		RP_addr	: in std_logic_vector(3 downto 0);
		RP_en		: in std_logic;
		RP_data	: out std_logic_vector(7 downto 0);
		RQ_addr	: in std_logic_vector(3 downto 0);
		RQ_en		: in std_logic;
		RQ_data	: out std_logic_vector(7 downto 0)
		
);
end component;

component ALU is
	port(
		A,B : in std_logic_vector(7 downto 0);
		ALU_s: in std_logic_vector(1 downto 0);
		S: out std_logic_vector (7 downto 0)
		);
end component;
begin
   --Adicionar o MUX e o registrador para a nova função;
	
	u0: mux3x1 port map(i0=> aux_S, i1=>R_data,i2=>RF_W_data,s0=>RF_s,output=>aux_W_data);
	u1: regfile port map(clk => clk,W_data=>aux_W_data,W_addr=>RF_W_addr,W_en=>RF_W_wr,RP_addr=>RF_Rp_addr,RP_en=>RF_Rp_rd,RP_data=>aux_A,RQ_addr=>RF_Rq_addr,RQ_en=>RF_Rq_rd,RQ_data=>aux_B);
	u2: ALU port map(A=>aux_A,B=>aux_B,ALU_s=>Alu_s,S =>aux_S);
	
	u3 : Mux2x1 port map(i0 => D_addr, i1 => aux_A,s => DP_addr_s, output => aux_DP_addr);
	
	u4: registradorclr port map(I => aux_DP_addr,CLK => clk,load =>DP_addr_ld, clr =>DP_addr_clr,Q => DP_addr);
	
	jump <= not(Aux_A(6) or Aux_A(5) or Aux_A(4) or Aux_A(3) or Aux_A(2) or Aux_A(1) or Aux_A(0));
	W_data <= aux_A;

end architecture main;



