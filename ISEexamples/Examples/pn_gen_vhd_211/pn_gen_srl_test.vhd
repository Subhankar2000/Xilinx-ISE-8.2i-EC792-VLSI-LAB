--  01/20/01  P. Glover

Library IEEE;
use IEEE.std_logic_1164.ALL;
use std.textio.all;

entity pn_gen_test is
end pn_gen_test;

architecture one of pn_gen_test is

COMPONENT iq_pn_gen
	PORT(
		clk : IN std_logic;
		ShiftEn : IN std_logic;
		FillSel : IN std_logic;
		DataIn_i : IN std_logic;
		DataIn_q : IN std_logic;        
		pn_out_i : OUT std_logic;
		pn_out_q : OUT std_logic
		);
	END COMPONENT;

signal clk : std_logic := '1';
signal DataIn_i, DataIn_q, FillSel, ShiftEn : std_logic;
signal pn_out_i, pn_out_q : std_logic;

constant PERIOD : time := 10 ns;

begin

UUT: iq_pn_gen PORT MAP(
		clk => clk,
		ShiftEn => ShiftEn,
		FillSel => FillSel,
		DataIn_i => DataIn_i,
		DataIn_q => DataIn_q,
		pn_out_i => pn_out_i,
		pn_out_q => pn_out_q
	);

clock: process
begin
	clk <= not clk; wait for PERIOD/2;
end process;

data: process
begin  -- shift in fill pattern (1 0000 0000 0000 0000)
   ShiftEn <= '1';
   FillSel <= '1';
   DataIn_i <= '0';
   DataIn_q <= '0';

   wait for (16 * PERIOD);
      DataIn_i <= '1';
      DataIn_q <= '1';
   wait for PERIOD;
      FillSel <= '0';
      DataIn_i <= '0';
      DataIn_q <= '0'; wait;
end process;

end one;










