library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter1 is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Q : inout  STD_LOGIC_VECTOR (3 downto 0)
			 );
end counter1;

architecture Behavioral of counter1 is
	begin process(RST, CLK)
	
		begin if( RST = '1' )
			then
			q <= "1111" ;
			
			elsif( RST = '0' AND CLK ='1' )
			then
			q <= q - '1' ;
		end if ;
		
	end process ;
end Behavioral ;