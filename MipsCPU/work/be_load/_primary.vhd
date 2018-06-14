library verilog;
use verilog.vl_types.all;
entity be_load is
    port(
        lw              : in     vl_logic;
        lh              : in     vl_logic;
        lhu             : in     vl_logic;
        lb              : in     vl_logic;
        lbu             : in     vl_logic;
        addr            : in     vl_logic_vector(1 downto 0);
        bel             : out    vl_logic_vector(6 downto 0)
    );
end be_load;
