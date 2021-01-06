----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:20:12 01/06/2021 
-- Design Name: 
-- Module Name:    E6_2_XNOR - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity E6_2_XNOR is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end E6_2_XNOR;

architecture Behavioral of E6_2_XNOR is
	begin process(a,b)
		begin
			if    ( B = '0' AND A = '0' )
				then Y <= '1' ;
			elsif ( B = '0' AND A = '1' )
				then Y <= '0' ;
			elsif ( B = '1' AND A = '0' )
				then Y <= '0' ;
			elsif ( B = '1' AND A = '1' )
				then Y <= '1' ;
		end if ;
	end process ;
end Behavioral;

