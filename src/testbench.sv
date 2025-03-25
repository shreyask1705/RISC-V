module riscv_processor_tb;
    
    logic clk;
    logic reset_n;
    
    // Instantiate RISC-V Processor
    riscv_processor dut (
        .clk(clk),
        .reset_n(reset_n)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        // Initialize signals
        clk = 0;
        reset_n = 0;
        $dumpfile("waveforms.vcd");
        $dumpvars(0, riscv_processor_tb);  
        // Reset sequence
        #10 reset_n = 1;
        
        // Run for some cycles
        #200;
        
        // End simulation
        $stop;
    end
    
    // Monitor signals
    initial begin
        $monitor("Time=%0t, PC=%h", $time, dut.pc);
    end
    
endmodule
