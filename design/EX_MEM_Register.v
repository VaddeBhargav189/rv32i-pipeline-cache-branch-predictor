`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:08:21
// Design Name: 
// Module Name: IE_IM_Register
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


module EX_MEM_register(
          input clk,
          input reset,
          input [31:0] add_in,
          input [31:0] read_data2_in,
          input [2:0] funct3_in,
          input memread_in,memwrite_in,
          input [31:0] alu_result_in,
          input [31:0] pc_in,
          input [31:0] immediate_value_in,
          input [1:0] result_src_in,
          input [4:0] rd_in,
          input Regwrite_in,
          input [4:0] rs2_in,
          output reg [31:0] add_out,
          output reg [31:0] read_data2_out,
          output reg [2:0] funct3_out,
          output reg memread_out,reg memwrite_out,
          output reg [31:0] alu_result_out,
          output reg [31:0] pc_out,
          output reg [31:0] immediate_value_out,
          output reg [1:0] result_src_out,
          output reg [4:0] rd_out,
          output reg Regwrite_out,
          output reg [4:0] rs2_out
    );
    always@(posedge clk or posedge reset)
        begin
           if(reset) begin
                     add_out<=32'd0;
                     read_data2_out<=32'd0;
                     funct3_out<=3'd0;
                     memread_out<=1'd0;
                     memwrite_out<=1'd0;
                     alu_result_out<=32'd0;
                     pc_out<=32'd0;
                     immediate_value_out<=32'd0;
                     result_src_out<=2'd0;
                     rd_out<=5'd0;
                     Regwrite_out<=1'd0;
                     rs2_out<=5'd0;
                     end
            else begin
                     add_out<=add_in;
                     read_data2_out<=read_data2_in;
                     funct3_out<=funct3_in;
                     memread_out<=memread_in;
                     memwrite_out<=memwrite_in;
                     alu_result_out<=alu_result_in;
                     pc_out<=pc_in;
                     immediate_value_out<=immediate_value_in;
                     result_src_out<=result_src_in;
                     rd_out<=rd_in;
                     Regwrite_out<=Regwrite_in;
                     rs2_out<=rs2_in;
                 end
        
        end
endmodule

