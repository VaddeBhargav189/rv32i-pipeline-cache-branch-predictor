`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:04:02
// Design Name: 
// Module Name: IF_ID_register
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


module IF_ID_register(
         input clk,
         input reset,
         input [31:0] pc_in,
         input [31:0] instruction_in,
         input stall,flush,predict_taken_in,
         output reg [31:0] instruction_out,
         output reg [31:0] pc_out,
         output reg predict_taken_out
    );
    
    always@(posedge clk or posedge reset)
       begin
          if(reset || flush)  begin    // flushing the outputs incase of branching
                   instruction_out<=32'd0;
                   pc_out<=32'd0;
                   predict_taken_out<=1'd0;
                   end
          else if(!stall) begin       // freezing the outputs incase of load use hazard
              instruction_out<=instruction_in;
              pc_out<=pc_in;
              predict_taken_out<=predict_taken_in;
              end
       end
endmodule
