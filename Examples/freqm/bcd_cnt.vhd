library IEEE;
use IEEE.std_logic_1164.all;

use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity CNT_BCD is
	port (
	  CLK: in STD_LOGIC;
	  RESET: in STD_LOGIC;
	  ENABLE: in STD_LOGIC;
	  FULL: out STD_LOGIC;
	  BCD_U: out STD_LOGIC_VECTOR (3 downto 0);	
	  BCD_D: out STD_LOGIC_VECTOR (3 downto 0);
	  BCD_H: out STD_LOGIC_VECTOR (3 downto 0);
	  BCD_T: out STD_LOGIC_VECTOR (3 downto 0)
	);
end CNT_BCD;  

architecture CNT_BCD of CNT_BCD is

signal COUNTER_U: INTEGER range 0 to 9;	  
signal COUNTER_D: INTEGER range 0 to 9;
signal COUNTER_H: INTEGER range 0 to 9;
signal COUNTER_T: INTEGER range 0 to 9; 
signal IS_9999: STD_LOGIC;

begin

process (CLK, RESET)

begin
   if RESET='1' then
      COUNTER_U <= 0; 
      COUNTER_D <= 0;
      COUNTER_H <= 0;
      COUNTER_T <= 0;	 
   elsif CLK='1' and CLK'event then
   	  if ENABLE = '1' and IS_9999 = '0' then 
		if COUNTER_U = 9 then
			COUNTER_U <= 0;	 
			if COUNTER_D = 9 then
				COUNTER_D <= 0;
				if COUNTER_H = 9 then
					COUNTER_H <= 0;	 
					COUNTER_T <= COUNTER_T + 1;
				else
					COUNTER_H <= COUNTER_H + 1;
				end if;
			else 	
				COUNTER_D <= COUNTER_D + 1;
			end if;
		else
			COUNTER_U <= COUNTER_U + 1;
		end if;	  
	  end if;
   end if;
end process;
BCD_U <= CONV_STD_LOGIC_VECTOR(COUNTER_U,4);	  
BCD_D <= CONV_STD_LOGIC_VECTOR(COUNTER_D,4);
BCD_H <= CONV_STD_LOGIC_VECTOR(COUNTER_H,4);
BCD_T <= CONV_STD_LOGIC_VECTOR(COUNTER_T,4);		

IS_9999 <= '1' when (COUNTER_U = 9 and COUNTER_D = 9 and COUNTER_H = 9 and COUNTER_T = 9) else '0';

FULL <= IS_9999;

end CNT_BCD;
