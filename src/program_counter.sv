// Program counter for RISC-V processor

module program_counter (
    input wire clk,
    input wire [31:0] pc_in,
    input wire reset_n,
    output wire [31:0] pc_out,
    input wire PCSrc,
    input wire [31:0] immediate_extended,
    input wire [1:0] ImmSrc

);
    //`include "control_unit.sv"
    //`include "immediate.sv"
   
    reg [31:0] pc;

    always_ff@(posedge clk) begin
        if (!reset_n) begin
            pc <= 32'h00000000;
        end else begin   
            if (PCSrc == 1 && ImmSrc == 2'b10) begin
                pc <= pc + immediate_extended;  
            end else begin
                pc <= pc + 32'h00000004;
            end
        end
    end
    assign pc_out = pc;
    
endmodule
