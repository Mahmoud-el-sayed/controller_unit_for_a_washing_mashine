library verilog;
use verilog.vl_types.all;
entity FSM is
    generic(
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
        timer           : in     vl_logic_vector(4 downto 0);
        timer_enable    : out    vl_logic;
        pause_flag      : out    vl_logic;
        wash_done       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of total_time_till_filling : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_washing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_rinsing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_spinning : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_second_washing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_second_rinsing : constant is 1;
    attribute mti_svvh_generic_type of total_time_till_spinning_with_double_flag : constant is 1;
end FSM;
