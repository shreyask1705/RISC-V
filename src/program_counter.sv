// Program counter for RISC-V processor

module program_counter (
    input wire clk,
    input wire [31:0] pc_in,
    //input wire reset_n,
    output wire [31:0] pc_out
);
    `include "control_unit.sv"
    `include "immediate.sv"
    reg [31:0] pc;

    always_ff@(posedge clk) begin
        if (PCSrc == 0) begin
            pc <= pc + 32'h00000004;
        end else begin
            // Add PCTarget logic here 
            if (ImmSrc == 2'b10) begin
                pc <= pc + immediate_extended;
            end else begin
                pc <= pc;
            end
        end
    end
    assign pc_out = pc;
    
endmodule