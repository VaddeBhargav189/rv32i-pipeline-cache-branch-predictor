`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.05.2026 21:50:32
// Design Name: 
// Module Name: control_unit
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


module Control_unit(
 input [6:0]opcode,
 output reg Regwrite,memread,memwrite,branch,jump,jalr,opdsel,
 output reg [2:0]alu_op,
 output reg [1:0]Resultsrc
    );
   always@(opcode)
   begin
     case(opcode)
       7'b0110011 : begin //R-Type
                      Regwrite = 1'b1;opdsel = 1'b0;
                      memread = 1'b0;alu_op = 3'b000;
                      memwrite = 1'b0;Resultsrc = 2'b00;
                      branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                      end
       7'b0010011 : begin //I-begin
                    Regwrite = 1'b1;opdsel = 1'b1;
                    memread = 1'b0;alu_op = 3'b001;
                    memwrite = 1'b0;Resultsrc = 2'b00;
                    branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                    end
       7'b0000011 : begin //L-type
                    Regwrite = 1'b1;opdsel = 1'b1;
                    memread = 1'b1;alu_op = 3'b010;
                    memwrite = 1'b0;Resultsrc = 2'b01;
                    branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                    end
       7'b0100011 : begin //S-Type
                    Regwrite = 1'b0;opdsel = 1'b1;
                    memread = 1'b0;alu_op = 3'b011;
                    memwrite = 1'b1;Resultsrc = 2'b00;
                    branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                    end
       7'b1100011 : begin //B-Type
                    Regwrite = 1'b0;opdsel = 1'b0;
                    memread = 1'b0;alu_op = 3'b100;
                    memwrite = 1'b0;Resultsrc = 2'b00;
                    branch = 1'b1;jump = 1'b0;jalr = 1'b0;
                    end
       7'b1101111 : begin //JAL-type
                   Regwrite = 1'b1;opdsel = 1'b0;
                   memread = 1'b0;alu_op = 3'b101;
                   memwrite = 1'b0;Resultsrc = 2'b10;
                   branch = 1'b0;jump = 1'b1;jalr = 1'b0;
                   end
       7'b1100111 : begin//JALR-Type
                    Regwrite = 1'b1;opdsel = 1'b1;
                    memread = 1'b0;alu_op = 3'b110;
                    memwrite = 1'b0;Resultsrc = 2'b10;
                    branch = 1'b0;jump = 1'b1;jalr = 1'b1;
                    end
       7'b0110111 : begin//LUI-Type
                    Regwrite = 1'b1;opdsel = 1'b0;
                    memread = 1'b0;alu_op = 3'b111;
                    memwrite = 1'b0;Resultsrc = 2'b11;
                    branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                    end
       7'b0010111 : begin//AUIPC-begin
                    Regwrite = 1'b1;opdsel = 1'b1;
                    memread = 1'b0;alu_op = 3'b010;
                    memwrite = 1'b0;Resultsrc = 2'b00;
                    branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                    end
         default : begin
                   Regwrite = 1'b0;opdsel = 1'b0;
                   memread = 1'b0;alu_op = 3'b000;
                   memwrite = 1'b0;Resultsrc = 2'b00;
                   branch = 1'b0;jump = 1'b0;jalr = 1'b0;
                   end
       endcase
       end
       
       
endmodule
