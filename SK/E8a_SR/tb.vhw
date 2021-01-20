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
-- /___/   /\     Timestamp : Fri Jan 15 19:08:46 2021
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

    COMPONENT E8a_SR
        PORT (
            CLK : In std_logic;
            S : In std_logic;
            R : In std_logic;
            Q : InOut std_logic;
            Q_BAR : InOut std_logic
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL S : std_logic := '0';
    SIGNAL R : std_logic := '0';
    SIGNAL Q : std_logic := '0';
    SIGNAL Q_BAR : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : E8a_SR
        PORT MAP (
            CLK => CLK,
            S => S,
            R => R,
            Q => Q,
            Q_BAR => Q_BAR
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
            BEGIN
                -- -------------  Current Time:  85ns
                WAIT FOR 85 ns;
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  185ns
                WAIT FOR 100 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  485ns
                WAIT FOR 300 ns;
                S <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  585ns
                WAIT FOR 100 ns;
                S <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  885ns
                WAIT FOR 300 ns;
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  985ns
                WAIT FOR 100 ns;
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1085ns
                WAIT FOR 100 ns;
                S <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1185ns
                WAIT FOR 100 ns;
                S <= '0';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1285ns
                WAIT FOR 100 ns;
                S <= '1';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1385ns
                WAIT FOR 100 ns;
                S <= '0';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1485ns
                WAIT FOR 100 ns;
                S <= '1';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1685ns
                WAIT FOR 200 ns;
                S <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1785ns
                WAIT FOR 100 ns;
                S <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1885ns
                WAIT FOR 100 ns;
                S <= '0';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1985ns
                WAIT FOR 100 ns;
                S <= '1';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2085ns
                WAIT FOR 100 ns;
                S <= '0';
                R <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2185ns
                WAIT FOR 100 ns;
                S <= '1';
                R <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2285ns
                WAIT FOR 100 ns;
                S <= '0';
                R <= '1';
                -- -------------------------------------
                WAIT FOR 315 ns;

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

