-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Wed Dec 23 11:04:53 2020
-- Host        : DESKTOP-6OPE0VQ running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/Eva
--               Bizilj/VivadoProjekti/VGA/VGA.srcs/sources_1/ip/clkWiz100to148/clkWiz100to148_stub.vhdl}
-- Design      : clkWiz100to148
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkWiz100to148 is
  Port ( 
    clk_148 : out STD_LOGIC;
    clk_100 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clkWiz100to148;

architecture stub of clkWiz100to148 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_148,clk_100,reset,locked,clk_in1";
begin
end;
