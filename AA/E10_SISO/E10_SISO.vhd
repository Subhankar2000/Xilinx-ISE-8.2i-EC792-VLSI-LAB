library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity E10_SISO is
    Port ( pr : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           d : in  STD_LOGIC;
           q2 : out  STD_LOGIC);
end E10_SISO;

architecture Behavioral of E10_SISO is
signal q0, q1 : STD_LOGIC ;
	begin
	process (pr, clr, clk, d)
		begin 
		if(pr = '0' AND clr = '1')
			then 
			q0 <= '1' ;
			q1 <= '1' ;
			q2 <= '1' ;
		elsif(pr = '1' AND clr = '0')
			then
			q0 <= '0' ;
			q1 <= '0' ;
			q2 <= '0' ;
		elsif(pr = '1' AND clr = '1' AND clk = '0' AND clk'event)
			then
			q0 <= d ;
			q1 <= q0 ;
			q2 <= q1 ;
		else
			null ;
		end if ;
	end process ;
end Behavioral;