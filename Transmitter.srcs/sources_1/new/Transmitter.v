`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 01:51:40
// Design Name: 
// Module Name: Transmitter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Transmitter( input [7:0] data,clk,reset,transmit,
                    output reg TxD );
                    
//internal registers inside the transmitter blocks
reg [3:0] counter; // counter to count 10 bits
reg [13:0] baudrate_counter; //counter to count for 10416 times to ensure transmission of 1 bit at baud rate 9600/s
reg [9:0] shift_register; // shift regiter inside the transmitter block
reg shift; //to enable shifting of data bits in the shift register inside the  transmitter
reg load; //to ensure loading of data in the transmitter
reg clear;
reg state;
reg next_state;

always@(posedge clk) begin

if(reset) begin 
state<=1'b0;
counter<=1'b0;
baudrate_counter<=1'b0;
end

else  begin

baudrate_counter<=baudrate_counter+1;
if(baudrate_counter==10416) begin

if(load) begin
shift_register<={1'b1,data,1'b0};
end

if(clear) begin
shift_register<=10'b0;
end

if(shift) begin 
shift_register<=shift_register>>1;
counter<=counter+1'b1;
end

end
end
end

// State machines
always@(posedge clk) begin
load<=1'b0;
shift<=1'b0;
clear<=1'b0;
TxD<=1'b1; // 1 represents stop bit and no data is being transmitted

case(state) //idle state
 0: begin
 if(transmit) begin
 next_state<=1;
 load<=1'b1;
 shift<=1'b0;
 clear<=1'b0;
 end 
 
 
 else 
 begin
 next_state<=0; //stays in idle state
 TxD<=1; // no transmission taking place
 end
 end
 
 
 1: begin  // when we are in transmitting state
  if(counter==10) begin
  state<=0;   //stop data transmision
  clear<=1; //clear all the counters
  end
  
  else begin
  next_state<=1;
  TxD<=shift_register[0];
  shift<=1; //countinuing shifting 
  end
 end
 
 default : next_state<=0;
 
endcase
end



endmodule
