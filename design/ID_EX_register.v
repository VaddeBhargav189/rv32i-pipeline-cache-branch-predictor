`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:05:42
// Design Name: 
// Module Name: ID_IE_Register
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


module ID_EX_register(
    input clk,
    input reset,
    input [2:0] funct3_in,//for alu_controller
    input [6:0] funct7_in,
    input [2:0] alu_op_in,
    input [31:0] read_data1_in,//for operandA
    input [31:0] pc_in,
    input [6:0] opcode_in,
    input [31:0] read_data2_in,//for operandB
    input [31:0] immediate_value_in,
    input opdsel_in, memread_in, memwrite_in,
    input [1:0] result_src_in,
    input [4:0] rd_in,
    input Regwrite_in,
    input [4:0] rs1_in,rs2_in,
    input branch_in,
    input stall,flush,predict_taken_in,
    input jal_in,jalr_in,
   output reg [2:0] funct3_out,
    output reg [6:0] funct7_out,
    output reg [2:0] alu_op_out,
    output reg [31:0] read_data1_out,
    output reg [31:0] pc_out,
    output reg [6:0] opcode_out,
    output reg [31:0] read_data2_out,
    output reg [31:0] immediate_value_out,
    output reg opdsel_out,reg memread_out, reg memwrite_out  ,
    output reg [1:0] result_src_out,
    output reg [4:0] rd_out,
    output reg Regwrite_out ,
    output reg [4:0] rs1_out,rs2_out,
    output reg branch_out,
    output reg jal_out,jalr_out,
    output reg predict_taken_out
    );
    always@(posedge clk or posedge reset)
       begin
            if(reset) begin
                           funct3_out<=3'd0;
                           funct7_out<=7'd0;
                           alu_op_out<=3'd0;
                           read_data1_out<=32'd0; 
                           pc_out<=32'd0;
                           opcode_out<=7'd0;
                           read_data2_out<=32'd0;
                           immediate_value_out<=32'd0;
                           opdsel_out<=1'd0;
                           memread_out<=1'd0;
                           memwrite_out<=1'd0;
                           result_src_out<=2'd0;
                           rd_out<=5'd0;
                           Regwrite_out<=1'd0;
                           rs1_out<=5'd0;
                           rs2_out<=5'd0;
                           branch_out<=1'b0;
                           jal_out<=1'd0;
                           jalr_out<=1'd0;
                           predict_taken_out<=1'd0;
                        end  
            else if(stall || flush) begin  //  bubbling incase of branching or load use hazard
                     funct3_out<=funct3_in;
                     funct7_out<=funct7_in;
                     alu_op_out<=3'd0;
                     read_data1_out<= read_data1_in;
                     pc_out<=pc_in;
                     opcode_out<=opcode_in;
                     read_data2_out<=read_data2_in;
                     immediate_value_out<=immediate_value_in;
                     opdsel_out<=opdsel_in;
                     memread_out<=1'd0;
                     memwrite_out<=1'd0;
                     result_src_out<=2'd0;
                     rd_out<=rd_in;
                     Regwrite_out<=1'd0;
                     rs1_out<=rs1_in;
                     rs2_out<=rs2_in;
                     branch_out<=1'd0;
                     jal_out<=1'd0;
                     jalr_out<=1'd0;
                     predict_taken_out<=1'd0;
                 end 
                 
                else begin
                     funct3_out<=funct3_in;
                     funct7_out<=funct7_in;
                     alu_op_out<=alu_op_in;
                     read_data1_out<= read_data1_in;
                     pc_out<=pc_in;
                     opcode_out<=opcode_in;
                     read_data2_out<=read_data2_in;
                     immediate_value_out<=immediate_value_in;
                     opdsel_out<=opdsel_in;
                     memread_out<=memread_in;
                     memwrite_out<=memwrite_in;
                     result_src_out<=result_src_in;
                     rd_out<=rd_in;
                     Regwrite_out<=Regwrite_in;
                     rs1_out<=rs1_in;
                     rs2_out<=rs2_in;
                     branch_out<=branch_in;
                     jal_out<=jal_in;
                     jalr_out<=jalr_in;
                     predict_taken_out<=predict_taken_in;
                 end 
       
       end
endmodule
