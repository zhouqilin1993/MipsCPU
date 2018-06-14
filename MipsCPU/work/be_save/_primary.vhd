library verilog;
use verilog.vl_types.all;
entity be_save is
    port(
        sw              : in     vl_logic;
        sb              : in     vl_logic;
        sh              : in     vl_logic;
        addr            : in     vl_logic_vector(1 downto 0);
        bes             : out    vl_logic_vector(3 downto 0)
    );
end be_save;
