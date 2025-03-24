// Arithmetic Logic Unit for RISC-V Processor

module alu (
    input logic [31:0] operand1,
    input logic [31:0] operand2,
    input logic [2:0] alu_op,
    output logic [31:0] result,
    output logic zero

);
    reg [31:0] result_reg;
    always_comb begin
        result_reg = 0;
        zero = 0;
        case (alu_op)
            3'b000: result_reg = operand1 + operand2; // ADD
            3'b001: result_reg = operand1 - operand2; // SUB
            3'b010: result_reg = operand1 & operand2; // AND
            3'b011: result_reg = operand1 | operand2; // OR
            3'b100: result_reg = operand1 ^ operand2; // XOR
            3'b101: result_reg = (operand1 < operand2) ? 32'b1 : 32'b0; // SLT
            3'b110: result_reg = (operand1 > operand2) ? 32'b1 : 32'b0; // SGT
            3'b111: zero = (operand1 == operand2) ? 1'b1 : 1'b0; // BEQ
            default: result_reg = 32'b0;
        endcase
    end
    
    
    assign result = result_reg;
endmodule