//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//GOWIN Version: V1.9.8
//Part Number: GW1N-LV1QN48C6/I5
//Device: GW1N-1
//Created Time: Thu Nov 11 17:13:49 2021

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

    text_ram your_instance_name(
        .dout(dout_o), //output [15:0] dout
        .clka(clka_i), //input clka
        .cea(cea_i), //input cea
        .reseta(reseta_i), //input reseta
        .clkb(clkb_i), //input clkb
        .ceb(ceb_i), //input ceb
        .resetb(resetb_i), //input resetb
        .oce(oce_i), //input oce
        .ada(ada_i), //input [9:0] ada
        .din(din_i), //input [15:0] din
        .adb(adb_i) //input [9:0] adb
    );

//--------Copy end-------------------
