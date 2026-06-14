`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 12:03:14
// Design Name: 
// Module Name: Alu_Controller
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


module Alu_controller(
    input [2:0]alu_op,
    input[2:0]funct3,
    input[6:0]funct7,
    output reg [3:0] alu_sel
    );
    
    //selecting the Operation(alu_sel) 
    
     always@(*)
     begin
     case(alu_op)
         3'b000,
         3'b001 : begin // R-Type and I-Type
                  case(funct3)
                  3'b000 : if(alu_op == 3'b000)//R-Type
                           begin
                           if(funct7 == 7'b0000000) alu_sel = 4'd0;
                           else alu_sel = 4'd1;
                           end
                           else // I-Type 
                             alu_sel = 4'd0;
                  3'b111 : alu_sel = 4'd2;
                  3'b110 : alu_sel = 4'd3;
                  3'b100 : alu_sel = 4'd4;
                  3'b001 : alu_sel = 4'd5;
                  3'b101 : begin
                           if(funct7 == 7'd0) alu_sel = 4'd6;
                           else alu_sel = 4'd7;
                           end
                  3'b010 : alu_sel = 4'd8;
                  3'b011 : alu_sel = 4'd9;
                  default : alu_sel = 4'd0;
                  endcase
                   end
        3'b010,
        3'b011 : //L-Type ans S-Type and AUIPC-TYPE
                 alu_sel = 4'd0;
        3'b100 : // B-Type
                  alu_sel = 4'd1;
        3'b101,
        3'b110 : //JAL and JALR 
                 alu_sel =  4'd0;
         default : alu_sel = 4'd0;          
     endcase
     end
       
endmodule
