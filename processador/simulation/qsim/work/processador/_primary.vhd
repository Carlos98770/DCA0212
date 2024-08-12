library verilog;
use verilog.vl_types.all;
entity processador is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        dataOut         : out    vl_logic_vector(7 downto 0);
        RAMOut          : out    vl_logic_vector(7 downto 0);
        I_data          : out    vl_logic_vector(15 downto 0);
        ALU_Sel         : out    vl_logic_vector(1 downto 0);
        RF_Waddr        : out    vl_logic_vector(3 downto 0);
        RF_RPaddr       : out    vl_logic_vector(3 downto 0);
        RAM_addr        : out    vl_logic_vector(3 downto 0);
        I_rd            : out    vl_logic;
        RAM_en          : out    vl_logic;
        RAM_rw          : out    vl_logic
    );
end processador;
