`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 13:31:56
// Design Name: 
// Module Name: cache
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


module data_cache(
     input memread,memwrite,
     input clk,
     input [31:0] adrs,write_data,
     input [31:0] read_data_in,
     
     output reg [31:0] read_data_out
    );
    wire [1:0] index;
    reg [27:0] tag[0:3];
    reg [31:0] data[0:3];
    reg valid [0:3];
    wire hit;
   integer i;
   
   // making valids 0 initially
   initial begin
        for(i=0;i<4;i=i+1)  valid[i] = 1'd0;
   end
   
    assign index = adrs[3:2];   
    assign hit = valid[index] && (tag[index]==adrs[31:4]);
    
    // updating the cache incase of memwrite and miss
    always@(posedge clk)
       begin
       if(hit && memwrite) data[index] <= write_data;
       else if(memread && !hit) begin
                                 data[index] <= read_data_in;
                                     valid[index] <= 1'd1;
                                  tag[index] <= adrs[31:4];  
                                end
       end
      
     //Reading from the cache (in case of hit reading from the cache and in case of miss reading from the memory)
     always@(*)
        begin
        read_data_out = 32'd0;
        
          if(memread)   begin
                 read_data_out = hit?data[index]:read_data_in;
          end
        end
    
endmodule
