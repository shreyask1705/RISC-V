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
            memory[0] <= 32'b0;
            memory[1] <= 32'h1;
            memory[2] <= 32'h2;
            memory[3] <= 32'h3;
            memory[4] <= 32'h4;
            memory[5] <= 32'h5; 
            memory[6] <= 32'h6;
            memory[7] <= 32'h7; 
            memory[8] <= 32'h8;
            memory[9] <= 32'h9;
            memory[10] <= 32'h10;
            memory[11] <= 32'h11;
            memory[12] <= 32'h12;
            memory[13] <= 32'h13;
            memory[14] <= 32'h14;
            memory[15] <= 32'h15;
            memory[16] <= 32'h16;
            memory[17] <= 32'h17;
            memory[18] <= 32'h18;
            memory[19] <= 32'h19;
            memory[20] <= 32'h20;
            memory[21] <= 32'h21;
            memory[22] <= 32'h22;
            memory[23] <= 32'h23;
            memory[24] <= 32'h24;
            memory[25] <= 32'h25;
            memory[26] <= 32'h26;
            memory[27] <= 32'h27;
            memory[28] <= 32'h28;
            memory[29] <= 32'h29;
            memory[30] <= 32'h30;
            memory[31] <= 32'h31;
        end else begin
            if(write_enable) begin
                memory[addr] <= write_data;
            end
        end
    end

endmodule