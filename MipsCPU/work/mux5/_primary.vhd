library verilog;
use verilog.vl_types.all;
entity mux5 is
    port(
        a               : in     vl_logic_vector(4 downto 0);
        b               : in     vl_logic_vector(4 downto 0);
        c               : in     vl_logic_vector(4 downto 0);
        \select\        : in     vl_logic_vector(1 downto 0);
        y               : out    vl_logic_vector(4 downto 0)
    );
end mux5;
