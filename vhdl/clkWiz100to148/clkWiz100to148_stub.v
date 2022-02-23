// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Dec 23 11:04:53 2020
// Host        : DESKTOP-6OPE0VQ running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Eva
//               Bizilj/VivadoProjekti/VGA/VGA.srcs/sources_1/ip/clkWiz100to148/clkWiz100to148_stub.v}
// Design      : clkWiz100to148
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clkWiz100to148(clk_148, clk_100, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_148,clk_100,reset,locked,clk_in1" */;
  output clk_148;
  output clk_100;
  input reset;
  output locked;
  input clk_in1;
endmodule
