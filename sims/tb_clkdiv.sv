`timescale 1ns / 1ns 
module tb_clkdiv ();

logic clk_100M, rst;
logic clk_50M, clk_25M, clk_17M, clk_12M, clk_115k;

always #5 clk_100M = ~clk_100M;

initial begin
    // Initialize
    clk_100M = 'b0;
    clk_50M = 'b0;
    clk_25M = 'b0;
    clk_17M = 'b0;
    clk_12M = 'b0;
    clk_115k = 'b0;
    rst = 'b0;
    repeat(5) @(posedge clk_100M);
    rst = 'b1;
    repeat(5) @(posedge clk_100M);
    rst = 'b0;
    
    // Wait for one full period
    #10000;
    $finish;
end

clk_div   #(2) cdiv50M (clk_100M,rst,clk_50M);  // 100 MHz -> 50 MHz
clk_div   #(4) cdiv25M (clk_100M,rst,clk_25M);  // 100 MHz -> 25 MHz
clk_div   #(6) cdiv17M (clk_100M,rst,clk_17M);  // 100 MHz -> 17 MHz
clk_div   #(8) cdiv12M (clk_100M,rst,clk_12M);  // 100 MHz -> 12.5 MHz
clk_div #(868) cdiv115k(clk_100M,rst,clk_115k); // 100 MHz -> 115200 kHz

endmodule
 


