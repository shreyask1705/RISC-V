// Arithmetic Logic Unit for RISC-V Processor

module alu (
    input logic [31:0] operand1,
    input logic [31:0] operand2,
    input logic [2:0] alu_op,
    output logic [31:0] result,
    output logic zero

);
    reg [31:0] result_reg;
    always_comb
        case (alu_op)
            3'b000: result_reg = operand1 + operand2; zero = 1'b0;// ADD
            3'b001: result_reg = operand1 - operand2; zero = 1'b0;// SUB
            3'b010: result_reg = operand1 & operand2; zero = 1'b0;// AND
            3'b011: result_reg = operand1 | operand2; zero = 1'b0;// OR
            3'b100: result_reg = operand1 ^ operand2; zero = 1'b0;// XOR
            3'b101: result_reg = operand1 < operand2; zero = 1'b0;// SLT
            3'b110: result_reg = operand1 > operand2; zero = 1'b0;// SGT
            3'b111: result_reg = operand1 == operand2;zero = 1'b1; // BEQ
           
            default: result_reg = 0; zero = 1'b0;   
        endcase
    
    assign result = result_reg;
endmodule