library ieee;
use ieee.std_logic_1164.all;

entity LFSR_B is
generic (cycleB0 : integer := 26;	 		
			cycleB20 : integer := 21;	 		
			width :integer := 1);
port ( 	Clk :in std_logic;    	
			Enable : in std_logic;		
			Fill_En : in std_logic;		
			New_Fill : in std_logic_vector(width -1 downto 0);		
			DelayB0 :out std_logic_vector(width - 1 downto 0));
			
attribute clock_node :boolean;
attribute clock_node of Clk : signal is TRUE;

end LFSR_B;

architecture LFSR_B_ARCH of LFSR_B is

signal Data_In_B: STD_LOGIC_VECTOR(width -1 downto 0);
signal DelayB20 : STD_LOGIC_VECTOR(width -1 downto 0);
signal DelayB0_int : STD_LOGIC_VECTOR(width -1 downto 0);
type my_type is array (0 to cycleB0 -1) of std_logic_vector(width -1 downto 0);
signal int_sigB0 :my_type;
type my_type2 is array (0 to cycleB20 -1) of std_logic_vector(width -1 downto 0);
signal int_sigB20 :my_type2;

begin

main :process (Clk)
begin
if Clk'event and Clk = '1' then  
	if (Enable = '1') then    
		int_sigB0 <= Data_In_B & int_sigB0(0 to cycleB0 - 2);    
		int_sigB20 <= Data_In_B & int_sigB20(0 to cycleB20 - 2);  
	end if;  
	if (Fill_En = '0') then    
		Data_In_B <= DelayB20 xor DelayB0_int;  
	else    
		Data_In_B <= New_Fill;  
	end if;
end if;
end process main;

delayB0_int <= int_sigB0(cycleB0 -1);
delayB20 <= int_sigB20(cycleB20 - 1);
delayB0 <= delayB0_int;
end LFSR_B_ARCH;
