library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity count8 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Q : inout  STD_LOGIC_VECTOR (7 downto 0)
		    );
end count8;

architecture Behavioral of count8 is
	begin process(RST, CLK)
	
		begin if( RST = '1' )
			then
			q <= "00000000" ;
			
			elsif( RST = '0' AND CLK ='1' )
			then
			q <= q + '1' ;
		end if ;
		
	end process ;
end Behavioral ;