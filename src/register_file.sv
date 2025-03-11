// Register file for the RISC-V processor

module register_file (
    input logic clk,
    input logic reset_n,
    input logic[4:0] rs1_addr,
    input logic[4:0] rs2_addr,
    input logic[4:0] rd_addr,
    input logic[31:0] write_data,
    input logic write_enable,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

    reg [31:0] registers [31:0];

    assign rs1_data = registers[rs1_addr];
    assign rs2_data = registers[rs2_addr];

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            registers[0] <= 32'b0;
            registers[1] <= 32'h1;
            registers[2] <= 32'h2;
            registers[3] <= 32'h3;
            registers[4] <= 32'h4;
            registers[5] <= 32'h5;
            registers[6] <= 32'h6;
            registers[7] <= 32'h7;
            registers[8] <= 32'h8;
            registers[9] <= 32'h9;
            registers[11] <= 32'h11;
            registers[10] <= 32'h10;
            registers[12] <= 32'h12;
            registers[13] <= 32'h13;
            registers[14] <= 32'h14;
            registers[15] <= 32'h15;
            registers[16] <= 32'h16;
            registers[17] <= 32'h17;
            registers[18] <= 32'h18;
            registers[19] <= 32'h19;
            registers[20] <= 32'h20;
            registers[21] <= 32'h21;
            registers[22] <= 32'h22;
            registers[23] <= 32'h23;
            registers[24] <= 32'h24;
            registers[25] <= 32'h25;
            registers[26] <= 32'h26;
            registers[27] <= 32'h27;
            registers[28] <= 32'h28;
            registers[29] <= 32'h29;
            registers[30] <= 32'h30;
            registers[31] <= 32'h31;
        end else begin
            if (write_enable) begin
                registers[rd_addr] <= write_data;
            end else begin
                registers[rd_addr] <= registers[rd_addr];
            end
        end
    end
endmodule