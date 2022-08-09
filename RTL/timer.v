module timer #(parameter WIDTH=29 , 
               parameter final_value_1_mega_hz = 'd60*(10**6),  // to count 1 minute , product 60 second by frequency 
               parameter final_value_2_mega_hz = 'd60*2*(10**6),   
               parameter final_value_4_mega_hz = 'd60*4*(10**6),    
               parameter final_value_8_mega_hz = 'd60*8*(10**6)) (
   
    input  wire             clk,
    input  wire             rst_n,
    input  wire   [1:0]     clk_freq,
    input  wire             timer_enable,
    input  wire             pause_flag,
    output reg    [4:0]     timer_Minutes  //5 bits because it count the minutes from 1 to 32 minutes but max minutes in my code is 17 minutes
);




               

 reg  [WIDTH-1:0]     edges_counter_internal; //counter for edges that incremented by 1 every active edge for clock 
 reg  [WIDTH-1:0]     edges_counter;         //this register for make edges_counter_internal is reg
 wire                 final_value_flag;      //declare a flag to control the counter  

 


// decalare counter with active low  reset 
 always @(posedge clk or negedge rst_n)
  begin
    if (!rst_n)
     begin
      edges_counter<='b0; 
     end 
    else 
     begin
      edges_counter<=edges_counter_internal;
     end
  end
// always block to declare rtl of counter to count one second depend on frequency
// 1-the counter will pause only if the machine is on and the flag of pause is asserted
// 2-the counter will increment till  final_value_flag is asserted which mean the counts of one minute is done (equation is 60 * frequency = 1 minute)
// 3-if no pause and the counter reach final value to calcualte second so it will reset again to zero to calculate a new second 
    always @(*) 
     begin
        if (pause_flag&&timer_enable)  
         begin
          edges_counter_internal=edges_counter;
         end
        else  if(timer_enable&&!final_value_flag) 
         begin
          edges_counter_internal=edges_counter+1'b1;
         end
         else
          begin 
            edges_counter_internal='b0;
          end
     end 
// always block to declare rtl of counter to count minutes 
// 1- this counter to count minutes depend on the previous counter which count on minute only and it will assert the final_value_flag evert one minute 
// 2- the else if to pause the counter of minutes when pause_flag is assert and I can't delete this case (because counter will reset to zero without it)
// 3- if the machine in ideal state then counter will be reset to zero 
   always@(*)
    begin
        if(timer_enable&&final_value_flag) 
         begin
          timer_Minutes=timer_Minutes+1'b1;
         end
        else if ((timer_enable) &&(pause_flag||(!final_value_flag)))
         begin
          timer_Minutes=timer_Minutes;
         end
         else
          begin 
            timer_Minutes='b0;
          end  
    end  
//assert final_value_flag with 1 if counter of one second equal final value to reset counter  to zero and count a new second and increment the minutes_counter
assign final_value_flag =((((edges_counter+1'b1)==final_value_1_mega_hz)&&(clk_freq==2'b00))||(((edges_counter+1'b1)==final_value_2_mega_hz)&&(clk_freq==2'b01))||(((edges_counter+1'b1)==final_value_4_mega_hz)&&(clk_freq==2'b10))||(((edges_counter+1'b1)==final_value_8_mega_hz)&&(clk_freq==2'b11)));

endmodule