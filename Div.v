`include "priority_encoder.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Mohammad Mohsin Ahmed
// 
// Create Date: 19.02.2021 20:07:34
// Design Name: FPU
// Module Name: Div
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


module Div(result,A,B);

    input [31:0] A;
    input [31:0] B;
    output [31:0] result;

    reg [23:0] res = 0;
    reg [23:0] mantissa_a,mantissa_b;
    reg [24:0] p1;
    wire [24:0] mantissa_result;
    integer i;
    wire sign;
    wire [7:0] exp,exp_sub;
    
    assign sign = A[31]^B[31];
    assign exp = A[30:23] - B[30:23] + 8'd127;
    
    always@ (A or B)
    begin
        mantissa_a = (|A[30:23])? {1'b1,A[22:0]} : {1'b0,A[22:0]};
        mantissa_b = (|B[30:23])? {1'b1,B[22:0]} : {1'b0,B[22:0]};
        p1= 0;
        
        for(i=0;i < 5'd24;i=i+1)    begin
            p1 = {p1[22:0],mantissa_a[23]};
            mantissa_a[23:1] = mantissa_a[22:0];
            p1 = p1 - mantissa_b;
            if(p1[23] == 1)    begin
                mantissa_a[0] = 0;
                p1 = p1 + mantissa_b;   end
            else
                mantissa_a[0] = 1;
        end
        
        res = mantissa_a;   
    end
    
    priority_encoder pe({1'b1,res}, exp, mantissa_result, exp_sub);
    assign result = {sign, exp_sub, mantissa_result[22:0]};
 /*   
    initial begin
        $monitor($time,"res = %b \ mantissa = %b\n",res,mantissa_result[23:0]);
    end
 */
endmodule
