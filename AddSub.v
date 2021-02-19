`include "AddSub.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: AddSub
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

module AddSub(result, A, B, addsub);
input [31:0] A,B;
input addsub;
output [31:0] result;

wire [31:0] op_a,op_b,b;
wire [7:0] exp_a,exp_b,exp_sub,diff_exp;
wire [23:0] mantissa_a,mantissa_b,modified_b,comp_mantissa_b;
wire output_sign,operation;
wire [24:0] mantissa_add,mantissa_sub,subtraction_diff;
wire [30:0] add_sum,sub_diff;

assign b[31] = addsub? !B[31] : B[31];
assign b[30:0] = B[30:0];
assign {op_a,op_b} = (A[30:0]>b[30:0]) ? {A,b}:{b,A};
assign {exp_a,exp_b} = {op_a[30:23],op_b[30:23]};
assign mantissa_a = (|op_a[30:23]) ? {1'b1,op_a[22:0]} : {1'b0,op_a[22:0]};
assign mantissa_b = (|op_b[30:23]) ? {1'b1,op_b[22:0]} : {1'b0,op_b[22:0]};
assign diff_exp = op_a[30:23]-op_b[30:23];
assign modified_b = mantissa_b >> diff_exp;

assign operation = op_a[31]^op_b[31];

assign mantissa_add = (operation==1'b0)?(mantissa_a + modified_b):25'd0;
assign add_sum[22:0] = mantissa_add[24]? mantissa_add[23:1] : mantissa_add[22:0];
assign add_sum[30:23] = mantissa_add[24]? (8'd1 + op_a[30:23]) : op_a[30:23];

assign comp_mantissa_b = ~(modified_b) + 24'd1;
assign mantissa_sub = (operation==1'b1)?(mantissa_a + comp_mantissa_b ) : 25'd0;
priority_encoder pe(mantissa_sub,op_a[30:23],subtraction_diff,exp_sub);
assign sub_diff[22:0] = subtraction_diff[22:0];
assign sub_diff[30:23] = exp_sub;

assign result = (operation)? {op_a[31],sub_diff}:{op_a[31],add_sum};
/*
initial begin
    $monitor ($time,"mantissa_sub=%b / _a=%b \n",mantissa_sub,mantissa_a);
end
*/
endmodule
