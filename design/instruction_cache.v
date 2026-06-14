`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2026 13:37:31
// Design Name: 
// Module Name: instruction_cache
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


module instruction_cache(
        input clk,
        input [31:0] pc,instruction_in,
        output [31:0] instruction_out
    );
    wire [1:0] index;
    reg valid[0:3];
    reg [31:0] instructions[0:3];
    reg [27:0] tag[0:3];
    wire hit;
    integer i;
    
    // making valids "0" initially
    initial begin
              for(i=0;i<4;i=i+1) valid[i] = 1'b0;
           end
           
    assign index = pc[3:2];
    assign hit = valid[index] && (tag[index]==pc[31:4]);
    
    // updating the cache incase of miss
    always@(posedge clk)
       begin
         if(!hit)begin
                 instructions[index]<=instruction_in;
                 valid[index]<=1'b1;
                 tag[index]<=pc[31:4];
                  end
       end
     
    // Reading from the cache (incase of hit read from cache and incase of miss read from memory)
   assign instruction_out = hit?instructions[index]:instruction_in;
endmodule
