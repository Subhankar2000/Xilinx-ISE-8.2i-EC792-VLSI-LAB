--  E:\DATA\EXAMPLES\WATCH_SC\STMACH_V.vhd
--  VHDL code created by Xilinx's StateCAD 6.2i
--  Mon Mar 08 13:56:56 2004

--  This VHDL code (for use with Xilinx XST) was generated using: 
--  binary encoded state assignment with structured code format.
--  Minimization is disabled,  implied else is enabled, 
--  and outputs are manually optimized.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY STMACH_V IS
	PORT (CLK,DCM_lock,reset,strtstop: IN std_logic;
		clken,rst : OUT std_logic);
END;

ARCHITECTURE BEHAVIOR OF STMACH_V IS
	SIGNAL sreg : std_logic_vector (2 DOWNTO 0);
	SIGNAL next_sreg : std_logic_vector (2 DOWNTO 0);
	CONSTANT clear : std_logic_vector (2 DOWNTO 0) :="000";
	CONSTANT counting : std_logic_vector (2 DOWNTO 0) :="001";
	CONSTANT start : std_logic_vector (2 DOWNTO 0) :="010";
	CONSTANT stop : std_logic_vector (2 DOWNTO 0) :="011";
	CONSTANT stopped : std_logic_vector (2 DOWNTO 0) :="100";
	CONSTANT zero : std_logic_vector (2 DOWNTO 0) :="101";

BEGIN
	PROCESS (CLK, DCM_lock, reset, next_sreg)
	BEGIN
		IF ( reset='1' ) OR ( DCM_lock='0' ) THEN
			sreg <= clear;
		ELSIF CLK='1' AND CLK'event THEN
			sreg <= next_sreg;
		END IF;
	END PROCESS;

	PROCESS (sreg,strtstop)
	BEGIN
		clken <= '0'; rst <= '0'; 

		next_sreg<=clear;

		CASE sreg IS
			WHEN clear =>
				rst<='1';
				clken<='0';
				IF  TRUE THEN
					next_sreg<=zero;
				 ELSE
					next_sreg<=clear;
				END IF;
			WHEN counting =>
				clken<='1';
				rst<='0';
				IF  NOT ( (( strtstop='0' ) ) OR  (( strtstop='1' ) ) ) THEN
					next_sreg<=counting;
				END IF;
				IF ( strtstop='0' ) THEN
					next_sreg<=counting;
				END IF;
				IF ( strtstop='1' ) THEN
					next_sreg<=stop;
				END IF;
			WHEN start =>
				clken<='1';
				rst<='0';
				IF  NOT ( (( strtstop='1' ) ) OR  (( strtstop='0' ) ) ) THEN
					next_sreg<=start;
				END IF;
				IF ( strtstop='1' ) THEN
					next_sreg<=start;
				END IF;
				IF ( strtstop='0' ) THEN
					next_sreg<=counting;
				END IF;
			WHEN stop =>
				clken<='0';
				rst<='0';
				IF  NOT ( (( strtstop='1' ) ) OR  (( strtstop='0' ) ) ) THEN
					next_sreg<=stop;
				END IF;
				IF ( strtstop='1' ) THEN
					next_sreg<=stop;
				END IF;
				IF ( strtstop='0' ) THEN
					next_sreg<=stopped;
				END IF;
			WHEN stopped =>
				clken<='0';
				rst<='0';
				IF  NOT ( (( strtstop='0' ) ) OR  (( strtstop='1' ) ) ) THEN
					next_sreg<=stopped;
				END IF;
				IF ( strtstop='0' ) THEN
					next_sreg<=stopped;
				END IF;
				IF ( strtstop='1' ) THEN
					next_sreg<=start;
				END IF;
			WHEN zero =>
				clken<='0';
				rst<='0';
				IF  NOT ( (( strtstop='0' ) ) OR  (( strtstop='1' ) ) ) THEN
					next_sreg<=zero;
				END IF;
				IF ( strtstop='0' ) THEN
					next_sreg<=zero;
				END IF;
				IF ( strtstop='1' ) THEN
					next_sreg<=start;
				END IF;
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END BEHAVIOR;
