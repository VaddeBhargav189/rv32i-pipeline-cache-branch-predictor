`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 21:48:39
// Design Name: 
// Module Name: Branch_Logic
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


module Branch_logic(
   input branch,Zero_flag,set_lt,set_ltu,
   input [2:0] funct3,
   output reg branch_taken
    );
    always@(*)
    begin
     if(branch) begin
         case(funct3)
         3'd0 : branch_taken = Zero_flag;
         3'd1 : branch_taken = !Zero_flag;
         3'd4 : branch_taken = set_lt;
         3'd5 : branch_taken = !set_lt;
         3'd6 : branch_taken = set_ltu;
         3'd7 : branch_taken = !set_ltu;
         default : branch_taken = 1'b0;
         endcase
         end
      else branch_taken = 1'b0;    
    end
endmodule
