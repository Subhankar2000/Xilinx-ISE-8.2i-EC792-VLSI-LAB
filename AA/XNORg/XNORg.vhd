----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:12:55 12/23/2020 
-- Design Name: 
-- Module Name:    XNORg - Behavioral 
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

entity XNORg is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Y : out  STD_LOGIC);
end XNORg;

architecture Behavioral of XNORg is
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

--+---+---+--+---+
--| B | A |  | Y |
--+---+---+--+---+
--|   |   |  |   |
--| 0 | 0 |  | 1 |
--|   |   |  |   |
--| 0 | 1 |  | 0 |
--|   |   |  |   |
--| 1 | 0 |  | 0 |
--|   |   |  |   |
--| 1 | 0 |  | 1 |
--+---+---+--+---+