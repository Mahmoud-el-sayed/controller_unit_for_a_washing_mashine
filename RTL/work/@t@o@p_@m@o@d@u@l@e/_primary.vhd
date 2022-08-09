library verilog;
use verilog.vl_types.all;
entity TOP_MODULE is
    generic(
        WIDTH           : integer := 29;
        final_value_1_mega_hz: integer := 60000000;
        final_value_2_mega_hz: integer := 120000000;
        final_value_4_mega_hz: integer := 240000000;
        final_value_8_mega_hz: integer := 480000000;
        total_time_till_filling: vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        total_time_till_washing: vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi1);
        total_time_till_rinsing: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi1);
        total_time_till_spinning: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi1, Hi0);
        total_time_till_second_washing: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi1, Hi0);
        total_time_till_second_rinsing: vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        total_time_till_spinning_with_double_flag: vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        coin_in         : in     vl_logic;
        double_wash     : in     vl_logic;
        timer_pause     : in     vl_logic;
        clk_freq        : in     vl_logic_vector(1 downto 0);
        wash_done       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of final_value_1_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_2_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_4_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of final_value_8_mega_hz : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_filling : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_washing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_rinsing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_spinning : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_second_washing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_second_rinsing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_spinning_with_double_flag : constant is 1;
end TOP_MODULE;
