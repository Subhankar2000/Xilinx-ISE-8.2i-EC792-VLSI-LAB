library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity JKFF is 
 	port ( CLK: in STD_LOGIC;
				J: in STD_LOGIC;
				K: in STD_LOGIC;
				
				Q: inout STD_LOGIC;
				Q_BAR: inout STD_LOGIC
			);
end JKFF;

architecture Behavioral of JKFF is
 
	begin process(J,K,CLK)
		begin	if (CLK = '1') 
			then
		
			if(J='1' and K='0') 
				then
				Q <= J;
				Q_BAR <= NOT J;
				
			elsif(J='0' and K='1') 
				then
				Q <= NOT K;
				Q_BAR <= K;			
				
			elsif(J='1' and K='1') 
				then
				Q <= Q_BAR;
				Q_BAR <= Q;	
			end if;
		
		end if;
	end process;
	
end Behavioral;