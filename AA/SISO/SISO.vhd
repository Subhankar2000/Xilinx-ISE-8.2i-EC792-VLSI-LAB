library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SISO is
    Port ( 
		 SI : in  STD_LOGIC;
		CLK : in  STD_LOGIC;
		 SO : out  STD_LOGIC
		 );
end SISO;

architecture Behavioral of SISO is

signal SIG : STD_LOGIC_VECTOR(3 downto 0);
	
	begin process(CLK)
		begin if( CLK ='1' )
		then
		SIG <= SI & SIG(3 downto 1);
		end if;
	end process;
	
	SO <= SIG(0);
	
end Behavioral;