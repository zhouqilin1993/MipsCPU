library verilog;
use verilog.vl_types.all;
entity npc is
    port(
        pc              : in     vl_logic_vector(31 downto 0);
        branch          : in     vl_logic;
        zero            : in     vl_logic;
        j               : in     vl_logic;
        jr              : in     vl_logic;
        jal             : in     vl_logic;
        pcplus4         : out    vl_logic_vector(31 downto 0);
        npc             : out    vl_logic_vector(31 downto 0);
        pc_jr           : in     vl_logic_vector(31 downto 0);
        imm             : in     vl_logic_vector(25 downto 0);
        bne             : in     vl_logic;
        blez            : in     vl_logic;
        bgtz            : in     vl_logic;
        bltz            : in     vl_logic;
        bgez            : in     vl_logic;
        rd1             : in     vl_logic_vector(31 downto 0)
    );
end npc;
