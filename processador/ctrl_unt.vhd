library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl_unt is
	port(
		clk, clr, RF_Rp_Zero : in std_logic;
		IR_in : in std_logic_vector (15 downto 0);
		PC_set : in std_logic_vector(7 downto 0);
		i_rd, d_en, d_rw, RF_W_wr, RF_Rp_rd, RF_Rq_rd, DP_addr_clr, DP_addr_ld, DP_addr_s : out std_logic;
		RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
		RF_sel, alu_sel: out std_logic_vector(1 downto 0);
		D_addr, RF_W_data, PC_out : out std_logic_vector(7 downto 0)
	);
end entity ctrl_unt;

architecture behav of ctrl_unt is

	component IR is
		port(
			clk, IR_ld: in std_logic;
			IR_in: in std_logic_vector(15 downto 0);
			IR_out: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component PC is
		port(
			clk, PC_ld, PC_clr, PC_inc: in std_logic;
			PC_set, PC_offset: in std_logic_vector(7 downto 0);
			PC_out: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component Controler is
		port(
			clk, clr, RF_Rp_zero : in std_logic;
			IR01, IR02, IR03, OPCODE : in std_logic_vector(3 downto 0);
			PC_ld, PC_clr, PC_inc, i_rd, IR_ld, D_en, D_rw, RF_W_wr, RF_s1,
			RF_s0, RF_Rp_rd, RF_Rq_rd, alu_s1, alu_s0, DP_addr_clr, DP_addr_ld : out std_logic;
			DP_addr_s : out std_logic;
			D_addr : out std_logic_vector(7 downto 0);
			RF_01, RF_02, RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0)
		);
	end component;
	
	SIGNAL IR_ldo, PC_ldo, PC_clro, PC_inco : std_logic;
	SIGNAL IR_SAIDA : std_logic_vector(15 downto 0);
	
	begin
		
		Instruction  : IR port map(clk => clk, IR_ld => IR_ldo, IR_in => IR_in, IR_out => IR_SAIDA);
		
		Pogram : PC port map(clk => clk, PC_ld => PC_ldo, PC_Clr => PC_clro, PC_inc => PC_inco, PC_offset => IR_SAIDA(7 downto 0), PC_set => PC_set, PC_out => PC_out);
		
		Ctrl : Controler port map(clk => clk, clr=>clr, RF_Rp_zero => RF_Rp_Zero, IR01 => IR_SAIDA(3 downto 0), IR02 => IR_SAIDA(7 downto 4), IR03 => IR_SAIDA(11 downto 8),
		OPCODE => IR_SAIDA(15 downto 12), PC_ld => PC_ldo, PC_clr => PC_clro, PC_inc => PC_inco, i_rd => i_rd, IR_ld => IR_ldo, D_en => d_en, D_rw => d_rw, RF_W_wr => RF_W_wr,
		RF_s1 => RF_sel(1), RF_s0 => RF_sel(0), RF_Rp_rd => RF_Rp_rd, RF_Rq_rd => RF_Rq_rd, alu_s1 => alu_sel(1), alu_s0 => alu_sel(0), DP_addr_clr => DP_addr_clr,
		DP_addr_ld => DP_addr_ld, DP_addr_s => DP_addr_s, D_Addr => D_addr, RF_01 => RF_W_data(3 downto 0), RF_02 => RF_W_data(7 downto 4), RF_W_addr => RF_W_addr,
		RF_Rp_addr => RF_Rp_addr, RF_Rq_addr => RF_Rq_addr);

end architecture behav;
	
	
	
	
	