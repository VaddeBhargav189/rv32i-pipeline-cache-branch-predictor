`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 22:41:35
// Design Name: 
// Module Name: Write_back
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


module Write_back(
  input [31:0] alu_result,[31:0] pc,[31:0] immediate,[31:0] memory_data,
  input [1:0] resultsrc,
  output reg [31:0] write_data
    );
    
    always@(*)
    begin
      case(resultsrc)
          2'b00 : write_data = alu_result;
          2'b01 : write_data = memory_data;
          2'b10 : write_data = pc+32'd4;
          2'b11 : write_data = immediate;
          default : write_data = 32'd0;
         endcase
    end
endmodule
