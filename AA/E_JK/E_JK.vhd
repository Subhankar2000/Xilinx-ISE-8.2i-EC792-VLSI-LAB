library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity E_JK is
    Port ( J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : inout  STD_LOGIC;
           Q_BAR : inout  STD_LOGIC);
end E_JK;

architecture Behavioral of E_JK is
begin
	process begin
	wait until CLK='1' AND CLK'event ;
		if( J='0' AND K='0' )
			then
			Q <= Q ;
			Q_BAR <= Q_BAR ;
		elsif( J='0' AND K='1' )
			then
			Q <= '0' ;
			Q_BAR <= '1' ;
		elsif( J='1' AND K='0' )
			then
			Q <= '1' ;
			Q_BAR <= '0' ;
		elsif( J='1' AND K='1' )
			then
			Q <= Q_BAR ;
			Q_BAR <= Q ;
		end if ;
	end process ;
end Behavioral;