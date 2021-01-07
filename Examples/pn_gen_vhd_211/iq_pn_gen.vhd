--The following is example code that implements two LFSRs which can be used as part of pn generators.
--The number of taps, tap points, and LFSR width are parameratizable. When targetting Xilinx (Virtex)
--all the latest synthesis vendors (Leonardo, Synplicity, and FPGA Express) will infer the shift 
--register LUTS (SRL16) resulting in a very efficient implementation.
--
--Control signals have been provided to allow external circuitry to control such things as filling,
--puncturing, stalling (augmentation), etc.
--
--Mike Gulotta
--11/4/99
--Revised 3/17/00:  Fixed "commented" block diagram to match polynomial.
--
--
--###################################################################################################
--          I and Q Polinomials:                                                                    #
--          I(x) = X**17 + X**5 + 1                                                                 #
--          Q(x) = X**17 + X**9 + X**5 + X**4 + 1                                                   #
--                                                                                                  #
--          LFSR implementation format examples:                                                    #
--###################################################################################################
--                                                                                                  #
--          I(x) = X**17 + X**5 + 1                                                                 #
--                        ________                                                                  #
--                       |        |<<...............................                                #
--                       | Parity |                                 |                               #
--      .................|        |<<...                            |                               #
--     |                 |________|    |                            |                               #
--     |                               |                            |                               #
--     |          __________________   |   ______________ ____      |                               #
--     |...|\    |    |        |    |  |  |    |       	 |    |     | pn_out_i                      #
--         ||-->>| 16 | - - - -|  5 |-----|  4 | - - - - |  0 | >>---------->>                      #
--DataIn_i.|/    |____|________|____|     |____|_________|____|                                     #
--          |                      srl_i                                                            #
-- FillSel..|                                                                                       #
--                                  ---> shifting -->>                                              #
--###################################################################################################
--                                                                                                  #
--                                                                                                  #
--           Q(x) = X**17 + X**9 + X**5 + X**4 + 1                                                  #
--                 ________                                                                         #
--                |        |..........................................................              #
--                |        |......................................                    |             #
--      ..........| Parity |...........................           |                   |             #
--     |          |        |.......                    |          |                   |             #
--     |          |________|       |                   |          |                   |             #
--     |           _____________   |   ____ ________   |   ____   |   ______________  |             #
--     |...|\     |    |    |   |  |  |    |    |   |  |  |    |  |  |    |    |    | |   pn_out_q  #
--         ||--->>| 16 | - -| 9 |-----|  8 | - -| 5 |-----|  4 |-----|  3 | - -|  0 |--------->>    #
--DataIn_q.|/     |____|____|___|     |____|____|___|     |____|     |____|____|____|               #
--          |                                srl_q                                                  #
-- FillSel..|                                                                                       #
--                                           -->> shifting  -->>                                    #
--###################################################################################################

library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity iq_pn_gen is
  generic(NumOfTaps_i  : integer := 2;   -- # of taps for I channel LFSR, including output tap.
	  		 NumOfTaps_q  : integer := 4;   -- # of taps for Q channel LFSR, including output tap.
          Width        : integer := 17); -- LFSR length (ie, total # of storage elements)
  port(clk, ShiftEn, FillSel, DataIn_i, DataIn_q : in  std_logic;
       pn_out_i, pn_out_q     				 : out std_logic);
end iq_pn_gen ;


architecture rtl of iq_pn_gen is

  type TapPointArray_i is array (NumOfTaps_i-1 downto 0) of integer;
  type TapPointArray_q is array (NumOfTaps_q-1 downto 0) of integer;

  -- Parameratize I LFSR taps.  (e.g.  I(x) = X**17 + X**5 + 1)
  -- Plug in I channel tap points, including output tap 0.
  constant Tap_i : TapPointArray_i := (1=>5, 0=>0);  

  -- Parameratize I LFSR taps.  (e.g.  Q(x) = X**17 + X**9 + X**5 + X**4 + 1)
  -- Plug in Q channel tap points, including output tap 0.
  constant Tap_q : TapPointArray_q := (3=>9, 2=>5, 1=>4, 0=>0);  

  signal srl_i	       : std_logic_vector(Width-1 downto 0);       -- shift register.
  signal par_fdbk_i   : std_logic_vector(NumOfTaps_i downto 0);   -- Parity feedback.
  signal lfsr_in_i    : std_logic;				   -- mux output.

  signal srl_q	       : std_logic_vector(Width-1 downto 0);       -- shift register.
  signal par_fdbk_q   : std_logic_vector(NumOfTaps_q downto 0);   -- Parity feedback.
  signal lfsr_in_q    : std_logic;				   -- mux output.

begin

---------------------------------------------------------------------
------------------ I Channel ----------------------------------------
---------------------------------------------------------------------

  Shift_i : process (clk)
  begin
    if clk'event and clk = '1' then
      if ShiftEn = '1' then
        srl_i <= lfsr_in_i & srl_i(srl_i'high downto 1);
      end if; 
    end if;
  end process;

  par_fdbk_i(0) <= '0';

  fdbk_i : for X in 0 to Tap_i'high generate -- parity generator
      par_fdbk_i(X+1) <= par_fdbk_i(X) xor srl_i(Tap_i(X));
  end generate fdbk_i;

  lfsr_in_i <= DataIn_i when FillSel = '1' else par_fdbk_i(par_fdbk_i'high);
  
  pn_out_i <= srl_i(srl_i'low);  -- PN I channel output.
---------------------------------------------------------------------


---------------------------------------------------------------------
------------------ Q Channel ----------------------------------------
---------------------------------------------------------------------

  Shift_q : process (clk)
  begin
    if clk'event and clk = '1' then
      if ShiftEn = '1' then
        srl_q <= lfsr_in_q & srl_q(srl_q'high downto 1);
      end if; 
    end if;
  end process;

  par_fdbk_q(0) <= '0';

  fdbk_q : for X in 0 to Tap_q'high generate -- parity generator
      par_fdbk_q(X+1) <= par_fdbk_q(X) xor srl_q(Tap_q(X));
  end generate fdbk_q;

  lfsr_in_q <= DataIn_q when FillSel = '1' else par_fdbk_q(par_fdbk_q'high);
  
  pn_out_q <= srl_q(srl_q'low);  -- PN Q channel output.
---------------------------------------------------------------------
  
end rtl;

