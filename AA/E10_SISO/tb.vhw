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
-- /___/   /\     Timestamp : Tue Feb 09 21:19:17 2021
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

    COMPONENT E10_SISO
        PORT (
            pr : In std_logic;
            clr : In std_logic;
            clk : In std_logic;
            d : In std_logic;
            q2 : Out std_logic
        );
    END COMPONENT;

    SIGNAL pr : std_logic := '1';
    SIGNAL clr : std_logic := '1';
    SIGNAL clk : std_logic := '0';
    SIGNAL d : std_logic := '0';
    SIGNAL q2 : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : E10_SISO
        PORT MAP (
            pr => pr,
            clr => clr,
            clk => clk,
            d => d,
            q2 => q2
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            PROCEDURE CHECK_q2(
                next_q2 : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (q2 /= next_q2) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns q2="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, q2);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_q2);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  85ns
                WAIT FOR 85 ns;
                d <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  285ns
                WAIT FOR 200 ns;
                d <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  485ns
                WAIT FOR 200 ns;
                d <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  885ns
                WAIT FOR 400 ns;
                d <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1085ns
                WAIT FOR 200 ns;
                d <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  1685ns
                WAIT FOR 600 ns;
                d <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1885ns
                WAIT FOR 200 ns;
                d <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2085ns
                WAIT FOR 200 ns;
                clr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2485ns
                WAIT FOR 400 ns;
                pr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2685ns
                WAIT FOR 200 ns;
                clr <= '0';
                d <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  2885ns
                WAIT FOR 200 ns;
                clr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  3885ns
                WAIT FOR 1000 ns;
                pr <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4085ns
                WAIT FOR 200 ns;
                pr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  4285ns
                WAIT FOR 200 ns;
                clr <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  4485ns
                WAIT FOR 200 ns;
                clr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  4685ns
                WAIT FOR 200 ns;
                pr <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  5085ns
                WAIT FOR 400 ns;
                pr <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  5285ns
                WAIT FOR 200 ns;
                clr <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  5485ns
                WAIT FOR 200 ns;
                clr <= '1';
                -- -------------------------------------
                WAIT FOR 715 ns;

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

