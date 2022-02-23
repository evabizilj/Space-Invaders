-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.top_types.all;

entity top is
  port(-- clock
       clk_sys     : in top_types.clk_systemdomain;
       -- reset
       btnCpuReset : in top_types.rst_systemdomain;
       vgaRed      : out std_logic_vector(3 downto 0);
       vgaBlue     : out std_logic_vector(3 downto 0);
       vgaGreen    : out std_logic_vector(3 downto 0);
       Hsync       : out boolean;
       Vsync       : out boolean);
end;

architecture structural of top is
  signal c                            : unsigned(15 downto 0) := to_unsigned(0,16);
  signal result                       : unsigned(15 downto 0);
  signal result_0                     : unsigned(15 downto 0);
  signal f2                           : unsigned(15 downto 0);
  signal b                            : boolean;
  signal \c$vCount_bindCsr\           : boolean;
  signal result_1                     : unsigned(15 downto 0) := to_unsigned(0,16);
  signal result_2                     : unsigned(15 downto 0);
  signal result_3                     : unsigned(15 downto 0);
  signal f2_0                         : unsigned(15 downto 0);
  signal b_0                          : boolean;
  signal result_4                     : boolean;
  signal result_5                     : boolean;
  signal result_6                     : top_types.tup5;
  signal y                            : boolean;
  signal y_0                          : boolean;
  signal ds                           : top_types.tup2;
  signal \vgaClock\                   : top_types.clk_vgadomain;
  signal \vgaReset\                   : top_types.rst_vgadomain;
  signal \vgaEnable\                  : boolean;
  signal \c$case_alt\                 : top_types.tup3;
  signal \c$case_alt_0\               : top_types.tup3;
  signal \c$case_alt_1\               : top_types.tup3;
  signal \c$case_alt_2\               : top_types.tup3;
  signal \c$case_alt_3\               : top_types.tup3;
  signal \c$vgaReset_res\             : boolean;
  signal \c$case_alt_selection\       : boolean;
  signal \c$case_alt_0_selection_res\ : boolean;
  signal \c$case_alt_1_selection_res\ : boolean;
  signal \c$case_alt_2_selection_res\ : boolean;
  signal \c$case_alt_3_selection_res\ : boolean;
  signal clash_internal               : top_types.tup5_0;

begin
  -- register begin 
  c_register : process(\vgaClock\,\vgaReset\)
  begin
    if \vgaReset\ =  '0'  then
      c <= to_unsigned(0,16);
    elsif rising_edge(\vgaClock\) then
      if \vgaEnable\ then
        c <= result;
      end if;
    end if;
  end process;
  -- register end

  result <= result_0 when \vgaEnable\ else
            c;

  result_0 <= to_unsigned(0,16) when b else
              f2;

  f2 <= c + to_unsigned(1,16);

  b <= f2 >= to_unsigned(2200,16);

  \c$vCount_bindCsr\ <= \vgaEnable\ and (c = to_unsigned(0,16));

  -- register begin 
  result_1_register : process(\vgaClock\,\vgaReset\)
  begin
    if \vgaReset\ =  '0'  then
      result_1 <= to_unsigned(0,16);
    elsif rising_edge(\vgaClock\) then
      if \c$vCount_bindCsr\ then
        result_1 <= result_2;
      end if;
    end if;
  end process;
  -- register end

  result_2 <= result_3 when \c$vCount_bindCsr\ else
              result_1;

  result_3 <= to_unsigned(0,16) when b_0 else
              f2_0;

  f2_0 <= result_1 + to_unsigned(1,16);

  b_0 <= f2_0 >= to_unsigned(1125,16);

  result_4 <= false when y else
              true;

  result_5 <= false when y_0 else
              true;

  result_6 <= ( tup5_sel0_unsigned_0 => c - to_unsigned(148,16)
              , tup5_sel1_unsigned_1 => result_1 - to_unsigned(36,16)
              , tup5_sel2_boolean_0 => result_4
              , tup5_sel3_boolean_1 => result_5
              , tup5_sel4_boolean_2 => (c < to_unsigned(1920,16)) and (result_1 < to_unsigned(1080,16)) );

  y <= (c < to_unsigned(2008,16)) or (c >= to_unsigned(2052,16));

  y_0 <= (result_1 < to_unsigned(1084,16)) or (result_1 >= to_unsigned(1089,16));

  -- clockWizard begin
  clockwizard : block
    signal pllout  : std_logic;
    signal locked  : std_logic;
    signal plllock : boolean;

    component clkWiz100to148
      port (CLK_IN1  : in std_logic;
            RESET    : in std_logic;
            CLK_OUT1 : out std_logic;
            LOCKED   : out std_logic);
    end component;
  begin
    clockwizard_inst : component clkWiz100to148 port map (clk_sys, NOT(btnCpuReset) ,pllout,locked);
    plllock <= true when locked = '1' else false;
    ds <= (pllout,plllock);
  end block;
  -- clockWizard end

  \vgaClock\ <= ds.tup2_sel0_clk_vgadomain;

  \c$vgaReset_res\ <= true when btnCpuReset = '1' else false;

  \vgaReset\ <= '1' when (not ((not \c$vgaReset_res\))) = true else '0';

  \vgaEnable\ <= ds.tup2_sel1_boolean;

  clash_internal <= ( tup5_0_sel0_std_logic_vector_0 => \c$case_alt\.tup3_sel0_std_logic_vector_0
                    , tup5_0_sel1_std_logic_vector_1 => \c$case_alt\.tup3_sel1_std_logic_vector_1
                    , tup5_0_sel2_std_logic_vector_2 => \c$case_alt\.tup3_sel2_std_logic_vector_2
                    , tup5_0_sel3_boolean_0 => result_6.tup5_sel2_boolean_0
                    , tup5_0_sel4_boolean_1 => result_6.tup5_sel3_boolean_1 );

  \c$case_alt_selection\ <= result_6.tup5_sel4_boolean_2;

  \c$case_alt\ <= \c$case_alt_0\ when \c$case_alt_selection\ else
                  ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"0")
                  , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"0")
                  , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"0") );

  \c$case_alt_0_selection_res\ <= result_6.tup5_sel1_unsigned_1 > to_unsigned(100,16);

  \c$case_alt_0\ <= \c$case_alt_1\ when \c$case_alt_0_selection_res\ else
                    ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"F")
                    , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"7")
                    , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"0") );

  \c$case_alt_1_selection_res\ <= result_6.tup5_sel1_unsigned_1 < to_unsigned(200,16);

  \c$case_alt_1\ <= \c$case_alt_2\ when \c$case_alt_1_selection_res\ else
                    ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"F")
                    , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"7")
                    , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"0") );

  \c$case_alt_2_selection_res\ <= result_6.tup5_sel0_unsigned_0 > to_unsigned(100,16);

  \c$case_alt_2\ <= \c$case_alt_3\ when \c$case_alt_2_selection_res\ else
                    ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"F")
                    , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"7")
                    , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"0") );

  \c$case_alt_3_selection_res\ <= result_6.tup5_sel0_unsigned_0 < to_unsigned(200,16);

  \c$case_alt_3\ <= ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"F")
                    , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"0")
                    , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"F") ) when \c$case_alt_3_selection_res\ else
                    ( tup3_sel0_std_logic_vector_0 => std_logic_vector'(x"F")
                    , tup3_sel1_std_logic_vector_1 => std_logic_vector'(x"7")
                    , tup3_sel2_std_logic_vector_2 => std_logic_vector'(x"0") );

  vgaRed <= clash_internal.tup5_0_sel0_std_logic_vector_0;

  vgaBlue <= clash_internal.tup5_0_sel1_std_logic_vector_1;

  vgaGreen <= clash_internal.tup5_0_sel2_std_logic_vector_2;

  Hsync <= clash_internal.tup5_0_sel3_boolean_0;

  Vsync <= clash_internal.tup5_0_sel4_boolean_1;


end;

