`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 21:25:07
// Design Name: 
// Module Name: Register_Bypassing
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


module Forwading(
input [31:0] Writedata,
input [4:0] rs1,rs2,
input [31:0] read_data1,read_data2,
input [4:0] rd_out4,
input Regwrite_out4,
output [31:0] read_data1_fixed,read_data2_fixed
    );
    assign read_data1_fixed = (Regwrite_out4 && (rd_out4!=5'd0) && (rd_out4==rs1))?Writedata:read_data1;
    assign read_data2_fixed = (Regwrite_out4 && (rd_out4!=5'd0) && (rd_out4==rs2))?Writedata:read_data2;
endmodule
