`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 19:48:22
// Design Name: 
// Module Name: Debounce
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


module Debounce #(parameter threshold = 1000000)
( input clk,
input btn , //input buttons for reset and transmit
output reg transmit
);

reg button_ff1=0; //flip flops registers for synchronization
reg button_ff2=0;
reg [30:0] count;

always@(posedge clk) begin
button_ff1<=btn;
button_ff2<=btn;
end

//when push button is pushed or released the counter is incremented or decremented
always@(posedge clk) begin
if(button_ff2) begin

if(~&count)
count<=count+1; //when button is pressed count up
end

else begin
if(|count)
count<=count-1; //when button is released count down
end

if(count>threshold)
transmit<=1; // debounc sigmal is high
else
transmit<=0; //debounce signal is low
end

endmodule
