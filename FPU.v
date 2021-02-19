`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: FPU
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


module FPU(ALU_output,overflow,underflow,op1,op2,fpu_operation);
input [31:0] op1,op2;
input [1:0] fpu_operation;
output [31:0] ALU_output;
output overflow,underflow;

wire [31:0] AddSub_A,AddSub_B,Mul_A,Mul_B,Div_A,Div_B;
wire [31:0] AddSub_output,Mul_output,Div_output;
wire addsub,AddSub_of,AddSub_uf,Mul_of,Mul_uf,Div_of,Div_uf;

assign 
    {AddSub_A,AddSub_B,addsub} = (fpu_operation == 2'd0)? {op1,op2,1'b0} : 64'dz,
    {AddSub_A,AddSub_B,addsub} = (fpu_operation == 2'd1)? {op1,op2,1'b1} : 64'dz,
    {Mul_A,Mul_B} = (fpu_operation == 2'd2) ? {op1,op2} : 64'dz,
    {Div_A,Div_B} = (fpu_operation == 2'd3) ? {op1,op2} : 64'dz;

AddSub D3(AddSub_output, AddSub_A, AddSub_B, addsub);
Mul D4(Mul_output, Mul_of, Mul_uf, Mul_A, Mul_B);
Div D5(Div_output, Div_A, Div_B);

assign  
    {ALU_output,overflow,underflow} = (fpu_operation == 2'd0)? {AddSub_output,AddSub_of,AddSub_uf} : 34'dz,
    {ALU_output,overflow,underflow} = (fpu_operation == 2'd1)? {AddSub_output,AddSub_of,AddSub_uf} : 34'dz,
    {ALU_output,overflow,underflow} = (fpu_operation == 2'd2)? {Mul_output,Mul_of,Mul_uf} : 34'dz,
    {ALU_output,overflow,underflow} = (fpu_operation == 2'd3)? {Div_output,Div_of,Div_uf} : 34'dz;

endmodule