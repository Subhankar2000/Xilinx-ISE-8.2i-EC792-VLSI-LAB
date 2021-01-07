library IEEE;
use IEEE.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

entity watch is
    port (RESET, CDRST,STRTSTOP : in STD_LOGIC;
          CLK : in STD_LOGIC; 
	  TENSOUT, ONESOUT : out STD_LOGIC_VECTOR(6 downto 0);
	  TENTHSOUT : out STD_LOGIC_VECTOR(9 downto 0));
end watch;

architecture XILINX of watch is

component CLK_DIV16R port (
CLKIN : in std_logic;
CDRST : in std_logic;
CLKDV : out std_logic
);
end component;

component stmchine
    port (CLK, RESET, STRTSTOP : in STD_LOGIC;
	  CLKEN, RST : out STD_LOGIC);
end component;

component tenths
    port (CLOCK, CLK_EN, ASYNC_CTRL : in STD_LOGIC;
	  TERM_CNT : out STD_LOGIC;
	  Q_OUT : out STD_LOGIC_VECTOR(9 downto 0));
end component;

component cnt60
    port (CE, CLK, CLR : in STD_LOGIC;
	  LSBSEC, MSBSEC : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component hex2led
    port (HEX : in STD_LOGIC_VECTOR(3 downto 0);
	  LED : out STD_LOGIC_VECTOR(6 downto 0));
end component;

signal clkint, clkenable : STD_LOGIC;
signal strtstopinv, rstint, xtermcnt, cnt60enable : STD_LOGIC;
signal xcountout : STD_LOGIC_VECTOR(9 downto 0);
signal lsbcnt, msbcnt : STD_LOGIC_VECTOR(3 downto 0);

begin

MACHINE : stmchine
  port map(CLK => clkint, RESET => RESET, STRTSTOP => strtstopinv,
	   CLKEN => clkenable, RST => rstint);

XCOUNTER : tenths
  port map(CLOCK => clkint, CLK_EN => clkenable, ASYNC_CTRL => rstint,
	   TERM_CNT => xtermcnt, Q_OUT => xcountout);

SIXTY : cnt60
  port map(CE => cnt60enable, CLK => clkint, CLR => rstint,
           LSBSEC => lsbcnt, MSBSEC => msbcnt);

LSBLED : hex2led
  port map(HEX => lsbcnt, LED => ONESOUT);

MSBLED : hex2led
  port map( HEX => msbcnt, LED => TENSOUT);

U1 : CLK_DIV16R port map (CLKIN => CLK,
			CDRST => CDRST,
			CLKDV => clkint);

cnt60enable <= xtermcnt and clkenable;
TENTHSOUT <= not(xcountout);
strtstopinv <= not(STRTSTOP);

end XILINX;
