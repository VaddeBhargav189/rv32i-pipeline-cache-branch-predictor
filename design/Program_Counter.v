`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2026 21:27:19
// Design Name: 
// Module Name: Program_Counter
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


module Program_counter(
         input clk,
         input reset,
         input stall,
         input [31:0]next_pc,
         output reg [31:0] pc
    );
    always@(posedge clk or posedge reset)
         begin
         if(reset) pc<=32'd0;
         else if(!stall) pc<=next_pc;  //stalling incase of load use hazard
         end
endmodule
