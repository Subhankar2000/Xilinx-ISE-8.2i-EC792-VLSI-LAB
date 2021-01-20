library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DF is
    Port ( CLK : in  STD_LOGIC;
           D : in  STD_LOGIC;
           
           Q : inout  STD_LOGIC;
           Q_BAR : inout  STD_LOGIC);
end DF;

architecture Behavioral of DF is
signal S1, S2 : STD_LOGIC;
	begin
		S1 <= D NAND CLK ;
		S2 <= (D NAND D) NAND CLK ;
			
		Q     <= S1 NAND Q_BAR ;
		Q_BAR <= S2 NAND Q ;
end Behavioral;