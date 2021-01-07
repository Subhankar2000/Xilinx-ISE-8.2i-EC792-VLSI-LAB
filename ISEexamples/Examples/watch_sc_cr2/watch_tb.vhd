LIBRARY  ieee;

LIBRARY  UNISIM;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE UNISIM.Vcomponents.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT stopwatch
		PORT (
			CDRST : IN  STD_LOGIC;
			CLKIN : IN  STD_LOGIC;
			RST : IN  STD_LOGIC;
			STRTSTOP : IN  STD_LOGIC;
			TENTHSOUT : OUT  STD_LOGIC_VECTOR (9 DOWNTO 0);
			onesout : OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
			tensout : OUT  STD_LOGIC_VECTOR (6 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL CDRST : STD_LOGIC;
	SIGNAL CLKIN : STD_LOGIC;
	SIGNAL RST : STD_LOGIC;
	SIGNAL STRTSTOP : STD_LOGIC;
	SIGNAL TENTHSOUT : STD_LOGIC_VECTOR (9 DOWNTO 0);
	SIGNAL onesout : STD_LOGIC_VECTOR (6 DOWNTO 0);
	SIGNAL tensout : STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	UUT : stopwatch
	PORT MAP (
		CDRST => CDRST,
		CLKIN => CLKIN,
		RST => RST,
		STRTSTOP => STRTSTOP,
		TENTHSOUT => TENTHSOUT,
		onesout => onesout,
		tensout => tensout
	);

	PROCESS -- clock process
	BEGIN
		CLOCK_LOOP : LOOP
		CLKIN <= transport '0';
		WAIT FOR 5 ns;
		CLKIN <= transport '1';
		WAIT FOR 5 ns;
		WAIT FOR 5 ns;
		CLKIN <= transport '0';
		WAIT FOR 5 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

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

		PROCEDURE CHECK_onesout(
			next_onesout : STD_LOGIC_VECTOR (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (onesout /= next_onesout) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns onesout="));
				write(TX_LOC, onesout);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_onesout);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_tensout(
			next_tensout : STD_LOGIC_VECTOR (6 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (tensout /= next_tensout) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns tensout="));
				write(TX_LOC, tensout);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_tensout);
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
		CDRST <= transport '1';
		RST <= transport '1';
		STRTSTOP <= transport '0';
		-- --------------------
		WAIT FOR 20 ns; -- Time=20 ns
		CDRST <= transport '0';
		RST <= transport '0';
		STRTSTOP <= transport '1';
		-- --------------------
		WAIT FOR 280 ns; -- Time=300 ns
		STRTSTOP <= transport '0';
		-- --------------------
		WAIT FOR 320 ns; -- Time=620 ns
		STRTSTOP <= transport '1';
		-- --------------------
		WAIT FOR 100000 ns; -- Time=1275 ns
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

CONFIGURATION stopwatch_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END stopwatch_cfg;
