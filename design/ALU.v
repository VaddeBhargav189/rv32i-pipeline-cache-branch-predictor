`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 21:19:51
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0]A,[31:0]B,
    input [3:0]alu_sel,
    output reg [31:0]result, 
    output reg Zero_flag,set_lt,set_ltu
    );
    always@(*)
    begin
    Zero_flag = (A==B)?1'b1:1'b0;
    set_lt = ($signed(A)<$signed(B))?1'b1:1'b0;
    set_ltu = A<B?1'b1:1'b0;
    case(alu_sel)
       4'd0 : result = A + B;
       4'd1 : result = A - B;
       4'd2 : result = A & B;
       4'd3 : result = A | B;
       4'd4 : result = A ^ B;
       4'd5 : result = A << B[4:0];
       4'd6 : result = A >> B[4:0];
       4'd7 : result = $signed(A) >>> B[4:0];
       4'd8 : result = ($signed(A)<$signed(B))?32'd1:32'd0;
       4'd9 : result = A<B?32'd1:32'd0;
       default : result = 32'd0;
    endcase
    end
endmodule
