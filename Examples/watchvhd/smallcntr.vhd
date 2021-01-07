library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_unsigned.all;

entity smallcntr is
    port (  CE : in STD_LOGIC;
	   		CLK : in STD_LOGIC;
	   		CLR : in STD_LOGIC;
	  			QOUT : out STD_LOGIC_VECTOR(3 downto 0)
	  );
end smallcntr;

architecture inside of smallcntr is

signal qoutsig : STD_LOGIC_VECTOR(3 downto 0);
    
begin

process(CE,CLK,CLR)
    begin

    if(CLR='1') then
			qoutsig <="0000";
    elsif(CE='1') then
		if(CLK'event and CLK='1') then  --change "fi" to "if"
	    	if(qoutsig="1001") then
				qoutsig<="0000";
	    	else
				qoutsig<=qoutsig + "0001";
	    	end if;
		end if;
    end if;

  end process;
	
QOUT<=qoutsig;
    
end inside;

