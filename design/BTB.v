`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 11:56:31
// Design Name: 
// Module Name: BTB
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


module BTB(
       input [31:0] pc,
       input clk,
       input [31:0] pc_out2,
       input predict_taken_out2,branch_taken,
       input [31:0] next_pc,
       output predict_taken,
       output [31:0] target_address
    );
    wire [2:0] index;
    reg valid[0:7];
    integer i;
    reg [26:0] tag[0:7];
    reg [31:0] target_addresses[0:7];
    
    // making valids "0" initially
    initial begin
         for(i=0;i<8;i=i+1) valid[i] = 1'b0;
    end
    
    assign index = pc[4:2];
    assign predict_taken = valid[index] && (tag[index]==pc[31:5]);
    assign target_address = target_addresses[index];
    
    // learning from the previous mistake
    always@(posedge clk)
       begin
         if(branch_taken!=predict_taken_out2) begin
                     valid[pc_out2[4:2]]<=~valid[pc_out2[4:2]];
                     tag[pc_out2[4:2]]<=pc_out2[31:5];
                     target_addresses[pc_out2[4:2]]<=next_pc;
         end
       end
endmodule
