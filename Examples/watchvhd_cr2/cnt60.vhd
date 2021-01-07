library ieee;
use ieee.std_logic_1164.all;

entity CNT60 is
    port (CE, CLK, CLR : in std_logic;
	  LSBSEC, MSBSEC : out std_logic_vector(3 downto 0));
end CNT60;

architecture XILINX of CNT60 is

component SMALLCNTR
    port (CE, CLK, CLR : in std_logic;
	  QOUT : out std_logic_vector(3 downto 0));
end component;

signal LSBOUT, MSBOUT : std_logic_vector(3 downto 0);
signal MSBCE, LSBTC, MSBCLR, MSBTC : std_logic;

begin

LSBCOUNT : SMALLCNTR
  port map(CE => CE, CLK => CLK, CLR => CLR, QOUT => LSBOUT);

MSBCOUNT : SMALLCNTR
  port map(CE => MSBCE, CLK => CLK, CLR => MSBCLR, QOUT => MSBOUT);

LSBTC <= '1' when (LSBOUT = "1001") else '0';
MSBTC <= '1' when (MSBOUT = "0110") else '0';
MSBCE <= CE and LSBTC;
MSBCLR <= CLR or MSBTC;

LSBSEC <= LSBOUT;
MSBSEC <= MSBOUT;

end XILINX;
