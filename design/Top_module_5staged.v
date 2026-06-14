`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 11:00:55
// Design Name: 
// Module Name: Top_module_5staged
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


module Top_module_5staged(
     input clk,
     input reset
    );
    
    //Wires from single cycle risc-v32
   wire [31:0] next_pc ;
   wire [31:0] pc;
   wire [31:0] Instruction;
   wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
   wire [4:0] rs1,rs2,rd;
   wire Regwrite,memread,memwrite,branch,jump,jalr,opdsel;
   wire [2:0] alu_op;
   wire [1:0] Resultsrc;
   wire [31:0] immediate_value;
   wire [3:0] alu_sel;
   wire [31:0] Writedata;
   wire [31:0] read_data1,read_data2;
   wire [31:0] A,B;
   wire [31:0] result;
   wire Zero_flag,set_lt,set_ltu;
   wire branch_taken;
   wire [31:0] memory_data;
   
   // Mentioned out1 for wires coming from IF_ID Register  simillarly out2(ID_EX) , out3(EX_MEM) , out4(MEM_WB)
   
   //wires taken from IF_ID Register
   wire [31:0] instruction_out1;
   wire [31:0] pc_out1;
   
   // wires taken from ID_EX Register
   wire [2:0] funct3_out2;
   wire [6:0] funct7_out2;
   wire [2:0] alu_op_out2;
   wire [31:0] read_data1_out2;
   wire [31:0] pc_out2;
   wire [6:0] opcode_out2;
   wire [31:0] read_data2_out2;
   wire [31:0] immediate_value_out2;
   wire opdsel_out2,memread_out2,memwrite_out2;
   wire [1:0] result_src_out2;
   wire [4:0] rd_out2;
   wire Regwrite_out2;
   wire branch_out2;
   
   //wires taken from EX_MEM Register
   wire [31:0] add_out3;
   wire [31:0] read_data2_out3;
   wire [2:0] funct3_out3;
   wire memread_out3,memwrite_out3;
   wire [31:0] alu_result_out3;
   wire [31:0] pc_out3;
   wire [31:0] immediate_value_out3;
   wire [1:0] result_src_out3;
   wire [4:0] rd_out3;
   wire Regwrite_out3;
   
   // wires taken from MEM_WB Regsiter
   wire [31:0] alu_result_out4;
   wire [31:0] pc_out4;
   wire [31:0] immediate_value_out4;
   wire [31:0] data_memory_out4;
   wire [1:0] result_src_out4;
   wire [4:0] rd_out4;
   wire Regwrite_out4;
   
   // wires taken for Hazard Handling
   
   //from ID_EX Register
   wire [4:0] rs1_out2,rs2_out2;
   
   //from EX_MEM Register
   wire [4:0] rs2_out3;
   
   //from hazard_unit
   wire stall;
   wire [1:0] ForwardA;
   wire [1:0] ForwardB;
   wire StoreForward;
   
   // from MEM_WB Register
   wire memread_out4;
   
   //Extra wires
  reg [31:0] operandA,operandB;
  wire [31:0] memory_write_data;
  
  //Wires taken for Forwading
   wire [31:0] read_data1_fixed,read_data2_fixed;
   
   // wires taken for flushing
   wire flush;
   wire jal_out2,jalr_out2;
   
   //wires taken from cache
   wire [31:0] cache_read_data;
   wire [31:0] cache_instruction;
   
   //wires taken for branch prediction
   wire predict_taken_out2;
   wire predict_taken;
   wire [31:0] target_address;
   wire predict_taken_out1;
   
  Program_counter   Program_counter_insta(.clk(clk),.reset(reset),.stall(stall),.next_pc(next_pc),.pc(pc));
  
  Instruction_memory Instruction_memory_insta(.pc(pc),.Instruction(Instruction));
  
  IF_ID_register IF_ID_register_insta(.predict_taken_in(predict_taken),.flush(flush),.clk(clk),.reset(reset),.pc_in(pc),.instruction_in(cache_instruction),.stall(stall),.instruction_out(instruction_out1),.pc_out(pc_out1),.predict_taken_out(predict_taken_out1));
  
  Instruction_decode Instruction_decode_insta(.Instruction(instruction_out1),.opcode(opcode),.funct3(funct3),.funct7(funct7),.rs1(rs1),.rs2(rs2),.rd(rd));
  
  Control_unit Control_unit_insta(.opcode(opcode),.Regwrite(Regwrite),.memread(memread),.memwrite(memwrite),.branch(branch),.jump(jump),.jalr(jalr),.opdsel(opdsel),.alu_op(alu_op),.Resultsrc(Resultsrc));
  
  Immediate_generator Immediate_generator_insta(.instruction(instruction_out1),.immediate_value(immediate_value));
  
   Register_file Register_file_insta(.clk(clk),.Regwrite(Regwrite_out4),.rs1(rs1),.rs2(rs2),.rd(rd_out4),.Writedata(Writedata),.read_data1(read_data1),.read_data2(read_data2));
  
  ID_EX_register ID_EX_register_insta(.predict_taken_in(predict_taken_out1),.predict_taken_out(predict_taken_out2),.jal_in(jump),.jalr_in(jalr),.jal_out(jal_out2),.jalr_out(jalr_out2),.flush(flush),.branch_in(branch),.branch_out(branch_out2),.clk(clk),.reset(reset),.funct3_in(funct3),.funct7_in(funct7),.alu_op_in(alu_op),.read_data1_in(read_data1_fixed),.pc_in(pc_out1),.opcode_in(opcode),.read_data2_in(read_data2_fixed),.immediate_value_in(immediate_value),.opdsel_in(opdsel),.memread_in(memread),.memwrite_in(memwrite),.result_src_in(Resultsrc),.rs1_in(rs1),.rs2_in(rs2),.rd_in(rd),.Regwrite_in(Regwrite),.stall(stall),.funct3_out(funct3_out2),.funct7_out(funct7_out2),.alu_op_out(alu_op_out2),.read_data1_out(read_data1_out2),.pc_out(pc_out2),.opcode_out(opcode_out2),.read_data2_out(read_data2_out2),.immediate_value_out(immediate_value_out2),.opdsel_out(opdsel_out2),.memread_out(memread_out2),.memwrite_out(memwrite_out2),.result_src_out(result_src_out2),.rs1_out(rs1_out2),.rs2_out(rs2_out2),.rd_out(rd_out2),.Regwrite_out(Regwrite_out2));
  
  Alu_controller Alu_controller_insta(.alu_op(alu_op_out2),.funct3(funct3_out2),.funct7(funct7_out2),.alu_sel(alu_sel));
  
  Hazard_Unit Hazard_Unit_insta(.rs1(rs1),.rs2(rs2),.opcode(opcode),.rs1_out2(rs1_out2),.rs2_out2(rs2_out2),.rd_out2(rd_out2),.memread_out2(memread_out2),.rd_out3(rd_out3),.Regwrite_out3(Regwrite_out3),.rd_out4(rd_out4),.Regwrite_out4(Regwrite_out4),.rs2_out3(rs2_out3),.StoreForward(StoreForward),.ForwardA(ForwardA),.ForwardB(ForwardB),.stall(stall));
  
  //Hazard Handling
  
  // for OperandA
  always @(*) begin
    case(ForwardA)

        2'b00:
            operandA = read_data1_out2;

        2'b01:
            operandA =
                memread_out4 ?
                data_memory_out4 :
                alu_result_out4;

        2'b10:
            operandA = alu_result_out3;

        default:
            operandA = read_data1_out2;

    endcase
end

// for OperandB

always @(*) begin
    case(ForwardB)

        2'b00:
            operandB = read_data2_out2;

        2'b01:
            operandB =
                memread_out4 ?
                data_memory_out4 :
                alu_result_out4;

        2'b10:
            operandB = alu_result_out3;

        default:
            operandB = read_data2_out2;

    endcase
end

// storing data in memory
assign memory_write_data =
    StoreForward ?
    (memread_out4 ? data_memory_out4
                  : alu_result_out4)
    :
    read_data2_out3;
 
  // Operand selections 
  // Operand A selection
  assign A = (opcode_out2==7'b0010111)?pc_out2:operandA;
  
  //Operand B selection
  assign B = (opdsel_out2)?immediate_value_out2:operandB;
  
  ALU ALU_insta(.A(A),.B(B),.alu_sel( alu_sel),.result(result),.Zero_flag(Zero_flag),.set_lt(set_lt),.set_ltu(set_ltu));
  
  EX_MEM_register EX_MEM_register_insta(.clk(clk),.reset(reset),.add_in(result),.read_data2_in(read_data2_out2),.funct3_in(funct3_out2),.memread_in(memread_out2),.memwrite_in(memwrite_out2),.alu_result_in(result),.pc_in(pc_out2),.immediate_value_in(immediate_value_out2),.result_src_in(result_src_out2),.rs2_in(rs2_out2),.rd_in(rd_out2),.Regwrite_in(Regwrite_out2),.add_out(add_out3),.read_data2_out(read_data2_out3),.funct3_out(funct3_out3),.memread_out(memread_out3),.memwrite_out(memwrite_out3),.alu_result_out(alu_result_out3),.pc_out(pc_out3),.immediate_value_out(immediate_value_out3),.result_src_out(result_src_out3),.rs2_out(rs2_out3),.rd_out(rd_out3),.Regwrite_out(Regwrite_out3));
  
  Branch_logic Branch_logic_insta(.branch(branch_out2),.Zero_flag(Zero_flag),.set_lt(set_lt),.set_ltu(set_ltu),.funct3(funct3_out2),.branch_taken(branch_taken));
  
   PC_update  PC_update_insta(.predict_taken(predict_taken),.target_address(target_address),.predict_taken_out2(predict_taken_out2),.jump(jal_out2),.jalr(jalr_out2),.branch_taken(branch_taken),.pc(pc),.pc_out2(pc_out2),.read_data1(operandA),.immediate(immediate_value_out2),.next_pc(next_pc));
   
   Data_memory Data_memory_insta(.clk(clk),.memwrite(memwrite_out3),.memread(memread_out3),.adrs(add_out3),.write_data(memory_write_data),.funct3(funct3_out3),.read_data(memory_data));
  
  MEM_WB_register MEM_WB_register_insta(.clk(clk),.reset(reset),.alu_result_in(alu_result_out3),.pc_in(pc_out3),.immediate_value_in(immediate_value_out3),.data_memory_in(cache_read_data),.result_src_in(result_src_out3),.rd_in(rd_out3),.memread_in(memread_out3),.Regwrite_in(Regwrite_out3),.alu_result_out(alu_result_out4),.pc_out(pc_out4),.immediate_value_out(immediate_value_out4),.data_memory_out(data_memory_out4),.result_src_out(result_src_out4),.rd_out(rd_out4),.memread_out(memread_out4),.Regwrite_out(Regwrite_out4));
  
   Write_back Write_back_insta(.alu_result(alu_result_out4),.pc(pc_out4),.immediate(immediate_value_out4),.memory_data(data_memory_out4),.resultsrc(result_src_out4),.write_data(Writedata));
   
   Forwading Forwading_insta(.Writedata(Writedata),.rs1(rs1),.rs2(rs2),.read_data1(read_data1),.read_data2(read_data2),.rd_out4(rd_out4),.Regwrite_out4(Regwrite_out4),.read_data1_fixed(read_data1_fixed),.read_data2_fixed(read_data2_fixed));
   
   Flush Flush_insta(.jal_out2(jal_out2),.jalr_out2(jalr_out2),.branch_taken(branch_taken),.predict_taken_out2(predict_taken_out2),.flush(flush));
   
   data_cache data_cache_insta(.memread(memread_out3),.memwrite(memwrite_out3),.clk(clk),.adrs(add_out3),.write_data(memory_write_data),.read_data_in(memory_data),.read_data_out(cache_read_data));
   
   instruction_cache instruction_cache_insta(.pc(pc),.instruction_in(Instruction),.clk(clk),.instruction_out(cache_instruction));
   
   BTB BTB_insta(.clk(clk),.pc(pc),.pc_out2(pc_out2),.branch_taken(branch_taken),.predict_taken_out2(predict_taken_out2),.next_pc(next_pc),.predict_taken(predict_taken),.target_address(target_address));
endmodule

