`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 22:05:34
// Design Name: 
// Module Name: PC_update
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


module PC_update(
  input jump,jalr,branch_taken,
  input [31:0]pc_out2,
  input [31:0] pc,
  input [31:0]read_data1,
  input [31:0] immediate,
  input predict_taken,
  input [31:0] target_address,
  input predict_taken_out2,
  output reg [31:0]next_pc
    );
    always@(*)
    begin
     if(jalr) next_pc = (read_data1 + immediate)&(32'hFFFFFFFE);
    else if(jump) next_pc = pc_out2 + immediate;
    else if(branch_taken!=predict_taken_out2) begin
                                                  if(branch_taken) next_pc = pc_out2+immediate;
                                                   else next_pc = pc_out2+32'd4;
                                              end
    else if(predict_taken)next_pc = target_address;
    else next_pc = pc+32'd4;
    end
endmodule
