library IEEE;
use IEEE.std_logic_1164.all;  -- defines std_logic types

entity jcounter is
    port (
	  CE : in STD_LOGIC; -- Clock Enable
	  LEFT : in STD_LOGIC; -- Direction Control
     CLK : in STD_LOGIC; -- Clock Input
     Q : inout STD_LOGIC_VECTOR (3 downto 0) := "0000"
         );
end jcounter;

architecture jcounter_arch of jcounter is
begin

process (CLK)
begin
   if (CLK'event and CLK='1') then	-- CLK rising edge
     if (CE='1') then
       if (LEFT='1') then
         Q(3 downto 1) <= Q(2 downto 0);  -- Shift lower bits (Left Shift)
         Q(0) <= not Q(3);                -- Circulate inverted MSB to LSB
       else
         Q(2 downto 0) <= Q(3 downto 1);   -- Shift upper bits (Right Shift)
         Q(3) <= not Q(0);	                -- Circulate inverted LSB to MSB
       end if;
     end if;
   end if;
end process;

end jcounter_arch;
