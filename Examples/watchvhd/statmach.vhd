--  D:\XILINX\ISEEXAMPLES\WATCH_SC\STMACH_V.vhd
--  VHDL code created by Visual Software Solution's StateCAD 5.02.x4
--  Thu Jun 01 13:28:21 2000

--  This VHDL code (for use with Synopsys) was generated using: 
--  binary encoded state assignment with structured code format.
--  Minimization is disabled,  implied else is enabled, 
--  and outputs are manually optimized.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY STATMACH IS
	PORT (CLK,reset,strtstop,locked: IN std_logic;
		clken,rst : OUT std_logic);
END;

ARCHITECTURE BEHAVIOR OF STATMACH IS
	SIGNAL sreg : std_logic_vector (2 DOWNTO 0);
	SIGNAL next_sreg : std_logic_vector (2 DOWNTO 0);
	CONSTANT CLEAR : std_logic_vector (2 DOWNTO 0) :="000";
	CONSTANT counting : std_logic_vector (2 DOWNTO 0) :="001";
	CONSTANT start : std_logic_vector (2 DOWNTO 0) :="010";
	CONSTANT stop : std_logic_vector (2 DOWNTO 0) :="011";
	CONSTANT stopped : std_logic_vector (2 DOWNTO 0) :="100";
	CONSTANT zero : std_logic_vector (2 DOWNTO 0) :="101";

BEGIN
	PROCESS (CLK, reset, next_sreg)
	BEGIN
		IF ( reset='1' ) THEN
			sreg <= CLEAR;
		ELSIF CLK='1' AND CLK'event THEN
			sreg <= next_sreg;
		END IF;
	END PROCESS;

	PROCESS (sreg,strtstop,locked)
	BEGIN
		clken <= '0'; rst <= '0'; 

		next_sreg<=CLEAR;

		CASE sreg IS
			WHEN CLEAR =>
				clken<='0';
				rst<='1';
				next_sreg<=zero;
			WHEN counting =>
				clken<='1';
				rst<='0';
				IF ( strtstop='0' and locked = '1' ) THEN
					next_sreg<=counting;
				else
					next_sreg<=stop;
				END IF;
			WHEN start =>
				clken<='1';
				rst<='0';
				IF ( strtstop='0' and locked = '1' ) THEN
					next_sreg<=counting;
				else
					next_sreg<=start;
				END IF;
			WHEN stop =>
				clken<='0';
				rst<='0';
				IF ( strtstop='0') THEN
					next_sreg<=stopped;
				else
				     next_sreg<=stop;
				END IF;
			WHEN stopped =>
				clken<='0';
				rst<='0';
				IF ( strtstop='1' and locked = '1') THEN
					next_sreg<=start;
				else
					next_sreg<=stopped;
				END IF;
			WHEN zero =>
				clken<='0';
				rst<='0';
				IF ( strtstop='1' and locked = '1') THEN
					next_sreg<=start;
				else
					next_sreg<=zero;
				END IF;
			WHEN OTHERS =>
				next_sreg<=CLEAR;
		END CASE;
	END PROCESS;
END BEHAVIOR;
