`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:15:39
// Design Name: 
// Module Name: Hazards_pipeline
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


module Hazard_Unit(

    // Decode stage instruction
    input [4:0] rs1,
    input [4:0] rs2,
    input [6:0] opcode,

    // ID/EX stage
    input [4:0] rs1_out2,
    input [4:0] rs2_out2,
    input [4:0] rd_out2,
    input memread_out2,

    // EX/MEM stage
    input [4:0] rd_out3,
    input Regwrite_out3,

    // MEM/WB stage
    input [4:0] rd_out4,
    input Regwrite_out4,

    // Store instruction currently in MEM
    input [4:0] rs2_out3,
    

    output reg stall,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB,
    output reg StoreForward
);

always @(*) begin

   
    // defaults
  

    stall        = 1'b0;
    ForwardA     = 2'b00;
    ForwardB     = 2'b00;
    StoreForward = 1'b0;

    
    // Load-use hazard
   
    if(memread_out2 &&
       (rd_out2 != 5'd0) &&
       ((rd_out2 == rs1) || (rd_out2 == rs2)) && opcode!=7'b0100011)
    begin
        stall = 1'b1;
    end

   
    // ForwardA
   
    if(Regwrite_out3 &&
       (rd_out3 != 5'd0) &&
       (rd_out3 == rs1_out2))
    begin
        ForwardA = 2'b10;
    end

    else if(Regwrite_out4 &&
            (rd_out4 != 5'd0) &&
            (rd_out4 == rs1_out2))
    begin
        ForwardA = 2'b01;
    end

    
    // ForwardB
    
    if(Regwrite_out3 &&
       (rd_out3 != 5'd0) &&
       (rd_out3 == rs2_out2))
    begin
        ForwardB = 2'b10;
    end

    else if(Regwrite_out4 &&
            (rd_out4 != 5'd0) &&
            (rd_out4 == rs2_out2))
    begin
        ForwardB = 2'b01;
    end

    
    // Store-data forwarding
    
    if(Regwrite_out4 &&
       (rd_out4 != 5'd0) &&
       (rd_out4 == rs2_out3))
    begin
        StoreForward = 1'b1;
    end

end

endmodule
