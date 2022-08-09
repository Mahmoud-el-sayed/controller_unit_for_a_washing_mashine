module TOP_MODULE #(  parameter WIDTH=29 , 
                      parameter final_value_1_mega_hz = 'd60*(10**6),
                      parameter final_value_2_mega_hz = 'd60*2*(10**6),   
                      parameter final_value_4_mega_hz = 'd60*4*(10**6),    
                      parameter final_value_8_mega_hz = 'd60*8*(10**6),
                      parameter total_time_till_filling=5'b00010,         //this parameter to edit time of any cycle if needded
                      parameter total_time_till_washing=5'b00111,  
                      parameter total_time_till_rinsing=5'b01001,              
                      parameter total_time_till_spinning=5'b01010,
                      parameter total_time_till_second_washing=5'b01110,  
                      parameter total_time_till_second_rinsing=5'b10000,   
                      parameter total_time_till_spinning_with_double_flag=5'b10001) (

    input   wire             clk,
    input   wire             rst_n,
    input   wire             coin_in, 
    input   wire             double_wash,
    input   wire             timer_pause,
    input   wire  [1:0]      clk_freq,
    output  wire             wash_done
);

wire     [4:0] timer_wire;
wire           enable_wire;
wire           pause_flag_wire;


    FSM  #(
    .total_time_till_filling                   (total_time_till_filling                   ),
    .total_time_till_washing                   (total_time_till_washing                   ),
    .total_time_till_rinsing                   (total_time_till_rinsing                   ),
    .total_time_till_spinning                  (total_time_till_spinning                  ),
    .total_time_till_second_washing            (total_time_till_second_washing            ),
    .total_time_till_second_rinsing            (total_time_till_second_rinsing            ),
    .total_time_till_spinning_with_double_flag (total_time_till_spinning_with_double_flag ) )  u_FSM(
    	.clk          (clk          ),
        .rst_n        (rst_n        ),
        .coin_in      (coin_in      ),
        .double_wash  (double_wash  ),
        .timer_pause  (timer_pause  ),
        .timer        (timer_wire       ),
        .timer_enable (enable_wire ),
        .pause_flag   (pause_flag_wire   ),
        .wash_done    (wash_done    )
    );

    timer  #(
        .WIDTH(WIDTH                 ),
        .final_value_1_mega_hz (final_value_1_mega_hz ),
        .final_value_2_mega_hz (final_value_2_mega_hz ),
        .final_value_4_mega_hz (final_value_4_mega_hz ),
        .final_value_8_mega_hz (final_value_8_mega_hz ) ) u_timer(
    	.clk           (clk           ),
        .rst_n         (rst_n         ),
        .clk_freq      (clk_freq      ),
        .timer_enable  (enable_wire  ),
        .pause_flag    (pause_flag_wire    ),
        .timer_Minutes (timer_wire )
    );





    
endmodule
