library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DF_B is
    Port ( CLK : in  STD_LOGIC;
           D : in  STD_LOGIC;
           
           Q : inout  STD_LOGIC;
           Q_BAR : inout  STD_LOGIC
			 );
end DF_B;

architecture Behavioral of DF_B is
	begin process (D, CLK)
		begin	if (CLK = '1') 
			then
			Q <= D;
			Q_BAR <= not D;
		end if;
	end process;
end Behavioral;