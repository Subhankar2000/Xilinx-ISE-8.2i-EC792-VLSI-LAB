library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity JKFF is 
 	port ( CLK: in STD_LOGIC;
				J: in STD_LOGIC;
				K: in STD_LOGIC;
				
				Q: inout STD_LOGIC := '0';
				Q_BAR: inout STD_LOGIC := '1');
end JKFF;

architecture Behavioral of JKFF is 
signal J1, K1, S1, S2 : STD_LOGIC;
	begin
		J1 <= CLK NAND J;
      K1 <= CLK NAND K;
      
		Q <= S1 NAND Q_BAR;
      Q_BAR <= S2 NAND Q;
		
		S1 <= J1 NAND Q;
		S2 <= K1 NAND Q_BAR;
end Behavioral;