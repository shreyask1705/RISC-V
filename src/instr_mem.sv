// Instruction Memory for RISC-V Processor

module instruction_memory (
    input  logic [31:0] pc,    
    input logic reset_n,       
    output logic [31:0] instr     
);

    logic [7:0] mem [0:31];  // Instruction memory (32 words of 8 bits each)

    initial begin
        $readmemh("sim/instructions.txt", mem);
    end
    assign instr = {mem[pc], mem[pc+1], mem[pc+2], mem[pc+3]};
    
endmodule
