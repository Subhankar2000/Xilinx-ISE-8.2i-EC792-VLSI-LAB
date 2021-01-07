----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:40 12/15/2020 
-- Design Name: 
-- Module Name:    exp2_OR - Behavioral 
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

entity exp2_OR is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
			  Y : out  STD_LOGIC
			 );
end exp2_OR;

architecture Behavioral of exp2_OR is

begin
Y <= A OR B ;

end Behavioral;

