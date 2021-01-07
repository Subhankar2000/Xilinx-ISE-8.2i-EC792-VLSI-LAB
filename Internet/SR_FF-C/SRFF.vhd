library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SRFF is
    Port ( CLK : in  STD_LOGIC;
           S : in  STD_LOGIC;
           R : in  STD_LOGIC;
			  
           Q : inout  STD_LOGIC;
           Q_BAR : inout  STD_LOGIC);
end SRFF;

architecture Behavioral of SRFF is
signal S1, S2 : STD_LOGIC;
	begin
		S1 <= S NAND CLK ;
		S2 <= R NAND CLK ;
			
		Q     <= S1 NAND Q_BAR ;
		Q_BAR <= S2 NAND Q ;
end Behavioral;