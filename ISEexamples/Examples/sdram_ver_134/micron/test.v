/******************************************************************************
*
*    File Name:  TEST.V
*      Version:  1.0
*         Date:  May 13th, 1998
*        Model:  BUS Functional
*    Simulator:  Model Technology VLOG (PC version 4.7h)
*
* Dependencies:  MT48LC1M16B1.V
*
*       Author:  Son P. Huynh
*        Email:  sphuynh@micron.com
*        Phone:  (208) 368-3825
*      Company:  Micron Technology, Inc.
*
*  Description:  This is a testbench for MT48LC1M16A1.V
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright © 1998 Micron Semiconductor Products, Inc.
*                All rights researved
*
******************************************************************************/

`timescale 1ns / 1ps

module test;

reg         [15 : 0] dq;                            // SDRAM I/O
reg         [10 : 0] addr;                          // SDRAM Address
reg                  ba;                            // Bank Address
reg                  clk;                           // Clock
reg                  cke;                           // Synchronous Clock Enable
reg                  cs_n;                          // CS#
reg                  ras_n;                         // RAS#
reg                  cas_n;                         // CAS#
reg                  we_n;                          // WE#
reg          [1 : 0] dqm;                           // I/O Mask

wire        [15 : 0] DQ = dq;

parameter            hi_z = 16'bz;                   // Hi-Z
parameter            half_clk =  5;
parameter            full_clk = 10;

mt48lc1m16a1 sdram0 (DQ, addr, ba, clk, cke, cs_n, ras_n, cas_n, we_n, dqm);

initial begin
    clk = 1'b0;
    cke = 1'b0;
    cs_n = 1'b1;
    dq  = hi_z;
end

always #half_clk clk = ~clk;

/*
always @ (posedge clk) begin
    $strobe("at time %t clk=%b cke=%b CS#=%b RAS#=%b CAS#=%b WE#=%b dqm=%b addr=%b ba=%b DQ=%d",
            $time, clk, cke, cs_n, ras_n, cas_n, we_n, dqm, addr, ba, DQ);
end
*/

task active;
    input          bank;
    input [10 : 0] row;
    input [15 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 1;
        dqm   = 0;
        ba    = bank;
        addr  = row;
        dq    = dq_in;
    end
endtask

task auto_refresh;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 1;
        dqm   = 0;
        ba    = 0;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task burst_term;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 0;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task load_mode_reg;
    input [11 : 0] op_code;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 0;
        dqm   = 0;
        ba    = op_code [11];
        addr  = op_code [10 : 0];
        dq    = hi_z;
    end
endtask

task nop;
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 1;
        we_n  = 1;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_0;
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_1;
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 1;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_all_bank;
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 1024;            // A10 = 1
        dq    = dq_in;
    end
endtask

task read;
    input          bank;
    input [10 : 0] column;
    input [15 : 0] dq_in;
    input  [1 : 0] dqm_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 0;
        we_n  = 1;
        dqm   = dqm_in;
        ba    = bank;
        addr  = column;
        dq    = dq_in;
    end
endtask

task write;
    input          bank;
    input [10 : 0] column;
    input [15 : 0] dq_in;
    input  [1 : 0] dqm_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 0;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = bank;
        addr  = column;
        dq    = dq_in;
    end
endtask

integer Case;

initial begin
    begin
        // Pick one of the Case below for testing...
        Case = 100;

        if (Case == 0) begin
            // Figure 7-1: Consecutive Read Bursts (CL = 1, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (18);                // Load Mode: Lat = 1, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (1, 0, hi_z, 0);              // Read:  Bank = 1, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(6*full_clk);
        end

        if (Case == 1) begin
            // Figure 7-2: Consecutive Read Bursts (CL = 2, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (34);                // Load Mode: Lat = 2, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (1, 0, hi_z, 0);              // Read:  Bank = 1, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(7*full_clk);
        end

        if (Case == 2) begin
            // Figure 7-3: Consecutive Read Bursts (CL = 3, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (50);                // Load Mode: Lat = 3, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (1, 0, hi_z, 0);              // Read:  Bank = 1, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk);
        end

        else if (Case == 3) begin
            // Figure 8-1: Random Read Accesses (CL = 1, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg ('h10);                // Load Mode: Lat = 1, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); read (0, 1, hi_z, 0);              // Read:  Bank = 0, Col = 1, Dqm = 0
            #(1*full_clk); read (0, 2, hi_z, 0);              // Read:  Bank = 0, Col = 2, Dqm = 0
            #(1*full_clk); read (0, 3, hi_z, 0);              // Read:  Bank = 0, Col = 3, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(6*full_clk);
        end

        else if (Case == 4) begin
            // Figure 8-2: Random Read Accesses (CL = 2, BL = 1)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (34);                // Load Mode: Lat = 2, BL = 1, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); nop (0, hi_z);
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); read (0, 1, hi_z, 0);              // Read:  Bank = 0, Col = 1, Dqm = 0
            #(1*full_clk); read (0, 2, hi_z, 0);              // Read:  Bank = 0, Col = 2, Dqm = 0
            #(1*full_clk); read (0, 3, hi_z, 0);              // Read:  Bank = 0, Col = 3, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(7*full_clk);
        end

        else if (Case == 5) begin
            // Figure 8-3: Random Read Accesses (CL = 3, BL = 1)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (48);                // Load Mode: Lat = 3, BL = 1, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); read (0, 1, hi_z, 0);              // Read:  Bank = 0, Col = 1, Dqm = 0
            #(1*full_clk); read (0, 2, hi_z, 0);              // Read:  Bank = 0, Col = 2, Dqm = 0
            #(1*full_clk); read (0, 3, hi_z, 0);              // Read:  Bank = 0, Col = 3, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk);
        end

        else if (Case == 6) begin
            // Figure 9: Read to Write (CL = 3, BL = 1)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (48);                // Load Mode: Lat = 3, BL = 1, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (1, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (3, hi_z);                     // Nop
            #(1*full_clk); nop (3, hi_z);                     // Nop
            #(1*full_clk); write (0, 0, 100, 0);              // Write : Bank = 0, Col = 0, Data = 100, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk);
        end

        else if (Case == 7) begin
            // Figure 10: Read to Write with extra clock cycle (CL = 3, BL = 1)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (48);                // Load Mode: Lat = 3, BL = 1, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read (1, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (3, hi_z);                     // Nop
            #(1*full_clk); nop (3, hi_z);                     // Nop
            #(1*full_clk); nop (3, hi_z);                     // Nop
            #(1*full_clk); write (0, 0, 100, 0);              // Write : Bank = 0, Col = 0, Data = 100, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk);
        end

        else if (Case == 8) begin
            // Figure 11-1 : Read to Precharge (CL = 1, BL = 8)
            #10; nop (0, hi_z);                     // Nop
            #90; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #20; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; load_mode_reg (19);                // Load Mode: Lat = 1, BL = 8, Seq
            #10; nop (0, hi_z);                     // Nop
            #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #10; nop (0, hi_z);
            #10; nop (0, hi_z);
            #10; read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #30;
        end

        else if (Case == 9) begin
            // Figure 11-2 : Read to Precharge (CL = 2, BL = 8)
            #10; nop (0, hi_z);                     // Nop
            #90; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #20; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; load_mode_reg (35);                // Load Mode: Lat = 2, BL = 8, Seq
            #10; nop (0, hi_z);                     // Nop
            #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #10; nop (0, hi_z);
            #10; nop (0, hi_z);
            #10; read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #30;
        end

        else if (Case == 10) begin
            // Figure 11-3 : Read to Precharge (CL = 3, BL = 8)
            #10; nop (0, hi_z);                     // Nop
            #90; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #20; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; auto_refresh;                      // Auto Refresh
            #10; nop (0, hi_z);                     // Nop
            #80; load_mode_reg (51);                // Load Mode: Lat = 3, BL = 8, Seq
            #10; nop (0, hi_z);                     // Nop
            #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #10; nop (0, hi_z);
            #10; nop (0, hi_z);
            #10; read (0, 0, hi_z, 0);              // Read:  Bank = 0, Col = 0, Dqm = 0
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; nop (0, hi_z);                     // Nop
            #10; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop (0, hi_z);                     // Nop
            #30;
        end

        if (Case == 11) begin
            // Alternate bank Write-Read accesses (CL = 2, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (34);                // Load Mode: Lat = 3, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (0, 1024, 10, 0);           // Write : Bank = 0, Col = 0, Dqm = 0 (AutoPrecharge)
            #(1*full_clk); nop (0, 11);                       // Nop
            #(1*full_clk); active (1, 0, 12);                 // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, 13);                       // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); write (1, 1024, 20, 0);            // Write : Bank = 1, Col = 0, Dqm = 0 (AutoPrecharge)
            #(1*full_clk); nop (0, 21);                       // Nop
            #(1*full_clk); active (0, 0, 22);                 // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, 23);                       // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop

            #(1*full_clk); read(0, 1024, hi_z, 0);            // Read  : Bank = 0, Col = 0, Dqm = 0 (AutoPrecharge)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); read(1, 1024, hi_z, 0);            // Read  : Bank = 1, Col = 0, Dqm = 0 (AutoPrecharge)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(6*full_clk);
        end

        else if (Case == 97) begin
            // Write with DQM  (CL = 3, BL = 4)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (50);                // Load Mode: Lat = 3, BL = 4, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (0, 0, 16'h1234, 0);        // Write : Bank = 0, Col = 0, Dqm = 00
            #(1*full_clk); nop (1, 16'h4568);                 // Nop                        Dqm = 01
            #(1*full_clk); nop (2, 16'h9abc);                 // Nop                        Dqm = 10
            #(1*full_clk); nop (3, 16'hdef0);                 // Nop                        Dqm = 11
            #(1*full_clk); nop (0, hi_z);                     // Nop
            // Read back to check result
            #(1*full_clk); read(0, 0, hi_z, 0);               // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(3*full_clk);
        end

        else if (Case == 98) begin
            // Full Page Read and Write with Burst Terminate (CL = 3, BL = FULL)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (55);                // Load Mode: Lat = 3, BL = FULL, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (0, 0, 100, 0);             // Write : Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, 101);                      // Nop
            #(1*full_clk); nop (0, 102);                      // Nop
            #(1*full_clk); nop (0, 103);                      // Nop
            #(1*full_clk); nop (0, 104);                      // Nop
            #(1*full_clk); nop (0, 105);                      // Nop
            #(1*full_clk); nop (0, 106);                      // Nop
            #(1*full_clk); burst_term;                        // Burst Terminate

            #(1*full_clk); read(0, 0, hi_z, 0);               // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); burst_term;                        // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(3*full_clk);
        end

        else if (Case == 99) begin
            // Random Burst Read Single Write Accesses (CL = 2, BL = 8)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg (547);               // Load Mode: Lat = 2, BL = 8, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (0, 1025, 100, 0);          // Write : Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop

            #(3*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (0, 1026, 101, 0);          // Write : Bank = 0, Col = 0, Dqm = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop

            #(3*full_clk); active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); read   (0, 1025, hi_z, 0);         // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk);
        end

        else if (Case == 100) begin
            // Custom test case : Full Page Write to Full Page Read (CL = 2, BL = FULL)
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(9*full_clk); precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); auto_refresh;                      // Auto Refresh
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(8*full_clk); load_mode_reg ('b0100111);         // Load Mode: Lat = 2, BL = 8, Seq
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); active (1, 0, hi_z);               // Active: Bank = 1, Row =   0
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(2*full_clk); write  (1, 253, 253, 0);           // Write : Bank = 0, Col = 253, Dqm = 0
            #(1*full_clk); nop (0, 254);                      // Nop
            #(1*full_clk); nop (0, 255);                      // Nop
            #(1*full_clk); burst_term;                        // Burst Terminate
            #(1*full_clk); read (1, 253, hi_z, 0);            // Read  : Bank = 1, Col = 253
            //#(1*full_clk); nop (0, hi_z);                     // Nop
            //#(1*full_clk); nop (0, hi_z);                     // Nop
            #(1*full_clk); precharge_bank_1 (0, hi_z);        // Prech : Bank = 1
            //#(1*full_clk); burst_term;                        // Burst Terminate
            #(1*full_clk); nop (0, hi_z);                     // Nop
            #(4*full_clk);
        end

    end
$stop;
$finish;
end

endmodule

