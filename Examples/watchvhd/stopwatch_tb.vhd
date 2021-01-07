LIBRARY  IEEE;
USE IEEE.std_logic_1164.all;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS

COMPONENT stopwatch
	PORT (
		ONESOUT : out  STD_LOGIC_VECTOR (6 DOWNTO 0);
		TENSOUT : out  STD_LOGIC_VECTOR (6 DOWNTO 0);
		TENTHSOUT : out  STD_LOGIC_VECTOR (9 DOWNTO 0);
		CLK : in  STD_LOGIC;
		RESET : in  STD_LOGIC;
		STRTSTOP : in  STD_LOGIC);
END COMPONENT;

SIGNAL ONESOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
SIGNAL TENSOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
SIGNAL TENTHSOUT : STD_LOGIC_VECTOR (9 DOWNTO 0);
SIGNAL CLK : STD_LOGIC;
SIGNAL RESET : STD_LOGIC;
SIGNAL STRTSTOP : STD_LOGIC;

constant ClockPeriod : Time := 10 ns;

BEGIN

UUT : stopwatch
PORT MAP (
	CLK => CLK,
	RESET => RESET,
	STRTSTOP => STRTSTOP,
	TENTHSOUT => TENTHSOUT,
	ONESOUT => ONESOUT,
	TENSOUT => TENSOUT
);

generateclock: process
begin
	clk <= '1';
	loop
		wait for (ClockPeriod / 2);
		CLK <= not CLK;
	end loop;  
end process;

stimulus: process
begin
	--Initialize Inputs
	reset <= '1';
	strtstop <= '1';
	--Wait until the Global Set/Reset deasserts
	wait for 100 ns;
	reset <= '0';
	--Wait long enough for the DCM to lock
	wait for 900 ns;
	strtstop <= '0';
	wait;
end process stimulus;

end testbench_arch;













