library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package top_types is


  type tup3 is record
    tup3_sel0_std_logic_vector_0 : std_logic_vector(3 downto 0);
    tup3_sel1_std_logic_vector_1 : std_logic_vector(3 downto 0);
    tup3_sel2_std_logic_vector_2 : std_logic_vector(3 downto 0);
  end record;

  subtype clk_vgadomain is std_logic;
  type tup2 is record
    tup2_sel0_clk_vgadomain : top_types.clk_vgadomain;
    tup2_sel1_boolean : boolean;
  end record;
  subtype rst_systemdomain is std_logic;
  subtype rst_vgadomain is std_logic;
  type tup5_0 is record
    tup5_0_sel0_std_logic_vector_0 : std_logic_vector(3 downto 0);
    tup5_0_sel1_std_logic_vector_1 : std_logic_vector(3 downto 0);
    tup5_0_sel2_std_logic_vector_2 : std_logic_vector(3 downto 0);
    tup5_0_sel3_boolean_0 : boolean;
    tup5_0_sel4_boolean_1 : boolean;
  end record;
  subtype clk_systemdomain is std_logic;
  type tup5 is record
    tup5_sel0_unsigned_0 : unsigned(15 downto 0);
    tup5_sel1_unsigned_1 : unsigned(15 downto 0);
    tup5_sel2_boolean_0 : boolean;
    tup5_sel3_boolean_1 : boolean;
    tup5_sel4_boolean_2 : boolean;
  end record;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (b : in boolean) return std_logic_vector;
  function fromSLV (sl : in std_logic_vector) return boolean;
  function tagToEnum (s : in signed) return boolean;
  function dataToTag (b : in boolean) return signed;
  function toSLV (p : top_types.tup3) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return top_types.tup3;
  function toSLV (u : in unsigned) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return unsigned;
  function toSLV (sl : in std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic;
  function toSLV (p : top_types.tup2) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return top_types.tup2;
  function toSLV (p : top_types.tup5_0) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return top_types.tup5_0;
  function toSLV (p : top_types.tup5) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return top_types.tup5;
end;

package body top_types is
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function toSLV (b : in boolean) return std_logic_vector is
  begin
    if b then
      return "1";
    else
      return "0";
    end if;
  end;
  function fromSLV (sl : in std_logic_vector) return boolean is
  begin
    if sl = "1" then
      return true;
    else
      return false;
    end if;
  end;
  function tagToEnum (s : in signed) return boolean is
  begin
    if s = to_signed(0,64) then
      return false;
    else
      return true;
    end if;
  end;
  function dataToTag (b : in boolean) return signed is
  begin
    if b then
      return to_signed(1,64);
    else
      return to_signed(0,64);
    end if;
  end;
  function toSLV (p : top_types.tup3) return std_logic_vector is
  begin
    return (toSLV(p.tup3_sel0_std_logic_vector_0) & toSLV(p.tup3_sel1_std_logic_vector_1) & toSLV(p.tup3_sel2_std_logic_vector_2));
  end;
  function fromSLV (slv : in std_logic_vector) return top_types.tup3 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 3)),fromSLV(islv(4 to 7)),fromSLV(islv(8 to 11)));
  end;
  function toSLV (u : in unsigned) return std_logic_vector is
  begin
    return std_logic_vector(u);
  end;
  function fromSLV (slv : in std_logic_vector) return unsigned is
    alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return unsigned(islv);
  end;
  function toSLV (sl : in std_logic) return std_logic_vector is
  begin
    return std_logic_vector'(0 => sl);
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic is
    alias islv : std_logic_vector (0 to slv'length - 1) is slv;
  begin
    return islv(0);
  end;
  function toSLV (p : top_types.tup2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_sel0_clk_vgadomain) & toSLV(p.tup2_sel1_boolean));
  end;
  function fromSLV (slv : in std_logic_vector) return top_types.tup2 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 0)),fromSLV(islv(1 to 1)));
  end;
  function toSLV (p : top_types.tup5_0) return std_logic_vector is
  begin
    return (toSLV(p.tup5_0_sel0_std_logic_vector_0) & toSLV(p.tup5_0_sel1_std_logic_vector_1) & toSLV(p.tup5_0_sel2_std_logic_vector_2) & toSLV(p.tup5_0_sel3_boolean_0) & toSLV(p.tup5_0_sel4_boolean_1));
  end;
  function fromSLV (slv : in std_logic_vector) return top_types.tup5_0 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 3)),fromSLV(islv(4 to 7)),fromSLV(islv(8 to 11)),fromSLV(islv(12 to 12)),fromSLV(islv(13 to 13)));
  end;
  function toSLV (p : top_types.tup5) return std_logic_vector is
  begin
    return (toSLV(p.tup5_sel0_unsigned_0) & toSLV(p.tup5_sel1_unsigned_1) & toSLV(p.tup5_sel2_boolean_0) & toSLV(p.tup5_sel3_boolean_1) & toSLV(p.tup5_sel4_boolean_2));
  end;
  function fromSLV (slv : in std_logic_vector) return top_types.tup5 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 15)),fromSLV(islv(16 to 31)),fromSLV(islv(32 to 32)),fromSLV(islv(33 to 33)),fromSLV(islv(34 to 34)));
  end;
end;

