`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2026 11:26:45
// Design Name: 
// Module Name: Register_file
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


module Register_file(
         input clk,
         input Regwrite,
         input [4:0]rs1,[4:0]rs2,[4:0]rd,
         input [31:0] Writedata,
         output reg [31:0] read_data1,reg [31:0] read_data2
    );
    reg [31:0] Registers[0:31];
    integer i;
    
    initial begin      // keeping every register 0 intially
            for(i=0;i<32;i=i+1)
             Registers[i] = 32'd0;
             end 
    
    always@(posedge clk)   // writing into the memory
    begin
    if(Regwrite && (rd!=5'd0)) Registers[rd]<=Writedata;
    end
    
    always@(*)             //Reading from the memory
    begin
    read_data1 =(rs1==5'd0)?32'd0: Registers[rs1];
    read_data2 = (rs2==5'd0)?32'd0:Registers[rs2];
    end
    
endmodule
