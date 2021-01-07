library IEEE;
use IEEE.std_logic_1164.all;

entity cnt60 is
    port (	CE : in STD_LOGIC;
	  			CLK : in STD_LOGIC;
          	CLR : in STD_LOGIC;
	  			LSBSEC : out STD_LOGIC_VECTOR(3 downto 0);
	  			MSBSEC : out STD_LOGIC_VECTOR(3 downto 0));
end cnt60;

architecture inside of cnt60 is

component smallcntr
    port (	CE : in STD_LOGIC;
	  			CLK : in STD_LOGIC;
	  			CLR : in STD_LOGIC;
	  			QOUT : out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal lsbout : STD_LOGIC_VECTOR(3 downto 0);
signal msbout : STD_LOGIC_VECTOR(3 downto 0);
signal msbce : STD_LOGIC;
signal lsbtc : STD_LOGIC;
signal msbclr : STD_LOGIC;
signal msbtc : STD_LOGIC;

begin

lsbcount: smallcntr port map(CE=>CE,CLK=>CLK,CLR=>CLR,QOUT=>lsbout);

msbcount: smallcntr port map(CE=>msbce,CLK=>CLK,CLR=>msbclr,QOUT=>msbout);

process(lsbout)
    begin

    if(lsbout="1001") then
			lsbtc<='1';
    else
			lsbtc<='0';
    end if;
    end process;

process(msbout)
    begin

    if(msbout="0110") then
			msbtc<='1';
    else
			msbtc<='0';
    end if;
    end process;
    
msbce <= CE and lsbtc;
msbclr <= CLR or msbtc;
LSBSEC <= lsbout;
MSBSEC <= msbout;

end inside;

