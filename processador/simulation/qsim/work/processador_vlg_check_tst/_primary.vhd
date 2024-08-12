library verilog;
use verilog.vl_types.all;
entity processador_vlg_check_tst is
    port(
        ALU_Sel         : in     vl_logic_vector(1 downto 0);
        dataOut         : in     vl_logic_vector(7 downto 0);
        I_data          : in     vl_logic_vector(15 downto 0);
        I_rd            : in     vl_logic;
        RAM_addr        : in     vl_logic_vector(3 downto 0);
        RAM_en          : in     vl_logic;
        RAM_rw          : in     vl_logic;
        RAMOut          : in     vl_logic_vector(7 downto 0);
        RF_RPaddr       : in     vl_logic_vector(3 downto 0);
        RF_Waddr        : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end processador_vlg_check_tst;
