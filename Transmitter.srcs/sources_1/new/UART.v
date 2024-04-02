`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2024 20:07:40
// Design Name: 
// Module Name: UART
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


module UART(
input [7:0] data,clk,transmit,reset,
output TxD
);

//wire transmitting_out;


Transmitter t1 (.clk(clk),.data(data),.reset(reset),.transmit(transmit),.TxD(TxD));


endmodule
