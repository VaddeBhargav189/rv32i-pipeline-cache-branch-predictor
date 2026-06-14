`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 14:22:15
// Design Name: 
// Module Name: test_bench_5stage
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


module test_bench_5stage;
reg clk;
reg reset;

Top_module_5staged DUT(.clk(clk),.reset(reset));

initial begin
        clk = 0;
        reset = 1;
        #20 reset = 0;
        #1000;
        $finish;
        end
        
        always #5 clk = ~clk;
      
endmodule