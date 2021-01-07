library ieee;
use ieee.std_logic_1164.all;

entity Gold_Code is
generic (width : integer := 1);
port ( 	Clk :in std_logic;
 	Enable : in std_logic;
	Fill_En_A : in std_logic;
	Fill_En_B : in std_logic;
	New_Fill_A : in std_logic_vector(width -1 downto 0);
	New_Fill_B : in std_logic_vector(width -1 downto 0);
	Gold_Code_r :out std_logic_vector(width - 1 downto 0));
attribute clock_node :boolean;
attribute clock_node of Clk : signal is TRUE;
end Gold_Code;

architecture Gold_Code_Arch of Gold_Code is

component LFSR_A port 
	(Clk: in std_logic;
	 Enable: in std_logic;
	 Fill_En: in std_logic;
	 New_fill:in std_logic_vector(width-1 downto 0);
	 delayA0: out std_logic_vector(width-1 downto 0));
end component;

component LFSR_B port
	(Clk: in std_logic;
	 Enable: in std_logic;
	 Fill_En: in std_logic;
	 New_Fill: in std_logic_vector(width-1 downto 0);
	 delayB0: out std_logic_vector(width-1 downto 0));
end component;

signal DelayA_top : std_logic_vector(width -1 downto 0);
signal DelayB_top : std_logic_vector(width -1 downto 0);

begin

U0 : LFSR_A port map (Clk => Clk, Enable => Enable, 
		      Fill_En => Fill_En_A, 
		      New_Fill => New_Fill_A, 
		      delayA0 => delayA_top);

U1 : LFSR_B port map (Clk => Clk, Enable => Enable, 
		      Fill_En => Fill_En_B, 
		      New_Fill => New_Fill_B, 
		      delayB0 => delayB_top);

Gold_Code_r <= delayB_top xor delayA_top;

end Gold_Code_Arch;      
		      