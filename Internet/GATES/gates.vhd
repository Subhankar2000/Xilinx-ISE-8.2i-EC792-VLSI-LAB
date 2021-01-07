----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:10:18 12/09/2020 
-- Design Name: 
-- Module Name:    gates - Behavioral 
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

entity gates is
Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           AND1 : out  STD_LOGIC;
           OR1 : out  STD_LOGIC;
           NOT1 : out  STD_LOGIC;
           XOR1 : out  STD_LOGIC;
           NAND1 : out  STD_LOGIC;
           NOR1 : out  STD_LOGIC;
           XNOR1 : out  STD_LOGIC);
end gates;

architecture Behavioral of gates is

begin
AND1<=A AND B;
OR1<=A OR B;
NOT1<=NOT A;
XOR1<=A XOR B;
NAND1<= A NAND B;
NOR1<=A NOR B;
XNOR1<=A XNOR B;

end Behavioral;

