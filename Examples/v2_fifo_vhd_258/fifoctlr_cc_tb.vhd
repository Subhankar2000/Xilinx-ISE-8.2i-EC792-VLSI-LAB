-- D:\PROJECTS\GOLDEN_SAMPLE_PROJECTS\V2_FIFO_VHD_258\FIFOCTLR_CC_TB.VHD
-- VHDL Test Bench created by HDL Bencher 1.02
-- Mon Feb 05 11:59:49 2001

LIBRARY  ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY  UNISIM;
USE UNISIM.VCOMPONENTS.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY tb_cc IS
END tb_cc;

ARCHITECTURE tb_cc_arch OF tb_cc IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT fifoctlr_cc_v2
		PORT (
			clock_in : IN  std_logic;
			read_enable_in : IN  std_logic;
			write_enable_in : IN  std_logic;
			write_data_in : IN  std_logic_vector (35 DOWNTO 0);
			fifo_gsr_in : IN  std_logic;
			read_data_out : OUT  std_logic_vector (35 DOWNTO 0);
			full_out : OUT  std_logic;
			empty_out : OUT  std_logic;
			fifocount_out : OUT  std_logic_vector (3 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL clock_in : std_logic;
	SIGNAL read_enable_in : std_logic;
	SIGNAL write_enable_in : std_logic;
	SIGNAL write_data_in : std_logic_vector (35 DOWNTO 0);
	SIGNAL fifo_gsr_in : std_logic;
	SIGNAL read_data_out : std_logic_vector (35 DOWNTO 0);
	SIGNAL full_out : std_logic;
	SIGNAL empty_out : std_logic;
	SIGNAL fifocount_out : std_logic_vector (3 DOWNTO 0);

BEGIN
	UUT : fifoctlr_cc_v2
	PORT MAP (
		clock_in => clock_in,
		read_enable_in => read_enable_in,
		write_enable_in => write_enable_in,
		write_data_in => write_data_in,
		fifo_gsr_in => fifo_gsr_in,
		read_data_out => read_data_out,
		full_out => full_out,
		empty_out => empty_out,
		fifocount_out => fifocount_out
	);

	PROCESS
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_read_data_out(
			next_read_data_out : std_logic_vector (35 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 512);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (read_data_out /= next_read_data_out) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns read_data_out="));
				write(TX_LOC, read_data_out);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_read_data_out);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_full_out(
			next_full_out : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 512);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (full_out /= next_full_out) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns full_out="));
				write(TX_LOC, full_out);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_full_out);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_empty_out(
			next_empty_out : std_logic;
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 512);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (empty_out /= next_empty_out) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns empty_out="));
				write(TX_LOC, empty_out);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_empty_out);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		PROCEDURE CHECK_fifocount_out(
			next_fifocount_out : std_logic_vector (3 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 512);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (fifocount_out /= next_fifocount_out) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns fifocount_out="));
				write(TX_LOC, fifocount_out);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_fifocount_out);
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
		clock_in <= transport '0';
		read_enable_in <= transport '0';
		write_enable_in <= transport '0';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		fifo_gsr_in <= transport '1';
		-- --------------------
		WAIT FOR 8 ns; -- Time=8 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=20 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=28 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=40 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=48 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=60 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=68 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=80 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=88 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=100 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=108 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=120 ns
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 8 ns; -- Time=128 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=140 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=148 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=160 ns
		write_enable_in <= transport '1';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 8 ns; -- Time=168 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=180 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=188 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=200 ns
		write_enable_in <= transport '1';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 8 ns; -- Time=208 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=220 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=228 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=240 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000001"); --1
		-- --------------------
		WAIT FOR 8 ns; -- Time=248 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=260 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=268 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=280 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000010"); --2
		-- --------------------
		WAIT FOR 8 ns; -- Time=288 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=300 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=308 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=320 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000011"); --3
		-- --------------------
		WAIT FOR 8 ns; -- Time=328 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=340 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=348 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=360 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000100"); --4
		-- --------------------
		WAIT FOR 8 ns; -- Time=368 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=380 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=388 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=400 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000101"); --5
		-- --------------------
		WAIT FOR 8 ns; -- Time=408 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=420 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=428 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=440 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000110"); --6
		-- --------------------
		WAIT FOR 8 ns; -- Time=448 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=460 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=468 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=480 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000111"); --7
		-- --------------------
		WAIT FOR 8 ns; -- Time=488 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=500 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=508 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=520 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001000"); --8
		-- --------------------
		WAIT FOR 8 ns; -- Time=528 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=540 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=548 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=560 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001001"); --9
		-- --------------------
		WAIT FOR 8 ns; -- Time=568 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=580 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=588 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=600 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001010"); --A
		-- --------------------
		WAIT FOR 8 ns; -- Time=608 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=620 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=628 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=640 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001011"); --B
		-- --------------------
		WAIT FOR 8 ns; -- Time=648 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=660 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=668 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=680 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001100"); --C
		-- --------------------
		WAIT FOR 8 ns; -- Time=688 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=700 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=708 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=720 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001101"); --D
		-- --------------------
		WAIT FOR 8 ns; -- Time=728 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=740 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=748 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=760 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001110"); --E
		-- --------------------
		WAIT FOR 8 ns; -- Time=768 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=780 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=788 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=800 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001111"); --F
		-- --------------------
		WAIT FOR 8 ns; -- Time=808 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=820 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=828 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=840 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010000"); --10
		-- --------------------
		WAIT FOR 8 ns; -- Time=848 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=860 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=868 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=880 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010001"); --11
		-- --------------------
		WAIT FOR 8 ns; -- Time=888 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=900 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=908 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=920 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010010"); --12
		-- --------------------
		WAIT FOR 8 ns; -- Time=928 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=940 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=948 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=960 ns
		read_enable_in <= transport '1';
		write_enable_in <= transport '0';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010011"); --13
		-- --------------------
		WAIT FOR 8 ns; -- Time=968 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=980 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=988 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1000 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1008 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1020 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1028 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1040 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1048 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1060 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1068 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1080 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1088 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1100 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1108 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1120 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1128 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1140 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1148 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1160 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1168 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1180 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1188 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1200 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1208 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1220 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1228 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1240 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1248 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1260 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1268 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1280 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1288 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1300 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1308 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1320 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1328 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1340 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1348 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1360 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1368 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1380 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1388 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1400 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1408 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1420 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1428 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1440 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1448 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1460 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1468 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1480 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1488 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1500 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1508 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1520 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1528 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1540 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1548 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1560 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1568 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1580 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1588 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1600 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1608 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1620 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1628 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1640 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1648 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1660 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1668 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1680 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1688 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1700 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1708 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1720 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1728 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1740 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1748 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1760 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1768 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1780 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1788 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1800 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1808 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1820 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1828 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1840 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1848 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1860 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1868 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1880 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1888 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1900 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1908 ns
		clock_in <= transport '0';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1920 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		-- --------------------
		WAIT FOR 8 ns; -- Time=1928 ns
		clock_in <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=1940 ns
		-- --------------------
		WAIT FOR 8 ns; -- Time=1948 ns
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
END tb_cc_arch;

CONFIGURATION fifoctlr_cc_v2_cfg OF tb_cc IS
	FOR tb_cc_arch
	END FOR;
END fifoctlr_cc_v2_cfg;
