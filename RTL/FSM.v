// this module documted the logic of it in  pdf in same repo 
module FSM #(parameter total_time_till_filling=5'b00010, //this parameter to edit time of any cycle if needded
             parameter total_time_till_washing=5'b00111,  
             parameter total_time_till_rinsing=5'b01001,              
             parameter total_time_till_spinning=5'b01010,
             parameter total_time_till_second_washing=5'b01110,  
             parameter total_time_till_second_rinsing=5'b10000,   
             parameter total_time_till_spinning_with_double_flag=5'b10001)    (
    input   wire             clk,
    input   wire             rst_n,
    input   wire             coin_in, 
    input   wire             double_wash,
    input  wire              timer_pause,
    input   wire   [4:0]     timer, 
    output  reg              timer_enable,
    output  reg              pause_flag,
    output  reg              wash_done 
);

//declare states using gray code style 
    localparam    [2:0]     Idle=3'b000,
                            Filling_Water=3'b001,
                            Washing=3'b011,
                            Rinsing=3'b010,
                            Spinning=3'b110;

//declare internal registers
     reg   [2:0]   next_state;  
     reg   [2:0]   current_state; 
     reg           wash_done_wire; //this register to make wash_done flag is reg 

 //next transation with active low reset for current_state and Wash_done flag 
  always@(posedge clk or negedge rst_n)
   begin 
    if(!rst_n)
     begin
      current_state<=Idle;
      wash_done<='b0;
     end
    else
     begin
      current_state<=next_state;
      wash_done<=wash_done_wire;
     end
   end

// next state logic  
 always@(*) 
  begin 
    case(current_state)   
     Idle    :  begin                                //wait coin_in is asserted to start the cycle of machine else still in ideal state
                 if(coin_in)
                  begin
                   next_state=Filling_Water;
                  end
                 else
                  begin
                   next_state=Idle;
                  end
                end
 Filling_Water: begin     
                 if(timer==total_time_till_filling)               
                  begin
                   next_state=Washing;
                  end
                 else
                  begin
                   next_state=Filling_Water;
                  end
                end
  Washing  :    begin
                 if((timer==total_time_till_washing)||(timer==total_time_till_second_washing))
                  begin
                   next_state=Rinsing;
                  end
                 else
                  begin
                   next_state=Washing;
                  end
                end
  Rinsing  :    begin
                 if ((timer==total_time_till_rinsing)&&(double_wash))
                  begin
                   next_state=Washing;
                  end
                 else if (((timer==total_time_till_rinsing)&&(!double_wash))||((timer==total_time_till_second_rinsing)&&(double_wash)))
                  begin
                   next_state=Spinning;
                  end
                 else 
                  begin
                   next_state=Rinsing;
                  end
                end
  Spinning :    begin
                 if((timer==total_time_till_spinning_with_double_flag)||(timer==total_time_till_spinning))
                  begin
                   next_state=Idle;
                  end
                 else
                  begin
                   next_state=Spinning;
                  end
                end
    endcase
  end

// output logic 
 always@(*)
  begin 
    timer_enable=1'b1;
    wash_done_wire=wash_done;
    pause_flag=1'b0;
    case(current_state)
     Idle    :  begin
                 timer_enable=1'b0;
                 if(next_state==Filling_Water)
                   begin
                    wash_done_wire=1'b0;
                   end
                   else
                    begin 
                     wash_done_wire=wash_done; 
                    end
                end

  Spinning :    begin
                 if(timer_pause)
                  begin
                   pause_flag=1'b1;
                  end
                 else
                  begin
                   pause_flag=1'b0;
                  end
                  if(next_state==Idle)
                   begin
                    wash_done_wire=1'b1;
                   end
                   else
                    begin 
                     wash_done_wire=1'b0; 
                    end
                end
  default:      begin
                 timer_enable=1'b1;
                 wash_done_wire=1'b0;
                 pause_flag=1'b0;
                end
    endcase
  end
endmodule
