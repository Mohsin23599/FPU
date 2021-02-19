`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: Mul
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


module Mul(result,overflow,underflow, A, B);
input [31:0] A,B;
output [31:0] result;
output overflow,underflow;

wire [8:0] sum_exp;
wire [23:0] mantissa_a,mantissa_b;
wire [22:0] final_mantissa;
wire [47:0] product_mantissa,normalised_product;
wire sign,exception,round,normalised,zero;

assign sign = A[31]^B[31];
assign mantissa_a = (|A[30:23])? {1'b1,A[22:0]} : {1'b0,A[22:0]};
assign mantissa_b = (|B[30:23])? {1'b1,B[22:0]} : {1'b0,B[22:0]};

assign exception = &A[30:23] | &B[30:23];
assign product_mantissa = mantissa_a * mantissa_b;
assign round = |product_mantissa[22:0];
assign normalised = product_mantissa[47]? 1'b1:1'b0;
assign normalised_product = normalised ? product_mantissa : product_mantissa<<1;

assign final_mantissa = normalised_product[46:24] + (normalised_product[23]&round); 

assign sum_exp = A[30:23] + B[30:23] - 8'd127 + normalised;

assign zero = exception?1'b0 : (|final_mantissa | |sum_exp[7:0])? 1'b0 : 1'b1;
assign overflow = (sum_exp[8] & !sum_exp[7] & !zero); 
assign underflow = (sum_exp[8] & sum_exp[7] & !zero); 

assign result = exception? 32'd0 : zero ? {sign,31'd0} : overflow ? {sign,8'hFF,23'd0} : underflow ? {sign,31'd0} : {sign,sum_exp[7:0],final_mantissa};

initial begin
    $monitor($time,"sum_exp =%b / sign=%b / final_matissa=%b",sum_exp,sign,product_mantissa);
end
endmodule
