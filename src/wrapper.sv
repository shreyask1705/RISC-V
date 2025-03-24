module riscv_processor (
    input logic clk,
    input logic reset_n
);
    // Program Counter
    logic [31:0] pc, pc_next;
    logic PCSrc;
    logic [31:0] immediate_extended;
    
    program_counter PC (
        .clk(clk),
        .pc_in(pc_next),
        .reset_n(reset_n),
        .pc_out(pc)
    );
    
    // Instruction Memory
    logic [31:0] instruction;
    instruction_memory IM (
        .pc(pc),
        .reset_n(reset_n),
        .instr(instruction)
    );
    
    // Control Unit
    logic RegWrite, MemWrite, ALUSrc, Branch, Jump, zero;
    logic [1:0] ResultSrc, ImmSrc;
    logic [2:0] ALUControl;
    
    control_unit CU (
        .instruction(instruction),
        .zero_flg(zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ImmSrc(ImmSrc),
        .ALUsrc(ALUSrc),
        .RegWrite(RegWrite),
        .Branch(Branch),
        .Jump(Jump)
    );
    
    // Immediate Generator
    immediate IMM (
        .ImmSrc(ImmSrc),
        .instruction(instruction),
        .immediate_extended(immediate_extended)
    );
    
    // Register File
    logic [31:0] rs1_data, rs2_data, write_data;
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr = instruction[11:7];
    
    register_file RF (
        .clk(clk),
        .reset_n(reset_n),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .write_data(write_data),
        .write_enable(RegWrite),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );
    
    // ALU
    logic [31:0] alu_operand2, alu_result;
    assign alu_operand2 = (ALUSrc) ? immediate_extended : rs2_data;
    
    alu ALU (
        .operand1(rs1_data),
        .operand2(alu_operand2),
        .alu_op(ALUControl),
        .result(alu_result),
        .zero(zero)
    );
    
    // PC Logic
    assign pc_next = (PCSrc) ? pc + immediate_extended : pc + 4;
    
endmodule
