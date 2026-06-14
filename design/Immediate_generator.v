`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2026 11:58:54
// Design Name: 
// Module Name: immediate_generator
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


module Immediate_generator(
     input [31:0] instruction,
     output reg [31:0] immediate_value
    );
    always@(*)
    begin
    case(instruction[6:0]) 
      7'b0010011 : immediate_value = {{20{instruction[31]}},instruction[31:20]};// I-type
      7'b0000011 : immediate_value = {{20{instruction[31]}},instruction[31:20]};//L-type
      7'b0100011 : immediate_value = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};//S-type
      7'b1100011 : immediate_value = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};//B-type
      7'b0110111,//LUI-type
      7'b0010111 : immediate_value = {instruction[31:12],12'd0};//AUIPc-type
      7'b1101111 : immediate_value = {{11{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};//JAL-type
      7'b1100111 : immediate_value = {{20{instruction[31]}},instruction[31:20]};// JALr-type
      default : immediate_value = 32'd0;
      endcase
    end
      
endmodule
