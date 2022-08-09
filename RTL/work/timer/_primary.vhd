library verilog;
use verilog.vl_types.all;
entity timer is
    generic(
        WIDTH           : integer := 29;
        final_value_1_mega_hz: integer := 60000000;
        final_value_2_mega_hz: integer := 120000000;
        final_value_4_mega_hz: integer := 240000000;
        final_value_8_mega_hz: integer := 480000000
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_freq        : in     vl_logic_vector(1 downto 0);
        timer_enable    : in     vl_logic;
        pause_flag      : in     vl_logic;
        timer_Minutes   : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of final_value_1_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_2_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_4_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_8_mega_hz : constant is 1;
end timer;
