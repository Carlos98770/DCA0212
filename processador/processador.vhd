library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port (
        clk, reset : in std_logic;
        dataOut , RAMOut : out STD_LOGIC_VECTOR (7 DOWNTO 0);
        I_data : out std_logic_vector(15 downto 0);
        ALU_Sel : out std_logic_vector(1 DOWNTO 0);
        RF_Waddr, RF_RPaddr, RAM_addr : out std_logic_vector(3 DOWNTO 0);
        I_rd, RAM_en, RAM_rw : out std_logic
    );
end entity processador;

architecture main of processador is
    component ctrl_unt is
        port(
            clk, clr, RF_Rp_Zero : in std_logic;
            IR_in : in std_logic_vector (15 downto 0);
            PC_set : in std_logic_vector(7 downto 0);
            i_rd, d_en, d_rw, RF_W_wr, RF_Rp_rd, RF_Rq_rd,
            DP_addr_clr, DP_addr_ld, DP_addr_s : out std_logic;
            RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0);
            RF_sel, alu_sel: out std_logic_vector(1 downto 0);
            D_addr, RF_W_data, PC_out : out std_logic_vector(7 downto 0)
        );
    end component ctrl_unt;
    
    component datapath is
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
    end component datapath;
    
    component RAM is
    port(
           clock : in STD_LOGIC; 
           rw_enable : in STD_LOGIC;
           mem_enable : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           data_input : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           data_output : out STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    end component RAM;
    
    component ROM is
    port(
           clock : in STD_LOGIC; 
           rom_enable : in STD_LOGIC;
           address : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           data_output : out STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    end component ROM;
	 
    signal RF_Rp_ZeroOut, i_rdOut, d_enOut, d_rwOut, RF_W_wrOut, RF_Rp_rdOut, RF_Rq_rdOut,
    DP_addr_clrOut, DP_addr_ldOut, DP_addr_sOut: std_logic;
    signal RF_selOut, alu_selOut: std_logic_vector(1 downto 0);
    signal PC_setOut, D_addrOut, RF_W_dataOut, PC_outOut, DP_addrOut, R_dataOut, W_dataOut: std_logic_vector(7 downto 0);
    signal I_dataOut: std_logic_vector(15 downto 0);
    signal RF_W_addrOut, RF_Rp_addrOut, RF_Rq_addrOut: std_logic_vector(3 downto 0);
    
    begin
        dataOut <= W_dataOut;
        I_data <= I_dataOut;
		  RAMOut <= R_dataOut;
		  RAM_en <= d_enOut;
		  RAM_rw <= d_rwOut;
        ALU_Sel <= alu_selOut;
        RF_Waddr <= RF_W_addrOut;
        RF_RPaddr <= RF_Rp_addrOut;
        I_rd <= i_rdOut;
		  RAM_addr <= DP_addrOut(3 downto 0);
        
        CtrlU: ctrl_unt port map (clk => clk, clr => reset, RF_Rp_Zero => RF_Rp_ZeroOut,
        IR_in => I_dataOut, PC_set => PC_setOut, i_rd => i_rdOut, d_en => d_enOut, d_rw => d_rwOut, RF_W_wr => RF_W_wrOut,
        RF_Rp_rd => RF_Rp_rdOut, RF_Rq_rd => RF_Rq_rdOut, DP_addr_clr => DP_addr_clrOut, DP_addr_ld => DP_addr_ldOut,
        Dp_addr_s => DP_addr_sOut, RF_W_addr => RF_W_addrOut, RF_Rp_addr => RF_Rp_addrOut, RF_Rq_addr => RF_Rq_addrOut,
        RF_sel => RF_selOut, alu_sel => alu_selOut, D_addr => D_addrOut, RF_W_data => RF_W_dataOut, PC_out => PC_outOut);
        
        DP: datapath port map (clk => clk, R_data => R_dataOut, RF_W_data => RF_W_dataOut, RF_W_addr => RF_W_addrOut,
        RF_W_wr => RF_W_wrOut, RF_s => RF_selOut, RF_Rp_addr => RF_Rp_addrOut, RF_Rp_rd => RF_Rp_rdOut, RF_Rq_addr => RF_Rq_addrOut,
        RF_Rq_rd => RF_Rq_rdOut, ALU_s => alu_selOut, W_data => W_dataOut, jump => RF_Rp_ZeroOut, D_addr => D_addrOut,
        DP_addr => DP_addrOut, DP_addr_s => DP_addr_sOut, DP_addr_ld => DP_addr_ldOut, DP_addr_clr => DP_addr_clrOut);
        
        InstMem: ROM port map (clock => NOT clk, rom_enable => i_rdOut, address => PC_outOut(3 DOWNTO 0), data_output => I_dataOut);
        DMem : RAM port map (clock => clk, rw_enable => d_rwOut, mem_enable => d_enOut, address => DP_addrOut(3 downto 0),
		  data_input => W_dataOut, data_output => R_dataOut);
end architecture main;