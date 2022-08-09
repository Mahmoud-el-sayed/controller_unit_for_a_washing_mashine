`timescale 1us/1ns
//scaled one second to 10 micro second because the modelsim will runtime be very larg without this scale 
module TESTBENCH #(parameter WIDTH=29 , 
                      parameter final_value_1_mega_hz = 'd10,
                      parameter final_value_2_mega_hz = 'd20,   
                      parameter final_value_4_mega_hz = 'd40,    
                      parameter final_value_8_mega_hz = 'd80,
                      parameter total_time_till_filling=5'b00010, //this parameter to edit time of any cycle if needded
                      parameter total_time_till_washing=5'b00111,  
                      parameter total_time_till_rinsing=5'b01001,              
                      parameter total_time_till_spinning=5'b01010,
                      parameter total_time_till_second_washing=5'b01110,  
                      parameter total_time_till_second_rinsing=5'b10000,   
                      parameter total_time_till_spinning_with_double_flag=5'b10001) ();

    reg             clk_tb;
    reg             rst_n_tb;
    reg             coin_in_tb; 
    reg             double_wash_tb;
    reg             timer_pause_tb;
    reg  [1:0]      clk_freq_tb;
    wire            wash_done_tb;

    parameter  CLK_period=1;
    //register for check taht time of machine is true 
    reg [31:0]  start_time;
    reg [31:0]  final_time;

 initial 
  begin
    initializaton;
    reset;
    //test senario 1 that controller unit without double_wash , timer_pause_tb
    coin_in_tb=1'b1;
    start_time=$time; // return (time in nano second)
    repeat(80) #CLK_period; 
    coin_in_tb=1'b0;
    wait(wash_done_tb);
    final_time=$time;
    //difference between start and final in seconds  and divide it to scaled t0 10 micro second (scaled minute)
    if(((final_time-start_time)/(10*10))==10)    
    $display("pass time for snario 1");
    else
    $display("failed time for snario 1");
//--------------------------------------------------------------------------------------------------------------------
    //test senario 2 that controller unit with double_wash and without  timer_pause_tb 
    coin_in_tb=1'b1;
    start_time=$time; // return (time in nano second)
    repeat(80) #CLK_period; 
    coin_in_tb=1'b0;
     double_wash_tb='b1;
    wait(wash_done_tb);
    final_time=$time;
    //difference between start and final in seconds  and divide it to scaled t0 10 micro second (scaled minute)
    if(((final_time-start_time)/(10*10))==17)    
    $display("pass time for snario 2");
    else
    $display("failed time for snario 2");
//--------------------------------------------------------------------------------------------------------------------
    //test senario 3 that controller unit with double_wash and  timer_pause_tb  for 5 minutes
    coin_in_tb=1'b1;
    start_time=$time; // return (time in nano second)
    repeat(80) #CLK_period; 
    coin_in_tb=1'b0;
    double_wash_tb='b1;
    repeat(1520) #CLK_period;  //wait spinning cycle and assert timer_pause and after  5 minutes make it deasserted
    timer_pause_tb='b1;
    repeat(5*10*10) #CLK_period;  //becase  1 minute scaled to 10 clk_period (10 micro second)
    timer_pause_tb='b0;
    wait(wash_done_tb);
    final_time=$time;
    //difference between start and final in seconds  and divide it to scaled t0 10 micro second (scaled minute)
    if(((final_time-start_time)/(10*10))==22)    
    $display("pass time for snario 3");
    else
    $display("failed time for snario 3");  
//--------------------------------------------------------------------------------------------------------------------
    //test senario 4 that controller unit with double_wash and  timer_pause_tb  for 5 minutes using   clk_freq=1
    clk_freq_tb=2'b01;
    coin_in_tb=1'b1;
    start_time=$time; // return (time in nano second)
    repeat(80*2) #CLK_period; 
    coin_in_tb=1'b0;
    double_wash_tb='b1;
    repeat(1520*2) #CLK_period;  //wait spinning cycle and assert timer_pause and after  5 minutes make it deasserted
    timer_pause_tb='b1;
    repeat(5*10*10*2) #CLK_period;  //becase  1 minute scaled to 10 clk_period (10 micro second)
    timer_pause_tb='b0;
    wait(wash_done_tb);
    final_time=$time;
    //difference between start and final in seconds  and divide it to scaled t0 10 micro second (scaled minute)
    if(((final_time-start_time)/(10*10*2))==22)    
    $display("pass time for snario 4");
    else
    $display("failed time for snario 4");         
//--------------------------------------------------------------------------------------------------------------------
    //test senario 5 that controller unit with double_wash and without  timer_pause_tb  using   clk_freq=3
    coin_in_tb=1'b1;
    clk_freq_tb=2'b11;
    start_time=$time; // return (time in nano second)
    repeat(80) #CLK_period; 
    coin_in_tb=1'b0;
     double_wash_tb='b1;
    wait(wash_done_tb);
    final_time=$time;
    //difference between start and final in seconds  and divide it to scaled t0 10 micro second (scaled minute)
    if(((final_time-start_time)/(10*10*8))==17)    
    $display("pass time for snario 5");
    else
    $display("failed time for snario 5");  
    $stop;
  end
task reset ();
begin
  #CLK_period;
  rst_n_tb='b0;
  #CLK_period;
  rst_n_tb='b1;  
  #CLK_period;
end 
endtask

task initializaton ();
begin
  clk_freq_tb=2'b00;
  timer_pause_tb='b0;
  double_wash_tb='b0;
  clk_tb='b1;
  coin_in_tb=1'b0;
  rst_n_tb='b1;  
end 
endtask
//clock generator 
always #(CLK_period/0.2)   clk_tb=~clk_tb;

TOP_MODULE #(
    .WIDTH                                     (WIDTH                                     ),
    .final_value_1_mega_hz                     (final_value_1_mega_hz                     ),
    .final_value_2_mega_hz                     (final_value_2_mega_hz                     ),
    .final_value_4_mega_hz                     (final_value_4_mega_hz                     ),
    .final_value_8_mega_hz                     (final_value_8_mega_hz                     ),
    .total_time_till_filling                   (total_time_till_filling                   ),
    .total_time_till_washing                   (total_time_till_washing                   ),
    .total_time_till_rinsing                   (total_time_till_rinsing                   ),
    .total_time_till_spinning                  (total_time_till_spinning                  ),
    .total_time_till_second_washing            (total_time_till_second_washing            ),
    .total_time_till_second_rinsing            (total_time_till_second_rinsing            ),
    .total_time_till_spinning_with_double_flag (total_time_till_spinning_with_double_flag ))u_TOP_MODULE(
    .clk         (clk_tb         ),
    .rst_n       (rst_n_tb       ),
    .coin_in     (coin_in_tb     ),
    .double_wash (double_wash_tb ),
    .timer_pause (timer_pause_tb ),
    .clk_freq    (clk_freq_tb    ),
    .wash_done   (wash_done_tb   )
);

endmodule
