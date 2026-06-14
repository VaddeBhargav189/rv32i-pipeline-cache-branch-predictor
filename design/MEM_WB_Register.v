`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:09:23
// Design Name: 
// Module Name: IM_WB_Register
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


module MEM_WB_register(
   input clk,
   input reset,
   input [31:0] alu_result_in,
   input [31:0] pc_in,
   input [31:0] immediate_value_in,
   input [31:0] data_memory_in,
   input [1:0] result_src_in,
   input [4:0] rd_in,
   input Regwrite_in,
   input memread_in,
   output reg [31:0] alu_result_out,
   output reg [31:0] pc_out,
   output reg [31:0] immediate_value_out,
   output reg [31:0] data_memory_out,
   output reg [1:0] result_src_out,
   output reg [4:0] rd_out,
   output reg Regwrite_out,
   output reg memread_out
    );
    always@(posedge clk or posedge reset)
           begin
             if(reset) begin
                       alu_result_out<=32'd0;
                       pc_out<=32'd0;
                       immediate_value_out<=32'd0;
                       data_memory_out<=32'd0;
                       result_src_out<=2'd0;
                       rd_out<=5'd0;
                       Regwrite_out<=1'd0;
                       memread_out<=5'd0;
                       end
             else  begin
                     alu_result_out<=alu_result_in;
                       pc_out<=pc_in;
                       immediate_value_out<=immediate_value_in;
                       data_memory_out<=data_memory_in;
                       result_src_out<=result_src_in;
                       rd_out<=rd_in;
                       Regwrite_out<=Regwrite_in;
                       memread_out<=memread_in;
                     end
           end
endmodule
