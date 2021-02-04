library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipo is
port(
		 CLK: in std_logic;
			D: in std_logic_vector(3 downto 0);
			Q: out std_logic_vector(3 downto 0)
	  );
end pipo;

architecture Behavioral of pipo is
	begin process (CLK)
		begin if ( CLK = '1' )
			then
			Q <= D;
		end if;
	end process;
end Behavioral;