# Based off https://www.xilinx.com/support/answers/62488.html

## Input Clocks
# Master Clock (25MHz, 40ns)
create_clock -period 40.000 -name clk \
    -waveform {0.000 20.000} -add [get_ports clk]
# Scan-chain Clock (1MHz, 1000ns)
create_clock -period 1000.000 -name clk_scanchain \
    -waveform {0.000 500.000} -add [get_ports scan_clk]

## Generated Clocks (via Dividers)
# SPI Clock (12.5 MHz, 80ns)
create_generated_clock -name clk_spi \
    -source [get_ports clk] \
	-divide_by 2 [get_pins cdiv_spi/clk_out]
# UART Clock
#   Ideal:  115200 Hz, 8680ns
#   Actual: 115207 Hz, 8680ns
# 25MHz/115200Hz = 217.013888 ~= 217 => 115207.4 Hz
create_generated_clock -name clk_uart \
    -source [get_ports clk] \
	-divide_by 217 [get_pins cdiv_uart/clk_out]
	

# Fan-in & Fan-out Constraints
set_max_fanout 5.0 [get_pins * -filter "@pin_direction == out"]
