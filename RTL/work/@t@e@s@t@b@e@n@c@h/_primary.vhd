library verilog;
use verilog.vl_types.all;
entity TESTBENCH is
    generic(
        WIDTH           : integer := 29;
        final_value_1_mega_hz: integer := 10;
        final_value_2_mega_hz: integer := 20;
        final_value_4_mega_hz: integer := 40;
        final_value_8_mega_hz: integer := 80;
        total_time_till_filling: vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi0, Hi1, Hi0);
        total_time_till_washing: vl_logic_vector(0 to 4) := (Hi0, Hi0, Hi1, Hi1, Hi1);
        total_time_till_rinsing: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi0, Hi1);
        total_time_till_spinning: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi0, Hi1, Hi0);
        total_time_till_second_washing: vl_logic_vector(0 to 4) := (Hi0, Hi1, Hi1, Hi1, Hi0);
        total_time_till_second_rinsing: vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi0);
        total_time_till_spinning_with_double_flag: vl_logic_vector(0 to 4) := (Hi1, Hi0, Hi0, Hi0, Hi1)
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
end TESTBENCH;
