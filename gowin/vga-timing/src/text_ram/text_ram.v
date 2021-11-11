//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8
//Part Number: GW1N-LV1QN48C6/I5
//Device: GW1N-1
//Created Time: Thu Nov 11 17:13:49 2021

module text_ram (dout, clka, cea, reseta, clkb, ceb, resetb, oce, ada, din, adb);

output [15:0] dout;
input clka;
input cea;
input reseta;
input clkb;
input ceb;
input resetb;
input oce;
input [9:0] ada;
input [15:0] din;
input [9:0] adb;

wire [15:0] sdpb_inst_0_dout_w;
wire gw_vcc;
wire gw_gnd;

assign gw_vcc = 1'b1;
assign gw_gnd = 1'b0;

SDPB sdpb_inst_0 (
    .DO({sdpb_inst_0_dout_w[15:0],dout[15:0]}),
    .CLKA(clka),
    .CEA(cea),
    .RESETA(reseta),
    .CLKB(clkb),
    .CEB(ceb),
    .RESETB(resetb),
    .OCE(oce),
    .BLKSELA({gw_gnd,gw_gnd,gw_gnd}),
    .BLKSELB({gw_gnd,gw_gnd,gw_gnd}),
    .ADA({ada[9:0],gw_gnd,gw_gnd,gw_vcc,gw_vcc}),
    .DI({gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,gw_gnd,din[15:0]}),
    .ADB({adb[9:0],gw_gnd,gw_gnd,gw_gnd,gw_gnd})
);

defparam sdpb_inst_0.READ_MODE = 1'b0;
defparam sdpb_inst_0.BIT_WIDTH_0 = 16;
defparam sdpb_inst_0.BIT_WIDTH_1 = 16;
defparam sdpb_inst_0.BLK_SEL_0 = 3'b000;
defparam sdpb_inst_0.BLK_SEL_1 = 3'b000;
defparam sdpb_inst_0.RESET_MODE = "SYNC";
defparam sdpb_inst_0.INIT_RAM_00 = 256'h01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01C9;
defparam sdpb_inst_0.INIT_RAM_01 = 256'h0700070001BB01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD;
defparam sdpb_inst_0.INIT_RAM_02 = 256'h0220022002200232023702320278023002380234022002440243024C022001BA;
defparam sdpb_inst_0.INIT_RAM_03 = 256'h0700070001BA0220023702310278023002330220027402780265025402200220;
defparam sdpb_inst_0.INIT_RAM_04 = 256'h07200720072007200720072007200720072007200720072007200720072001BA;
defparam sdpb_inst_0.INIT_RAM_05 = 256'h0700070001BA0720072007200720072007200720072007200720072007200720;
defparam sdpb_inst_0.INIT_RAM_06 = 256'h0F430F420F410F390F380F370F360F350F340F330F320F310F300720072001BA;
defparam sdpb_inst_0.INIT_RAM_07 = 256'h0700070001BA072007200F720F6F0F6C0F6F0F430720072007200F460F450F44;
defparam sdpb_inst_0.INIT_RAM_08 = 256'h070C070B070A07090708070707060705070407030702070107000F30072001BA;
defparam sdpb_inst_0.INIT_RAM_09 = 256'h0700070001BA072008DB08DB08DB00DB00DB00DB0F3007200720070F070E070D;
defparam sdpb_inst_0.INIT_RAM_0A = 256'h071C071B071A07190718071707160715071407130712071107100F31072001BA;
defparam sdpb_inst_0.INIT_RAM_0B = 256'h0700070001BA072009DB09DB09DB01DB01DB01DB0F3107200720071F071E071D;
defparam sdpb_inst_0.INIT_RAM_0C = 256'h072C072B072A07290728072707260725072407230722072107200F32072001BA;
defparam sdpb_inst_0.INIT_RAM_0D = 256'h0700070001BA07200ADB0ADB0ADB02DB02DB02DB0F3207200720072F072E072D;
defparam sdpb_inst_0.INIT_RAM_0E = 256'h073C073B073A07390738073707360735073407330732073107300F33072001BA;
defparam sdpb_inst_0.INIT_RAM_0F = 256'h0700070001BA07200BDB0BDB0BDB03DB03DB03DB0F3307200720073F073E073D;
defparam sdpb_inst_0.INIT_RAM_10 = 256'h074C074B074A07490748074707460745074407430742074107400F34072001BA;
defparam sdpb_inst_0.INIT_RAM_11 = 256'h0700070001BA07200CDB0CDB0CDB04DB04DB04DB0F3407200720074F074E074D;
defparam sdpb_inst_0.INIT_RAM_12 = 256'h075C075B075A07590758075707560755075407530752075107500F35072001BA;
defparam sdpb_inst_0.INIT_RAM_13 = 256'h0700070001BA07200DDB0DDB0DDB05DB05DB05DB0F3507200720075F075E075D;
defparam sdpb_inst_0.INIT_RAM_14 = 256'h076C076B076A07690768076707660765076407630762076107600F36072001BA;
defparam sdpb_inst_0.INIT_RAM_15 = 256'h0700070001BA07200EDB0EDB0EDB06DB06DB06DB0F3607200720076F076E076D;
defparam sdpb_inst_0.INIT_RAM_16 = 256'h077C077B077A07790778077707760775077407730772077107700F37072001BA;
defparam sdpb_inst_0.INIT_RAM_17 = 256'h0700070001BA07200FDB0FDB0FDB07DB07DB07DB0F3707200720077F077E077D;
defparam sdpb_inst_0.INIT_RAM_18 = 256'h01C401C401C401C401C401C401C401C401C401C401C401C401C401C401C401C7;
defparam sdpb_inst_0.INIT_RAM_19 = 256'h0700070001B601C401C401C401C401C401C401C401C401C401C401C401C401C4;
defparam sdpb_inst_0.INIT_RAM_1A = 256'h032003790320036103630369036E03A20372037403630365036C0345032001BA;
defparam sdpb_inst_0.INIT_RAM_1B = 256'h0700070001BA032003200320032003200320036103690363036E036503690363;
defparam sdpb_inst_0.INIT_RAM_1C = 256'h03200320032003200320032003200320032003200320032003200320032001BA;
defparam sdpb_inst_0.INIT_RAM_1D = 256'h0700070001BA0320032003200320032003200320032003200320032003200320;
defparam sdpb_inst_0.INIT_RAM_1E = 256'h03200320032003200320032003200320032003200320032003200320032001BA;
defparam sdpb_inst_0.INIT_RAM_1F = 256'h0700070001BA0331033203300332032F03310331032F03320331032003200320;
defparam sdpb_inst_0.INIT_RAM_20 = 256'h01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01C8;
defparam sdpb_inst_0.INIT_RAM_21 = 256'h0700070001BC01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD01CD;
defparam sdpb_inst_0.INIT_RAM_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam sdpb_inst_0.INIT_RAM_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

endmodule //text_ram
