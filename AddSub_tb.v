`include "AddSub.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: AddSub_tb
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


module AddSub_tb();
reg[31:0] A,B;
reg addsub;
wire [31:0] result;

AddSub DUT(result, A, B, addsub);
initial begin
    A = 32'b00111111100000000000000000000000;   //A = 1
    B = 32'b00111111000000000000000000000000;   //B=0.5
    addsub = 1'b0;  //Addition
    #10 B = 32'b10111111110000000000000000000000;   //B=-1.5
    #10
    addsub = 1'b1;  //Subtraction
    #10 B = 32'b10111111110000000000000000000000;   //B=-1.5
    #10 B = 32'b00111111000000000000000000000000;   //B=0.5
    
    #10 $finish;
end

always @(*) begin
    $display("A+B=%b\n",result);
end
endmodule
