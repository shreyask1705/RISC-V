// Wrapper module for RISC-V processor

module wrapper (
    input wire clk,
    input wire reset,
    input wire [31:0] pc_in,
    input wire pc_write_enable,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [31:0] write_data,
    input wire write_enable,
    input wire [31:0] operand1,
    input wire [31:0] operand2,
    input wire [3:0] alu_op,
    output wire [31:0] pc_out,
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,
    output wire [31:0] result
);

    wire [31:0] alu_result;
    wire [31:0] pc_next;

    inst_fetch_unit inst_fetch_unit_inst (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_next)
    );

    program_counter program_counter_inst (
        .clk(clk),
        .pc_in(pc_next),
        .pc_write_enable(pc_write_enable),
        .pc_out(pc_out)
    );

    register_file register_file_inst (
        .clk(clk),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .write_data(write_data),
        .write_enable(write_enable),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    alu alu_inst (
        .operand1(operand1),
        .operand2(operand2),
        .alu_op(alu_op),
        .result(alu_result)
    );

    assign result = alu_result;
endmodule