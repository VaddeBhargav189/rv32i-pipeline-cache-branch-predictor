`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 22:40:55
// Design Name: 
// Module Name: Instruction_memory
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


module Instruction_memory(
 input [31:0] pc,
 output [31:0] Instruction
    );
    reg [31:0] instruct_memory[0:255];
    initial begin                                 
    $readmemh("program.mem2", instruct_memory);
    $display("Instr0 = %h", instruct_memory[0]);
    $display("Instr1 = %h", instruct_memory[1]);
    $display("Instr2 = %h", instruct_memory[2]);
end
    assign Instruction = instruct_memory[pc[9:2]];
endmodule
