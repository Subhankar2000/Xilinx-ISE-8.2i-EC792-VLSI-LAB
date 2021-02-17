library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity siso_reg is
    Port ( 
		CLK : in  STD_LOGIC ;
  PRE_SET : in  STD_LOGIC ;
	 CLEAR : in STD_LOGIC  ;
		 SI : in  STD_LOGIC ;
		 SO : out  STD_LOGIC
		 );
end siso_reg;

architecture Behavioral of siso_reg is

signal REG : STD_LOGIC_VECTOR(3 downto 0);
	
	begin process(CLK)
		begin if( CLK='1' AND PRE_SET='0' AND CLEAR='0' )
			then
			REG <= SI & REG(3 downto 1);
		elsif( PRE_SET='1' AND CLEAR='0' )
			then
			REG <= "1111" ;
		elsif( PRE_SET='0' AND CLEAR='1' )
			then
			REG <= "0000" ;
		end if;
	end process;
	
	SO <= REG(0);
	
end Behavioral;