//Copyright (C)2014-2021 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.7.01 Beta
//Created Time: 2021-03-28 23:08:11
create_clock -name clk_i -period 41.667 -waveform {0 20.834} [get_ports {clk_i}]
create_clock -name debug_clk -period 41.667 -waveform {0 20.834} [get_ports {debug[6]}]
