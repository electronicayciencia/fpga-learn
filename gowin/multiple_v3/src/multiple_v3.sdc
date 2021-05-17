//Copyright (C)2014-2021 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.7.01 Beta
//Created Time: 2021-03-28 23:08:11
create_clock -name i_clk -period 41.667 -waveform {0 20.834} [get_ports {i_clk}]
create_clock -name debug_clk -period 41.667 -waveform {0 20.834} [get_ports {o_debug[6]}]
