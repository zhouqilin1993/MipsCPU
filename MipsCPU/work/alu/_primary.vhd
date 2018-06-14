library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        aluctrl         : in     vl_logic_vector(2 downto 0);
        zero            : out    vl_logic;
        sign            : out    vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        \sll\           : in     vl_logic;
        \srl\           : in     vl_logic;
        \sra\           : in     vl_logic;
        sllv            : in     vl_logic;
        srlv            : in     vl_logic;
        srav            : in     vl_logic;
        s               : in     vl_logic_vector(4 downto 0)
    );
end alu;
