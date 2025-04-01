//Data memory Module for the processor

module data_mem(
    input clk,
    input reset_n,
    input [31:0] addr,
    input [31:0] write_data,
    input write_enable,
    output [31:0] read_data
);

    logic [31:0] memory [0:1023];

    assign read_data = memory[addr];

    always_ff @ (posedge clk) begin
        if(!reset_n) begin
           $readmemh("C:/Users/shrey/OneDrive/Documents/Projects/RISC-V/sim/data_mem.txt", memory); // Load memory contents from file
        end else begin
            if(write_enable) begin
                memory[addr] <= write_data;
            end
        end
    end

endmodule