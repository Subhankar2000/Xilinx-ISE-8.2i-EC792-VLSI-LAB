library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity JKFF is 
 	port ( CLK: in STD_LOGIC;
				J: in STD_LOGIC;
				K: in STD_LOGIC;
				
				Q: inout STD_LOGIC;
				Q_BAR: inout STD_LOGIC);
end JKFF;

architecture Behavioral of JKFF is 
signal J1 , K1 : STD_LOGIC;
	begin
		J1 <= (CLK NAND J);
      K1 <= (CLK NAND K);
      
		Q <= J1 NAND Q_BAR;
      Q_BAR <= K1 NAND Q;
end Behavioral;