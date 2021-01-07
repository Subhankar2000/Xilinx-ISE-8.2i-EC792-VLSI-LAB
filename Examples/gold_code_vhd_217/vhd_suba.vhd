LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity LFSR_A is
generic (cycleA0 : integer := 26;
			cycleA3 : integer := 4;		   
			width :integer := 1);
port ( 	Clk :in std_logic;	      	
			Enable : in std_logic;	   	
			Fill_En : in std_logic;      	
			New_Fill : in std_logic_vector(width -1 downto 0);      	
			DelayA0 :out std_logic_vector(width - 1 downto 0));
			
attribute clock_node :boolean;
attribute clock_node of Clk : signal is TRUE;
end LFSR_A;

architecture LFSR_A_ARCH of LFSR_A is

signal Data_In_A: STD_LOGIC_VECTOR(width -1 downto 0);
signal DelayA3 : STD_LOGIC_VECTOR(width -1 downto 0);
signal DelayA0_int : STD_LOGIC_VECTOR(width -1 downto 0);
type my_type is array (0 to cycleA0 -1) of std_logic_vector(width -1 downto 0);
signal int_sigA0 :my_type;
type my_type2 is array (0 to cycleA3 -1) of std_logic_vector(width -1 downto 0);
signal int_sigA3 :my_type2;

begin

main :process (Clk)
begin
if Clk'event and Clk = '1' then  
	if (Enable = '1') then    
		int_sigA0 <= Data_In_A & int_sigA0(0 to cycleA0 - 2);	 
		int_sigA3 <= Data_In_A & int_sigA3(0 to cycleA3 - 2);  
	end if;  
	if (Fill_En = '0') then   
		Data_In_A <= DelayA3 xor DelayA0_int;  
	else    
		Data_In_A <= New_Fill;  
	end if;
end if;
end process main;

delayA0_int <= int_sigA0(cycleA0 -1);
delayA3 <= int_sigA3(cycleA3 - 1);
delayA0 <= delayA0_int;
end LFSR_A_ARCH;
