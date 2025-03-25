// Instruction Memory for RISC-V Processor

module instruction_memory (
    input  wire [31:0] pc,    
    input wire reset_n,       
    output wire [31:0] instr     
);

    logic [31:0] mem [0:63];  // Instruction memory (32 words of 8 bits each)

    initial begin
        $readmemh("C:/Users/shrey/OneDrive/Documents/Projects/RISC-V/sim/instructions.txt", mem);
    end
    assign instr = {mem[pc], mem[pc+1], mem[pc+2], mem[pc+3]};
    
endmodule
