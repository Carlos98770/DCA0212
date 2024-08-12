library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Controler is
	port(
		clk, clr, RF_Rp_zero : in std_logic;
		IR01, IR02, IR03, OPCODE : in std_logic_vector(3 downto 0); --IR01 MENOS SIGNIFICATIOVS, OPCODE OS MAIS SIGNIFICATIVOS
		PC_ld, PC_clr, PC_inc, i_rd, IR_ld, D_en, D_rw, RF_W_wr, RF_s1,
		RF_s0, RF_Rp_rd, RF_Rq_rd, alu_s1, alu_s0, DP_addr_clr, DP_addr_ld : out std_logic;
		DP_addr_s : out std_logic;
		D_addr : out std_logic_vector(7 downto 0);
		RF_01, RF_02, RF_W_addr, RF_Rp_addr, RF_Rq_addr : out std_logic_vector(3 downto 0)
	);
end entity Controler;	


architecture behav of Controler is

		type states is (Init, Fetch, Decode, Load, Store, Add, LoadConst,
		Subtract, JumpIfZero, Saltar, LDAI);
		
		signal stateReg, nextState : states;
		signal LoadArmOff : std_logic_vector(7 downto 0);
		
begin
	process(clk, clr)
	begin
		if (clr = '1') then
			stateReg <= Init;
		elsif rising_edge(clk) then
			stateReg <= nextState;
		end if;
	end process;
	
	process (IR01, IR02, IR03, OPCODE, RF_Rp_zero, stateReg)
	begin
		case stateReg is
			when init =>
				PC_ld <= '0';
				PC_clr <= '1';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '1';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
			When Fetch =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '1';
				i_rd <= '1';
				IR_ld <= '1';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				nextState <= Decode;
			When Decode =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				if (OPCODE = "0000") then
					nextState <= Load;
				elsif (OPCODE = "0001") then
					nextState <= Store;
				elsif (OPCODE = "0010") then
					nextState <= Add;
				elsif (OPCODE = "0011") then
					nextState <= LoadConst;
				elsif (OPCODE = "0100") then
					nextState <= Subtract;
				elsif (OPCODE = "0101") then
					nextState <= JumpIfZero;
				elsif (OPCODE = "0110") then
					nextState <= LDAI;
				else
					nextState <= Fetch;
				end if;
			When Load =>
				LoadArmOff <= IR02 & IR01;
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '1';
				D_rw <= '0';
				RF_W_wr <= '1';
				RF_s1 <= '0';
				RF_s0 <= '1';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '1';
				DP_addr_s <= '0';
				D_addr <= LoadArmOff;
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= IR03;
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
			When Store =>
				LoadArmOff <= IR02 & IR01;
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '1';
				D_rw <= '1';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '1';
				DP_addr_s <= '0';
				D_addr <= LoadArmOff;
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= IR03;
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
			When Add =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '1';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '1';
				alu_s1 <= '0';
				alu_s0 <= '1';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= IR03;
				RF_Rp_addr <= IR02;
				RF_Rq_addr <= IR01;
				nextState <= Fetch;
			When LoadConst =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '1';
				RF_s1 <= '1';
				RF_s0 <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= IR01;
				RF_02 <= IR02;
				RF_W_addr <= IR03;
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
			When Subtract =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '1';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '1';
				alu_s1 <= '1';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= IR03;
				RF_Rp_addr <= IR02;
				RF_Rq_addr <= IR01;
				nextState <= Fetch;
			When JumpIfZero =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= IR03;
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
				if (RF_Rp_zero = '1') then
					nextState <= Saltar;
				else
					nextState <= Fetch;
				end if;
			When Saltar =>
				PC_ld <= '1';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '0';
				D_rw <= '0';
				RF_W_wr <= '0';
				RF_s1 <= '0';
				RF_s0 <= '0';
				RF_Rp_rd <= '0';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '0';
				DP_addr_s <= '0';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= "0000";
				RF_Rp_addr <= "0000";
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
			When LDAI =>
				PC_ld <= '0';
				PC_clr <= '0';
				PC_inc <= '0';
				i_rd <= '0';
				IR_ld <= '0';
				D_en <= '1';
				D_rw <= '0';
				RF_W_wr <= '1';
				RF_s1 <= '0';
				RF_s0 <= '1';
				RF_Rp_rd <= '1';
				RF_Rq_rd <= '0';
				alu_s1 <= '0';
				alu_s0 <= '0';
				DP_addr_clr <= '0';
				DP_addr_ld <= '1';
				DP_addr_s <= '1';
				D_addr <= "00000000";
				RF_01 <= "0000";
				RF_02 <= "0000";
				RF_W_addr <= IR02;
				RF_Rp_addr <= IR01;
				RF_Rq_addr <= "0000";
				nextState <= Fetch;
		end case;
	end process;
end architecture behav;
				
				
				