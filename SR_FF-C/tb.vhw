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
-- /___/   /\     Timestamp : Thu Jan 14 13:50:14 2021
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

    COMPONENT SRFF
        PORT (
            CLK : In std_logic;
            S : In std_logic;
            R : In std_logic;
            Q : InOut std_logic;
            Q_BAR : InOut std_logic
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '1';
    SIGNAL S : std_logic := '0';
    SIGNAL R : std_logic := '0';
    SIGNAL Q : std_logic := '0';
    SIGNAL Q_BAR : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : SRFF
        PORT MAP (
            CLK => CLK,
            S => S,
            R => R,
            Q => Q,
            Q_BAR => Q_BAR
        );

        PROCESS
            BEGIN
                -- -------------  Current Time:  20ns
                WAIT FOR 20 ns;
                CLK <= '0';
                S <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  40ns
                WAIT FOR 20 ns;
                CLK <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  60ns
                WAIT FOR 20 ns;
                CLK <= '0';
                S <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  80ns
                WAIT FOR 20 ns;
                CLK <= '1';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  100ns
                WAIT FOR 20 ns;
                CLK <= '0';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  120ns
                WAIT FOR 20 ns;
                CLK <= '1';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  140ns
                WAIT FOR 20 ns;
                CLK <= '0';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  160ns
                WAIT FOR 20 ns;
                CLK <= '1';
                S <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  180ns
                WAIT FOR 20 ns;
                CLK <= '0';
                S <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  680ns
                WAIT FOR 500 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  800ns
                WAIT FOR 120 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  920ns
                WAIT FOR 120 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1040ns
                WAIT FOR 120 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1160ns
                WAIT FOR 120 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1280ns
                WAIT FOR 120 ns;
                R <= '0';

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

