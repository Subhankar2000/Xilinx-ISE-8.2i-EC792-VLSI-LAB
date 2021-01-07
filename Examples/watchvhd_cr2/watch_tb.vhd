-- H:\DESIGNS\MISC\CR2_EXAMPLES\WATCHVHD\WATCH_TB.VHW
-- VHDL Test Bench created by
-- HDL Bencher 4.1i
-- Mon Oct 29 15:14:49 2001
-- 
-- Notes:
-- 1) This testbench has been automatically generated from
--   your Test Bench Waveform
-- 2) To use this as a user modifiable testbench do the following:
--   - Save it as a file with a .vhd extension (i.e. File->Save As...)
--   - Add it to your project as a testbench source (i.e. Project->Add Source...)
-- 

LIBRARY  IEEE;
USE IEEE.std_logic_1164.all;

LIBRARY  unisim;
USE unisim.vcomponents.all;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT watch
		PORT (
			RESET : in  STD_LOGIC;
			CDRST : in  STD_LOGIC;
			STRTSTOP : in  STD_LOGIC;
			CLK : in  STD_LOGIC;
			TENSOUT : out  STD_LOGIC_VECTOR (6 DOWNTO 0);
			ONESOUT : out  STD_LOGIC_VECTOR (6 DOWNTO 0);
			TENTHSOUT : out  STD_LOGIC_VECTOR (9 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL RESET : STD_LOGIC;
	SIGNAL CDRST : STD_LOGIC;
	SIGNAL STRTSTOP : STD_LOGIC;
	SIGNAL CLK : STD_LOGIC;
	SIGNAL TENSOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL ONESOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL TENTHSOUT : STD_LOGIC_VECTOR (9 DOWNTO 0);

BEGIN
	UUT : watch
	PORT MAP (
		RESET => RESET,
		CDRST => CDRST,
		STRTSTOP => STRTSTOP,
		CLK => CLK,
		TENSOUT => TENSOUT,
		ONESOUT => ONESOUT,
		TENTHSOUT => TENTHSOUT
	);

	PROCESS -- clock process
	BEGIN
		CLOCK_LOOP : LOOP
		CLK <= transport '0';
		WAIT FOR 5 ns;
		CLK <= transport '1';
		WAIT FOR 5 ns;
		WAIT FOR 5 ns;
		CLK <= transport '0';
		WAIT FOR 5 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_TENSOUT(
			next_TENSOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (TENSOUT /= next_TENSOUT) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns TENSOUT="));
				write(TX_LOC, TENSOUT);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_TENSOUT);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_ONESOUT(
			next_ONESOUT : STD_LOGIC_VECTOR (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (ONESOUT /= next_ONESOUT) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns ONESOUT="));
				write(TX_LOC, ONESOUT);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_ONESOUT);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_TENTHSOUT(
			next_TENTHSOUT : STD_LOGIC_VECTOR (9 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (TENTHSOUT /= next_TENTHSOUT) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns TENTHSOUT="));
				write(TX_LOC, TENTHSOUT);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_TENTHSOUT);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		BEGIN
		-- --------------------
		RESET <= transport '1';
		CDRST <= transport '1';
		STRTSTOP <= transport '0';
		-- --------------------
		WAIT FOR 20 ns; -- Time=20 ns
		RESET <= transport '0';
		CDRST <= transport '0';
		-- --------------------
		WAIT FOR 20 ns; -- Time=40 ns
		STRTSTOP <= transport '1';
		-- --------------------
		WAIT FOR 300 ns; -- Time=3840 ns
		STRTSTOP <= transport '0';
		-- --------------------
		WAIT FOR 300 ns; -- Time=3840 ns
		STRTSTOP <= transport '1';
		-- --------------------
		WAIT FOR 100000 ns; -- Time=3855 ns
		-- --------------------

		IF (TX_ERROR = 0) THEN 
			write(TX_OUT,string'("No errors or warnings"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Simulation successful (not a failure).  No problems detected. "
				SEVERITY FAILURE;
		ELSE
			write(TX_OUT, TX_ERROR);
			write(TX_OUT, string'(
				" errors found in simulation"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Errors found during simulation"
				SEVERITY FAILURE;
		END IF;
	END PROCESS;
END testbench_arch;

CONFIGURATION watch_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END watch_cfg;
