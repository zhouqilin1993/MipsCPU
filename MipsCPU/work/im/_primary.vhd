library verilog;
use verilog.vl_types.all;
entity im is
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        opcode          : out    vl_logic_vector(31 downto 0);
        IRWr            : in     vl_logic
    );
end im;
