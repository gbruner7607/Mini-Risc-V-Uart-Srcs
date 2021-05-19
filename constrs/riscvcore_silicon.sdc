# Based off https://www.xilinx.com/support/answers/62488.html

## Input Clocks
# Master Clock (50MHz, 20ns)
create_clock -period 20.000 -name clk_master \
    -waveform {0.000 10.000} -add [get_ports clk]
# Scan-chain Clock (1MHz, 1000ns)
create_clock -period 1000.000 -name clk_scanchain \
    -waveform {0.000 500.000} -add [get_ports scan_clk]

## Generated Clocks (via Dividers)
# RISC-V Internal Clock (50 MHz, 20ns)
#create_generated_clock -name clk_riscv \
#    -source [get_ports clk] \
#	-divide_by 2 [get_pins clk_50M]
# SPI Clock (12.5 MHz, 80ns)
create_generated_clock -name clk_spi \
    -source [get_ports clk] \
	-divide_by 4 [get_pins cdiv12M/clk_out]
# UART Clock (115200 Hz, 8680ns)
create_generated_clock -name clk_uart \
    -source [get_ports clk] \
	-divide_by 434 [get_pins cdiv115k/clk_out]
