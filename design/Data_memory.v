`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2026 10:27:55
// Design Name: 
// Module Name: Data_memory
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


module Data_memory(
     input clk,
     input [2:0] funct3,
     input memwrite,memread,
     input [31:0] adrs,[31:0] write_data,
     output reg [31:0] read_data
    );
   
    
    reg [7:0] data[0:1023];
    
    integer i;
    
    initial begin
             data[0] = 8'd7;  // keeping data[0] = 7 (used to verify the test cases)
            for(i=1;i<1024;i=i+1)
              data[i] = 8'd0;
              end
              
    // writng into data
    always@(posedge clk)
           begin
            if(memwrite)begin
            case(funct3)
           3'd0: data[adrs[9:0]] <= write_data[7:0];
           3'd1: begin data[adrs[9:0]] <= write_data[7:0];
                       data[adrs[9:0]+10'd1] <= write_data[15:8];
                 end
           3'd2 : begin data[adrs[9:0]] <= write_data[7:0];
                       data[adrs[9:0]+10'd1] <= write_data[15:8];
                       data[adrs[9:0]+10'd2] <= write_data[23:16];
                       data[adrs[9:0]+10'd3] <= write_data[31:24];
                  end
            endcase
           end
         end
         
     // Reading from the data
    always@(*)
    begin
    read_data = 32'd0;
      if(memread)begin
         case(funct3)
       3'd0 : read_data = { {24{data[adrs[9:0]][7]}},data[adrs[9:0]]};//lb
       3'd1 : read_data = {{16{data[adrs[9:0]+10'd1][7]}},data[adrs[9:0]+10'd1],data[adrs[9:0]]};
       3'd2 : read_data = {data[adrs[9:0]+10'd3],data[adrs[9:0]+10'd2],data[adrs[9:0]+10'd1],data[adrs[9:0]]};
       3'd4 : read_data = {24'd0,data[adrs[9:0]]};
       3'd5 : read_data = {16'd0,data[adrs[9:0]+10'd1],data[adrs[9:0]]};
       endcase
       end
    end     
endmodule
