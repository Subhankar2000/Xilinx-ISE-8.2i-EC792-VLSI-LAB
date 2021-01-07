library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types

entity jc2_top is
    port (
	  LEFT : in STD_LOGIC;   -- Active-low switch #3 (left)
	  RIGHT : in STD_LOGIC;  -- Active-low switch #0 (right)
	  STOP : in STD_LOGIC;   -- Active-low switch #2
     CLK : in STD_LOGIC;
     Q : inout STD_LOGIC_VECTOR (3 downto 0) := "0000"  -- Active-low LEDs
         );
    attribute pin_assign : string;
    attribute pin_assign of clk : signal is "A7";
    attribute pin_assign of left : signal is "G7";
    attribute pin_assign of right : signal is "B2";
    attribute pin_assign of stop : signal is "F2";
    attribute pin_assign of q : signal is "G5 F6 C6 B4";
end jc2_top;

architecture jc2_top_arch of jc2_top is
   signal DIR: STD_LOGIC := '0';	 -- Left=1, Right=0
   signal RUN: STD_LOGIC := '0';
begin

process (CLK)
begin
   if (CLK'event and CLK='1') then       -- CLK rising edge

   -- DIR register:
     if (RIGHT='0') then
        DIR <= '0';
     elsif (LEFT='0') then
        DIR <= '1';
     end if;
     
   -- RUN register:
     if (STOP='0') then
        RUN <= '0';
     elsif (LEFT='0' or RIGHT='0') then
        RUN <= '1';
     end if;
     
   -- Counter section:
     if (RUN='1') then
        if (DIR='1') then
           Q(3 downto 1) <= Q(2 downto 0);    -- Shift lower bits (Left Shift)
           Q(0) <= not Q(3);                  -- Circulate inverted MSB to LSB
        else
           Q(2 downto 0) <= Q(3 downto 1);    -- Shift upper bits (Right Shift)
           Q(3) <= not Q(0);                  -- Circulate inverted LSB to MSB
        end if;
     end if;
     
   end if;
end process;

end jc2_top_arch;
