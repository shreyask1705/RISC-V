module control_unit (
    input   logic [31:0] instruction,     // Instruction input
    input   logic        zero_flg,
    output  logic        PCSrc,
    output  logic [1:0]  ResultSrc,
    output  logic        MemWrite,
    output  logic [2:0]  ALUControl,
    output  logic [1:0]  ImmSrc,
    output  logic        ALUsrc,
    output  logic        RegWrite, 
    output  logic        Branch,
    output  logic        Jump

);

    logic [6:0] opcode; 
    logic [2:0] funct3;
    logic [6:0] funct7;

    always_comb begin
        // Default values
        RegWrite = 0;
        ALUSrc = 0;
        ImmSrc = 0;
        ALUControl = 0;
        MemWrite = 0;
        ResultSrc = 0;
        PCSrc = zero_flg ^ Branch;
        Branch = 0;
        Jump = 0;
        //ALUOp = 3'b000;

        case (opcode)
            7'b0110011: begin // R-type (ADD, SUB, AND, OR, XOR)
                RegWrite = 1;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0;
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'b10;
                Branch = 0;
                Jump = 0;   
                ImmSrc = 0;
            end
            7'b0010011: begin // I-type (ADDI, ANDI, ORI, etc.)
                RegWrite = 1;
                ALUSrc = 1;
                MemWrite = 0;
                ResultSrc = 0;
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'b10;
                Branch = 0;
                Jump = 0;   
                ImmSrc = 2'b00; // Should be XX .... Figure out the Implementation
            end
            7'b0000011: begin // Load (LW)
                RegWrite = 1;
                ALUSrc = 1;
                MemWrite = 0;
                ResultSrc = 1;
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'b00;
                Branch = 0;
                Jump = 0;   
                ImmSrc = 2'b00;
            end
            7'b0100011: begin // Store (SW)
                RegWrite = 0;
                ALUSrc = 1;
                MemWrite = 1;
                ResultSrc = 0; // Should be XX..Figure out the Implementation
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'b10;
                Branch = 0;
                Jump = 0;   
                ImmSrc = 2'b01;
            end
            7'b1100011: begin // Branch (BEQ, BNE, etc.)
                RegWrite = 0;
                ALUSrc = 0;
                MemWrite = 0;
                ResultSrc = 0; // Should be XX..Figure out the Implementation
                PCSrc = 1;
                ALUOp = 2'b01;
                Branch = 1;
                Jump = 0;   
                ImmSrc = 2'b10;
            end
            7'b1101111: begin // Jump (JAL)
                RegWrite = 1;
                ALUSrc = 0; // Should be XX..Figure out the Implementation
                MemWrite = 0;
                ResultSrc = 2'b10;
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'b10; // Should be XX..Figure out the Implementation
                Branch = 0;
                Jump = 1;   
                ImmSrc = 2'b11;
            end
            default: ; // Default case, no operation
        endcase
    end
endmodule
