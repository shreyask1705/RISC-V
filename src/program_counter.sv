// Program counter for RISC-V processor

module program_counter (
    input wire clk,
    input wire reset_n,
    input wire [31:0] pc_in,
    output wire [31:0] pc_out
    // input wire PCSrc,
    // input wire [31:0] immediate_extended,
    // input wire [1:0] ImmSrc

);
    //`include "control_unit.sv"
    //`include "immediate.sv"
   
    reg [31:0] pc;

    always_ff@(posedge clk) begin
        if (!reset_n) begin
            pc <= 32'h00000000;
        end else begin   
            pc <= pc_in;
        end
    end
    assign pc_out = pc;
    
endmodule
