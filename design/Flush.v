`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 15:51:46
// Design Name: 
// Module Name: flush
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


module Flush(
input jal_out2,jalr_out2,branch_taken,predict_taken_out2,
output flush
    );
    assign flush = jal_out2 || jalr_out2 || (branch_taken!=predict_taken_out2);
endmodule
