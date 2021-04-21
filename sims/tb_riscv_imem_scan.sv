`timescale 1ns / 1ns

module tb_riscv_imem_scan();

logic clk, Rst, clk_out;
logic rx, tx;
logic scan_en, scan_in, scan_out, scan_clk;
logic miso, mosi, cs;

// Debug RISC-V Signals
logic debug = 0;
logic [4:0] debug_input = 5'b00000;
logic [7:0] sev_out;
logic [7:0] an;
logic [15:0] led;

rv_uart_top dut(.*); 

always #5 clk = !clk;
assign scan_clk = clk;

task scan_bits(input logic[31:0] word, integer bit_length);
    for (int i = 0; i < bit_length; i++) begin
        scan_in = word[i];
        @(posedge clk);
    end;
endtask

task scan_word(input logic[31:0] word);
    scan_bits(word, 32);
endtask

initial begin
    $display("Begin simulaton");
//    readfile("/home/gray/Projects/Mini-Risc-V-Uart-Srcs/gcc/test1.hex");
    clk = 0;
    Rst = 1;
    scan_en = 0;
    scan_in = 0;
    rx = 0;
    miso = 0;
    
    // Reset
    #50; Rst = 0;
    @(posedge clk);
    
    // Load IMEM
    scan_en = 1;
    scan_bits(1'b1, 1); // Set scanchain to store data
    scan_bits(32'hFFFF_FFFF, 32); // Tell scanchain to read in a lot of data
    scan_bits(32'h0000_0000, 32); // Tell scanchain to start at address 0
    scan_word(32'h00012117); // Scan data in
    scan_word(32'h04010113);
    scan_word(32'h00022517);
    scan_word(32'h03c50513);
    scan_word(32'h2f5000ef);
    scan_word(32'h00000097);
    scan_word(32'h00c08093);
    scan_word(32'h008000ef);
    
    // Execute instructions
    scan_en = 0; #9000;
    $display("End simulaton");
end

endmodule
