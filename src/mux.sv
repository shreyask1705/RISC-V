module mux (
    input logic [31:0] operand1,
    input logic [31:0] operand2,
    input logic select,
    output logic [31:0] result
);

    always_comb begin
        if (select == 1'b0) begin
            result = operand1;
        end
        else begin
            result = operand2;
        end
    end
endmodule