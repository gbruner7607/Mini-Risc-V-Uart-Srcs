`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2020 05:59:57 PM
// Design Name: 
// Module Name: uart_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_controller(
    mmio_bus mbus
//    input logic clk, rst, rx, rx_ren, tx_wen,
//    input logic [7:0] din,
//    output logic tx, rx_data_present,
//    output logic [7:0] dout
    );
    
    logic clk, rst, rx, rx_ren, tx_wen;
    logic [7:0] din;
    logic tx, rx_data_present;
    logic [7:0] dout; 
//    logic uart_clk;
    
    always_comb begin
        clk = mbus.clk;
        rst = mbus.Rst; 
        rx = mbus.rx;
        rx_ren = mbus.rx_ren; 
        tx_wen = mbus.tx_wen; 
        din = mbus.uart_din;
//        uart_clk = mbus.uart_clk;
        mbus.tx = tx;
//        mbus.rx_data_present = rx_data_present;
        mbus.rx_data_present = ~rx_fifo_empty;
        mbus.tx_full = tx_fifo_full;
        mbus.uart_dout = dout;
    end
    
    
//    integer cnt = 26; 
    integer cnt = 81; 
//    integer cnt = 53; 
    integer baud_count = 0; 
    logic en_baud = 0;
//    integer sec = 100000000;
//    integer sec_cnt = 0; 
//    logic clk_1s = 0;
    
    logic [7:0] rx_dout; 
    logic rx_read, rx_pres, rx_half, rx_full; 
    
    logic [7:0] tx_din;
    logic tx_write, tx_pres, tx_half, tx_full; 
    
    logic rx_fifo_wen, rx_fifo_ren; 
    logic rx_fifo_full, rx_fifo_empty; 
    logic [7:0] rx_fifo_dout; 
    logic [9:0] rx_fifo_count; 
    
    logic tx_fifo_wen, tx_fifo_ren; 
    logic tx_fifo_full, tx_fifo_empty; 
    logic [7:0] tx_fifo_din; 
    
//    logic F8_empty, F8_full, F8_ren, F8_wen;
//    logic [31:0] F8_dout; 
    
//    logic F32_empty, F32_full, F32_ren, F32_wen;
//    logic [31:0] F32_din; 

//    assign rx_data_present = rx_pres;
    assign rx_read = rx_pres & ~rx_fifo_full;
//    assign rx_fifo_wen = rx_pres;
//    assign rx_fifo_ren = tx_wen & ~rx_fifo_empty;
    assign rx_fifo_ren = rx_ren;
    assign dout = rx_fifo_dout;

    uart_rx6 rx0( .serial_in(rx), .en_16_x_baud(en_baud), .data_out(rx_dout), .buffer_read(rx_read), .buffer_data_present(rx_pres), 
        .buffer_half_full(rx_half), .buffer_full(rx_full), .buffer_reset(rst), .clk(clk)); 
        
    fifo_generator_0 rxfifo( .clk(clk), .rst(rst), .din(rx_dout), .wr_en(rx_read), .rd_en(rx_fifo_ren), 
        .dout(rx_fifo_dout), .full(rx_fifo_full), .empty(rx_fifo_empty)); 

    uart_tx6 tx0( .data_in(tx_din), .en_16_x_baud(en_baud), .serial_out(tx), .buffer_write(tx_write), .buffer_data_present(tx_pres),
        .buffer_half_full(tx_half), .buffer_full(tx_full), .buffer_reset(rst), .clk(clk));
    
    fifo_generator_0 txfifo( .clk(clk), .rst(rst), .din(tx_fifo_din), .wr_en(tx_fifo_wen), .rd_en(tx_fifo_ren),
        .dout(tx_din), .full(tx_fifo_full), .empty(tx_fifo_empty)); 
//    assign led_out = rx_fifo_dout; 
//    assign led_out = rx_fifo_dout;
//    assign tx_din = rx_fifo_dout;
//    assign tx_write = tx_wen; 
    assign tx_fifo_wen = tx_wen;
    assign tx_write = ~tx_fifo_empty & ~tx_full;
    assign tx_fifo_ren = tx_write;
    assign tx_fifo_din = din;
//    always_ff @(posedge clk) begin
//        if (rst) begin
            
//        end else begin
////            tx_write <= rx_fifo_ren; 
////            if (rx_read == 1) begin
////                rx_read <= 0;
////                tx_write <= 0;
////            end else if (rx_read == 0 && rx_pres == 1) begin
////                rx_read <= 1;
////                tx_write <= 1;
////                tx_din <= rx_dout;
////                led_out <= rx_dout;
////            end
////            if ((rx_pres == 1) && (rx_fifo_full == 0)) begin
////                rx_read <= 1; 
////                rx_fifo_wen <= 1;
////            end
////            else begin
////                rx_read <= 0;
////                rx_fifo_wen <= 0; 
////            end
//        end
//    end
    
    
    always_ff @(posedge clk) begin
        if (baud_count == cnt) begin
            baud_count <= 0;
            en_baud <= 1;
        end else begin
            baud_count <= baud_count + 1; 
            en_baud <= 0;
        end
    end
    
endmodule
