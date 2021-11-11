//Copyright (C)2014-2021 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//GOWIN Version: V1.9.8
//Part Number: GW1N-LV1QN48C6/I5
//Device: GW1N-1
//Created Time: Thu Nov 11 18:08:00 2021

module chr_rom (dout, clk, oce, ce, reset, ad);

output [7:0] dout;
input clk;
input oce;
input ce;
input reset;
input [10:0] ad;

wire [23:0] prom_inst_0_dout_w;
wire gw_gnd;

assign gw_gnd = 1'b0;

pROM prom_inst_0 (
    .DO({prom_inst_0_dout_w[23:0],dout[7:0]}),
    .CLK(clk),
    .OCE(oce),
    .CE(ce),
    .RESET(reset),
    .AD({ad[10:0],gw_gnd,gw_gnd,gw_gnd})
);

defparam prom_inst_0.READ_MODE = 1'b0;
defparam prom_inst_0.BIT_WIDTH = 8;
defparam prom_inst_0.RESET_MODE = "SYNC";
defparam prom_inst_0.INIT_RAM_00 = 256'h0010387CFEFEFE6C7EFFE7C3FFDBFF7E7E8199BD81A5817E0000000000000000;
defparam prom_inst_0.INIT_RAM_01 = 256'h0000183C3C1800007C387CFE7C3810107C387CFEFE387C380010387CFE7C3810;
defparam prom_inst_0.INIT_RAM_02 = 256'h78CCCCCC7D0F070FFFC399BDBD99C3FF003C664242663C00FFFFE7C3C3E7FFFF;
defparam prom_inst_0.INIT_RAM_03 = 256'h995A3CE7E73C5A99C0E66763637F637FE0F07030303F333F187E183C6666663C;
defparam prom_inst_0.INIT_RAM_04 = 256'h0066006666666666183C7E18187E3C1800020E3EFE3E0E020080E0F8FEF8E080;
defparam prom_inst_0.INIT_RAM_05 = 256'hFF183C7E187E3C18007E7E7E0000000078CC386C6C38633E001B1B1B7BDBDB7F;
defparam prom_inst_0.INIT_RAM_06 = 256'h00003060FE6030000000180CFE0C180000183C7E1818181800181818187E3C18;
defparam prom_inst_0.INIT_RAM_07 = 256'h0000183C7EFFFF000000FFFF7E3C180000002466FF6624000000FEC0C0C00000;
defparam prom_inst_0.INIT_RAM_08 = 256'h006C6CFE6CFE6C6C00000000006C6C6C00300030307878300000000000000000;
defparam prom_inst_0.INIT_RAM_09 = 256'h0000000000C060600076CCDC76386C3800C6663018CCC6000030F80C78C07C30;
defparam prom_inst_0.INIT_RAM_0A = 256'h00003030FC3030000000663CFF3C660000603018181830600018306060603018;
defparam prom_inst_0.INIT_RAM_0B = 256'h0080C06030180C06003030000000000000000000FC0000006030300000000000;
defparam prom_inst_0.INIT_RAM_0C = 256'h0078CC0C380CCC7800FCCC60380CCC7800FC303030307030007CE6F6DECEC67C;
defparam prom_inst_0.INIT_RAM_0D = 256'h00303030180CCCFC0078CCCCF8C060380078CC0C0CF8C0FC001E0CFECC6C3C1C;
defparam prom_inst_0.INIT_RAM_0E = 256'h603030000030300000303000003030000070180C7CCCCC780078CCCC78CCCC78;
defparam prom_inst_0.INIT_RAM_0F = 256'h00300030180CCC78006030180C1830600000FC0000FC000000183060C0603018;
defparam prom_inst_0.INIT_RAM_10 = 256'h003C66C0C0C0663C00FC66667C6666FC00CCCCFCCCCC78300078C0DEDEDEC67C;
defparam prom_inst_0.INIT_RAM_11 = 256'h003E66CEC0C0663C00F06068786862FE00FE6268786862FE00F86C6666666CF8;
defparam prom_inst_0.INIT_RAM_12 = 256'h00E6666C786C66E60078CCCC0C0C0C1E007830303030307800CCCCCCFCCCCCCC;
defparam prom_inst_0.INIT_RAM_13 = 256'h00386CC6C6C66C3800C6C6CEDEF6E6C600C6C6D6FEFEEEC600FE6662606060F0;
defparam prom_inst_0.INIT_RAM_14 = 256'h0078CC1C70E0CC7800E6666C7C6666FC001C78DCCCCCCC7800F060607C6666FC;
defparam prom_inst_0.INIT_RAM_15 = 256'h00C6EEFED6C6C6C6003078CCCCCCCCCC00FCCCCCCCCCCCCC007830303030B4FC;
defparam prom_inst_0.INIT_RAM_16 = 256'h007860606060607800FE6632188CC6FE0078303078CCCCCC00C66C38386CC6C6;
defparam prom_inst_0.INIT_RAM_17 = 256'hFF0000000000000000000000C66C381000781818181818780002060C183060C0;
defparam prom_inst_0.INIT_RAM_18 = 256'h0078CCC0CC78000000DC66667C6060E00076CC7C0C7800000000000000183030;
defparam prom_inst_0.INIT_RAM_19 = 256'hF80C7CCCCC76000000F06060F0606C380078C0FCCC7800000076CCCC7C0C0C1C;
defparam prom_inst_0.INIT_RAM_1A = 256'h00E66C786C6660E078CCCC0C0C0C000C007830303070003000E66666766C60E0;
defparam prom_inst_0.INIT_RAM_1B = 256'h0078CCCCCC78000000CCCCCCCCF8000000C6D6FEFECC00000078303030303070;
defparam prom_inst_0.INIT_RAM_1C = 256'h00F80C78C07C000000F0606676DC00001E0C7CCCCC760000F0607C6666DC0000;
defparam prom_inst_0.INIT_RAM_1D = 256'h006CFEFED6C60000003078CCCCCC00000076CCCCCCCC000000183430307C3010;
defparam prom_inst_0.INIT_RAM_1E = 256'h001C3030E030301C00FC643098FC0000F80C7CCCCCCC000000C66C386CC60000;
defparam prom_inst_0.INIT_RAM_1F = 256'h00FEC6C66C381000000000000000DC7600E030301C3030E00018181800181818;
defparam prom_inst_0.INIT_RAM_20 = 256'h003F663E063CC37E0078C0FCCC78001C007ECCCCCC00CC00780C1878CCC0CC78;
defparam prom_inst_0.INIT_RAM_21 = 256'h380C78C0C0780000007ECC7C0C783030007ECC7C0C7800E0007ECC7C0C7800CC;
defparam prom_inst_0.INIT_RAM_22 = 256'h00783030307000CC0078C0FCCC7800E00078C0FCCC7800CC003C607E663CC37E;
defparam prom_inst_0.INIT_RAM_23 = 256'h00CCFCCC7800303000C6C6FEC66C38C600783030307000E0003C18181838C67C;
defparam prom_inst_0.INIT_RAM_24 = 256'h0078CCCC7800CC7800CECCCCFECC6C3E007FCC7F0C7F000000FC607860FC001C;
defparam prom_inst_0.INIT_RAM_25 = 256'h007ECCCCCC00E000007ECCCCCC00CC780078CCCC7800E0000078CCCC7800CC00;
defparam prom_inst_0.INIT_RAM_26 = 256'h18187EC0C07E18180078CCCCCCCC00CC00183C66663C18C3F80C7CCCCC00CC00;
defparam prom_inst_0.INIT_RAM_27 = 256'h70D818183C181B0EC7C6CFC6FACCCCF83030FC30FC78CCCC00FCE660F0646C38;
defparam prom_inst_0.INIT_RAM_28 = 256'h007ECCCCCC001C000078CCCC78001C000078303030700038007ECC7C0C78001C;
defparam prom_inst_0.INIT_RAM_29 = 256'h00007C00386C6C3800007E003E6C6C3C00CCDCFCECCC00FC00CCCCCCF800F800;
defparam prom_inst_0.INIT_RAM_2A = 256'h0FCC6633DECCC6C300000C0CFC0000000000C0C0FC0000000078CCC060300030;
defparam prom_inst_0.INIT_RAM_2B = 256'h0000CC663366CC0000003366CC663300001818181800181803CF6F37DBCCC6C3;
defparam prom_inst_0.INIT_RAM_2C = 256'h1818181818181818EEDB77DBEEDB77DBAA55AA55AA55AA558822882288228822;
defparam prom_inst_0.INIT_RAM_2D = 256'h363636FE00000000363636F636363636181818F818F81818181818F818181818;
defparam prom_inst_0.INIT_RAM_2E = 256'h363636F606FE00003636363636363636363636F606F63636181818F818F80000;
defparam prom_inst_0.INIT_RAM_2F = 256'h181818F800000000000000F818F81818000000FE36363636000000FE06F63636;
defparam prom_inst_0.INIT_RAM_30 = 256'h1818181F18181818181818FF00000000000000FF181818180000001F18181818;
defparam prom_inst_0.INIT_RAM_31 = 256'h36363637363636361818181F181F1818181818FF18181818000000FF00000000;
defparam prom_inst_0.INIT_RAM_32 = 256'h363636F700FF0000000000FF00F7363636363637303F00000000003F30373636;
defparam prom_inst_0.INIT_RAM_33 = 256'h000000FF00FF1818363636F700F73636000000FF00FF00003636363730373636;
defparam prom_inst_0.INIT_RAM_34 = 256'h0000003F36363636363636FF00000000181818FF00FF0000000000FF36363636;
defparam prom_inst_0.INIT_RAM_35 = 256'h363636FF363636363636363F000000001818181F181F00000000001F181F1818;
defparam prom_inst_0.INIT_RAM_36 = 256'hFFFFFFFFFFFFFFFF1818181F00000000000000F818181818181818FF18FF1818;
defparam prom_inst_0.INIT_RAM_37 = 256'h00000000FFFFFFFF0F0F0F0F0F0F0F0FF0F0F0F0F0F0F0F0FFFFFFFF00000000;
defparam prom_inst_0.INIT_RAM_38 = 256'h006C6C6C6C6CFE0000C0C0C0C0CCFC00C0C0F8CCF8CC78000076DCC8DC760000;
defparam prom_inst_0.INIT_RAM_39 = 256'h0018181818DC7600C0607C66666666000070D8D8D87E000000FCCC603060CCFC;
defparam prom_inst_0.INIT_RAM_3A = 256'h0078CCCC7C18301C00EE6C6CC6C66C3800386CC6FEC66C38FC3078CCCC7830FC;
defparam prom_inst_0.INIT_RAM_3B = 256'h00CCCCCCCCCCCC78003860C0F8C06038C0607EDBDB7E0C0600007EDBDB7E0000;
defparam prom_inst_0.INIT_RAM_3C = 256'h00FC00183060301800FC00603018306000FC003030FC30300000FC00FC00FC00;
defparam prom_inst_0.INIT_RAM_3D = 256'h0000DC7600DC760000303000FC00303070D8D8181818181818181818181B1B0E;
defparam prom_inst_0.INIT_RAM_3E = 256'h1C3C6CEC0C0C0C0F0000001800000000000000181800000000000000386C6C38;
defparam prom_inst_0.INIT_RAM_3F = 256'h000000000000000000003C3C3C3C000000000078603018700000006C6C6C6C78;

endmodule //chr_rom
