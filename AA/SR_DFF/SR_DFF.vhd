library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DFF is
    Port ( CLK : in  STD_LOGIC;
           D : in  STD_LOGIC;
           
           Q : inout  STD_LOGIC;
           Q_BAR : inout  STD_LOGIC);
end DFF;

architecture Behavioral of DFF is
signal D1, D2 : STD_LOGIC;
	begin
		D1 <= D NAND CLK ;
		D2 <= (NOT D) NAND CLK ;
			
		Q     <= D1 NAND Q_BAR ;
		Q_BAR <= D2 NAND Q ;
end Behavioral;