library IEEE;
use IEEE.std_logic_1164.all;
--synopsys translate_off
library UNISIM;
use unisim.vcomponents.all;
--synopsys translate_on

entity stopwatch is
    port (  CLK : in STD_LOGIC;
		  RESET : in STD_LOGIC;
		  STRTSTOP : in STD_LOGIC;
		  TENTHSOUT : out STD_LOGIC_VECTOR(9 downto 0);
		  ONESOUT : out STD_LOGIC_VECTOR(6 downto 0);
		  TENSOUT : out STD_LOGIC_VECTOR(6 downto 0));
end stopwatch;

architecture inside of stopwatch is


component statmach
    port (  CLK : in STD_LOGIC;
            RESET : in STD_LOGIC;
	       STRTSTOP : in STD_LOGIC;
		  locked : std_logic;
	       CLKEN : out STD_LOGIC;
	       RST : out STD_LOGIC);
end component;

	COMPONENT dcm1
	PORT(
		RST_IN : IN std_logic;
		CLKIN_IN : IN std_logic;          
		LOCKED_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic
		);
	END COMPONENT;

component tenths
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	Q_THRESH0: OUT std_logic;
	CE: IN std_logic;
	AINIT: IN std_logic);
end component;

-- FPGA Express Black Box declaration
attribute fpga_dont_touch: string;
attribute fpga_dont_touch of tenths: component is "true";

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of tenths: component is true;

component decode port (
			binary: in std_logic_vector(3 downto 0);
			one_hot: out std_logic_vector(9 downto 0));
end component;

component cnt60
    port (  CE : in STD_LOGIC;
		  CLK : in STD_LOGIC;
	   	  CLR : in STD_LOGIC;
		  LSBSEC : out STD_LOGIC_VECTOR(3 downto 0);
		  MSBSEC : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component hex2led
    port (  HEX : in STD_LOGIC_VECTOR(3 downto 0);
	   	  LED : out STD_LOGIC_VECTOR(6 downto 0));
end component;

signal strtstopinv : STD_LOGIC;
signal clkenable : STD_LOGIC;
signal rstint : STD_LOGIC;
signal xcountout : STD_LOGIC_VECTOR(9 downto 0);
signal xtermcnt : STD_LOGIC;
signal cnt60enable : STD_LOGIC;
signal lsbcnt : STD_LOGIC_VECTOR(3 downto 0);
signal msbcnt : STD_LOGIC_VECTOR(3 downto 0);
signal Q: std_logic_vector(3 downto 0);
signal clk_dcm : std_logic;
signal dcm_lock : std_logic;

begin

MACHINE:statmach port map(CLK=>clk_dcm,
	                  RESET=>RESET,
	                  STRTSTOP=>strtstopinv,
				   locked => dcm_lock,
	                  CLKEN=>clkenable,
	                  RST=>rstint);

	Inst_dcm1: dcm1 PORT MAP(
		RST_IN => reset,
		CLKIN_IN => clk,
		LOCKED_OUT => dcm_lock,
		CLK0_OUT => clk_dcm,
		CLKIN_IBUFG_OUT => open 
	);


XCOUNTER : tenths
		port map (
			Q => Q,
			CLK => CLK_dcm,
			Q_THRESH0 => xtermcnt,
			CE => clkenable,
			AINIT => rstint);


decoder: decode port map (
			binary => Q,
			one_hot => xcountout);

sixty: cnt60 port map(CE=>cnt60enable,
				  CLK=>clk_dcm,
				  CLR=>rstint,
				  LSBSEC=>lsbcnt,
				  MSBSEC=>msbcnt);

lsbled:hex2led port map(HEX=>lsbcnt,
				    LED=>ONESOUT);

msbled:hex2led port map(HEX=>msbcnt,
				    LED=>TENSOUT);
			
	cnt60enable <= xtermcnt and clkenable;
	TENTHSOUT <= not(xcountout);
	strtstopinv <= not(STRTSTOP);

end inside;

