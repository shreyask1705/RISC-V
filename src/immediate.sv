module immediate (
    input logic [1:0] ImmSrc,
    input logic [31:0] instruction,
    output logic [31:0] immediate_extended
);
    //reg signed [20:0]  immediate_reg;
    reg [31:0] immediate_extended_reg;
    always_comb begin : immediate_comb
        case (ImmSrc) 
            2'b00 : begin // I-type
                immediate_extended_reg = {{20{instruction[31]}}, instruction[31:20]};
            end
            2'b01 : begin // Store 
                immediate_extended_reg = {{20{instruction[31]}},instruction[31:25], instruction[11:7]};
            end
            2'b10 : begin // Branch
                immediate_extended_reg = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end
            2'b11 : begin // Jump
                immediate_extended_reg = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
            end
            default : begin 
                immediate_extended_reg = 32'bX;
            end
        endcase
    end
    assign immediate_extended = immediate_extended_reg;
endmodule
