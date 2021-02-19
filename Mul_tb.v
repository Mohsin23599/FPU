`include "Mul.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: Mul_tb
// Project Name: Floating Point ALU
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


module Mul_tb();
reg [31:0] A,B;
wire [31:0] result;
wire overflow,underflow;

Mul DUT (result,overflow,underflow, A, B);

initial begin
    A = 32'b00111111100000000000000000000000;   //A=1
    B = 32'b00111111100000000000000000000000;   //B=1   A*B=1
    #10
    B = 32'b00111111110000000000000000000000;   //B=1.5     A*B=1.5
    #10
    A = 32'b10111111101000000000000000000000;   //A=-1.25   A*B= -1.875
    #10 $finish;
end

endmodule
