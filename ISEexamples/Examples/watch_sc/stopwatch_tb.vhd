LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY stopwatch_tb IS
END stopwatch_tb;

ARCHITECTURE testbench_arch OF stopwatch_tb IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 93
FILE RESULTS: TEXT IS OUT "results.txt";
	COMPONENT stopwatch
		PORT (
			clk : In  std_logic;
			reset : In  std_logic;
			strtstop : In  std_logic;
			onesout : Out  std_logic_vector (6 DOWNTO 0);
			tensout : Out  std_logic_vector (6 DOWNTO 0);
			tenthsout : Out  std_logic_vector (9 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clk : std_logic;
	SIGNAL reset : std_logic;
	SIGNAL strtstop : std_logic;
	SIGNAL onesout : std_logic_vector (6 DOWNTO 0);
	SIGNAL tensout : std_logic_vector (6 DOWNTO 0);
	SIGNAL tenthsout : std_logic_vector (9 DOWNTO 0);

BEGIN
	UUT : stopwatch
	PORT MAP (
		clk => clk,
		reset => reset,
		strtstop => strtstop,
		onesout => onesout,
		tensout => tensout,
		tenthsout => tenthsout
	);

	PROCESS -- clock process for clk,
	BEGIN
		CLOCK_LOOP : LOOP
		clk <= transport '0';
		WAIT FOR 2 ns;
		clk <= transport '1';
		WAIT FOR 3 ns;
		WAIT FOR 2 ns;
		clk <= transport '0';
		WAIT FOR 3 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS   -- Process for clk
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_tensout(
			next_tensout : std_logic_vector (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (tensout /= next_tensout) THEN 
				STD.TEXTIO.write(TX_LOC,string'("Error at time="));
				STD.TEXTIO.write(TX_LOC, TX_TIME);
				STD.TEXTIO.write(TX_LOC,string'("ns tensout="));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, tensout);
				STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_tensout);
				STD.TEXTIO.write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				STD.TEXTIO.writeline(results, TX_LOC);
				STD.TEXTIO.Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_onesout(
			next_onesout : std_logic_vector (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (onesout /= next_onesout) THEN 
				STD.TEXTIO.write(TX_LOC,string'("Error at time="));
				STD.TEXTIO.write(TX_LOC, TX_TIME);
				STD.TEXTIO.write(TX_LOC,string'("ns onesout="));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, onesout);
				STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_onesout);
				STD.TEXTIO.write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				STD.TEXTIO.writeline(results, TX_LOC);
				STD.TEXTIO.Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_tenthsout(
			next_tenthsout : std_logic_vector (9 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (tenthsout /= next_tenthsout) THEN 
				STD.TEXTIO.write(TX_LOC,string'("Error at time="));
				STD.TEXTIO.write(TX_LOC, TX_TIME);
				STD.TEXTIO.write(TX_LOC,string'("ns tenthsout="));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, tenthsout);
				STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
				IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_tenthsout);
				STD.TEXTIO.write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				STD.TEXTIO.writeline(results, TX_LOC);
				STD.TEXTIO.Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		BEGIN
		-- --------------------
		strtstop <= transport '1';
		reset <= transport '1';
		-- --------------------
		WAIT FOR 20 ns; -- Time=20 ns
		reset <= transport '0';
		-- --------------------
		WAIT FOR 30 ns; -- Time=50 ns
		strtstop <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=150 ns
		strtstop <= transport '1';
		-- --------------------
		WAIT FOR 40 ns; -- Time=190 ns
		strtstop <= transport '0';
		-- --------------------
		WAIT FOR 60 ns; -- Time=250 ns
		reset <= transport '0';
		-- --------------------
		WAIT FOR 40 ns; -- Time=290 ns
		reset <= transport '1';
		-- --------------------
		WAIT FOR 80 ns; -- Time=370 ns
		reset <= transport '0';
		-- --------------------
		WAIT FOR 130 ns; -- Time=500 ns
		strtstop <= transport '0';
		-- --------------------
		WAIT FOR 300 ns; -- Time=800 ns
		strtstop <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=900 ns
		strtstop <= transport '0';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1000 ns
		strtstop <= transport '1';
		-- --------------------
		WAIT FOR 100 ns; -- Time=1100 ns
		strtstop <= transport '0';
		-- --------------------
		WAIT FOR 212 ns; -- Time=1312 ns
		-- --------------------

		IF (TX_ERROR = 0) THEN 
			STD.TEXTIO.write(TX_OUT,string'("No errors or warnings"));
			STD.TEXTIO.writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Simulation successful (not a failure).  No problems detected. "
				SEVERITY FAILURE;
		ELSE
			STD.TEXTIO.write(TX_OUT, TX_ERROR);
			STD.TEXTIO.write(TX_OUT, string'(
				" errors found in simulation"));
			STD.TEXTIO.writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Errors found during simulation"
				SEVERITY FAILURE;
		END IF;
	END PROCESS;
END testbench_arch;

CONFIGURATION stopwatch_cfg OF stopwatch_tb IS
	FOR testbench_arch
	END FOR;
END stopwatch_cfg;
