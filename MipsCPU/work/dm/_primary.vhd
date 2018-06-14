library verilog;
use verilog.vl_types.all;
entity dm is
    port(
        clk             : in     vl_logic;
        we              : in     vl_logic;
        addr            : in     vl_logic_vector(31 downto 0);
        wd              : in     vl_logic_vector(31 downto 0);
        bes             : in     vl_logic_vector(3 downto 0);
        bel             : in     vl_logic_vector(6 downto 0);
        rdata           : out    vl_logic_vector(31 downto 0)
    );
end dm;
