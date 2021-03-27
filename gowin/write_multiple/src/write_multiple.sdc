//Copyright (C)2014-2021 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.7.01 Beta
//Created Time: 2021-03-26 23:01:02
create_clock -name main -period 41.667 -waveform {0 20.834} [get_ports {clk_24MHz}]

