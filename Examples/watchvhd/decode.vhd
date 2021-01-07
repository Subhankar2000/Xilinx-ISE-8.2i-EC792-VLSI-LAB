library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decode is
    Port ( binary : in std_logic_vector(3 downto 0);
           one_hot : out std_logic_vector(9 downto 0));
end decode;

architecture behavioral of decode is

begin

with binary select
	one_hot	<=	"0000000001" when "0001",	--1
					"0000000010" when "0010",	--2
					"0000000100" when "0011",	--3
					"0000001000" when "0100",	--4
					"0000010000" when "0101",	--5
					"0000100000" when "0110",	--6
					"0001000000" when "0111",	--7
					"0010000000" when "1000",	--8
					"0100000000" when "1001",	--9
					"1000000000" when "1010",	--10
					"0000000001" when others;	--1
	
end behavioral;
