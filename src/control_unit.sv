module control_unit (
    input   logic [31:0] instruction,     // Instruction input
    input   logic        zero_flg,
    output  logic        PCSrc,
    output  logic [1:0]  ResultSrc,
    output  logic        MemWrite,
    output  logic [2:0]  ALUControl,
    output  logic [1:0]  ImmSrc,
    output  logic        ALUSrc,
    output  logic        RegWrite, 
    output  logic        Branch,
    output  logic        Jump

);
    // Internal Registers and Wires

    logic [6:0] opcode; 
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [1:0] ALUOp;

    always_comb begin
        opcode = instruction[6:0];
        funct3 = instruction[14:12];
        funct7 = instruction[31:25];
    end

    always_comb begin
        // Default values
        RegWrite = 0;
        ALUSrc = 0;
        ImmSrc = 0;
        //ALUControl = 0;
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
                ImmSrc = 2'bXX; // Should be XX .... Figure out the Implementation
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
                ResultSrc = 1'bX; // Should be XX..Figure out the Implementation
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
                ResultSrc = 1'bX; // Should be XX..Figure out the Implementation
                PCSrc = 1;
                ALUOp = 2'b01;
                Branch = 1;
                Jump = 0;   
                ImmSrc = 2'b10;
            end
            7'b1101111: begin // Jump (JAL)
                RegWrite = 1;
                ALUSrc = 1'bX; // Should be XX..Figure out the Implementation
                MemWrite = 0;
                ResultSrc = 2'b10;
                PCSrc = zero_flg ^ Branch;
                ALUOp = 2'bXX; // Should be XX..Figure out the Implementation
                Branch = 0;
                Jump = 1;   
                ImmSrc = 2'b11;
            end
            default: ; // Default case, no operation
        endcase
    end
    
    always_comb begin
       

        case (ALUOp)
            2'b00: begin
                ALUControl = 3'b000; // ADD
            end
            2'b01: begin
                ALUControl = 3'b001; // SUB
            end
            default : begin
                // if (funct3 == 3'b000 && (funct7[6:5] == 2'b00 || funct7[6:5] == 2'b01 || funct7[6:5] == 2'b10)) begin
                //     ALUControl = 3'b000; // ADD
                // end else if (func3 == 3'b000 && funct7[6:5] == 2'b11) begin
                //     ALUControl = 3'b001; // SUB
                // end else if (func3 == 3'b010) begin
                //     ALUControl = 3'b101; // SLT
                // end else if (func3 == 3'b110) begin
                //     ALUControl = 3'b011; // OR
                // end else if (func3 == 3'b111) begin
                //     ALUControl = 3'b010 // AND
                // end else begin
                //     ALUControl = 3'b000; // ADD
                // end
                case (funct3) 
                    3'b000: begin
                        if (funct7[6:5] == 2'b00 || funct7[6:5] == 2'b01 || funct7[6:5] == 2'b10) begin
                            ALUControl = 3'b000; // ADD
                        end else if (funct7[6:5] == 2'b11) begin
                            ALUControl = 3'b001; // SUB
                        end
                    end
                    3'b010: begin
                        ALUControl = 3'b101; // SLT
                    end
                    3'b110: begin
                        ALUControl = 3'b011; // OR
                    end
                    3'b111: begin
                        ALUControl = 3'b010; // AND
                    end
                    default: begin
                        ALUControl = 3'b000; // ADD
                    end
                endcase
            end

        endcase
    end

endmodule
