--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.2i
--  \   \         Application : ISE
--  /   /         Filename : tb.vhw
-- /___/   /\     Timestamp : Wed Feb 17 22:46:15 2021
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: tb
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE testbench_arch OF tb IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT siso_reg
        PORT (
            CLK : In std_logic;
            PRE_SET : In std_logic;
            CLEAR : In std_logic;
            SI : In std_logic;
            SO : Out std_logic
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL PRE_SET : std_logic := '0';
    SIGNAL CLEAR : std_logic := '0';
    SIGNAL SI : std_logic := '0';
    SIGNAL SO : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 160 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : siso_reg
        PORT MAP (
            CLK => CLK,
            PRE_SET => PRE_SET,
            CLEAR => CLEAR,
            SI => SI,
            SO => SO
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            PROCEDURE CHECK_SO(
                next_SO : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (SO /= next_SO) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns SO="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, SO);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_SO);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  65ns
                WAIT FOR 65 ns;
                SI <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  225ns
                WAIT FOR 160 ns;
                SI <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 160 ns;
                SI <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  705ns
                WAIT FOR 320 ns;
                SI <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  865ns
                WAIT FOR 160 ns;
                SI <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1345ns
                WAIT FOR 480 ns;
                SI <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1505ns
                WAIT FOR 160 ns;
                SI <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2145ns
                WAIT FOR 640 ns;
                CLEAR <= '1';
                SI <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2305ns
                WAIT FOR 160 ns;
                CLEAR <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2465ns
                WAIT FOR 160 ns;
                PRE_SET <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2625ns
                WAIT FOR 160 ns;
                PRE_SET <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2945ns
                WAIT FOR 320 ns;
                CLEAR <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3105ns
                WAIT FOR 160 ns;
                CLEAR <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3265ns
                WAIT FOR 160 ns;
                PRE_SET <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3585ns
                WAIT FOR 320 ns;
                PRE_SET <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  3905ns
                WAIT FOR 320 ns;
                CLEAR <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  4065ns
                WAIT FOR 160 ns;
                CLEAR <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4225ns
                WAIT FOR 160 ns;
                PRE_SET <= '1';
                -- -------------------------------------
                WAIT FOR 335 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

