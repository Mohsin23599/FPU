`include "Div.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: Div_tb
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


module Div_tb();

    reg [31:0] A,B;
    wire [31:0] result;
    
    Div DUT (result, A, B);
    
    initial begin
        A = 32'b00111111100000000000000000000000;   //A=1
        B = 32'b00111111100000000000000000000000;   //B=1   A/B=1
        #10
        B = 32'b00111111110000000000000000000000;   //B=1.5     A/B=0.66667
        #10
        A = 32'b10111111101000000000000000000000;   //A=-1.25   A/B= -0.83333
        #10
        A = 32'b01000010111111100001000000000000;  //A = 127.03125
        B = 32'b01000001100001111000000000000000;   //B=16.9375     A/B=7.5
        
        #10 $finish;
    end    
endmodule
