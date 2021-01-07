/******************************************************************************
*
*    File Name:  tb_post_route.v
*      Version:  1.13
*         Date:  June 10, 1999
*        Model:  post route test bench
* Dependencies:  mt48lc2m8a1-8a.v
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 1999 Xilinx, Inc.
*                All rights reserved
*
******************************************************************************/
`timescale 1ns / 100ps
`include "micron/mt48lc1m16a1-8a.v"
`include "define.v"
module t_sdrm;
   reg [31 : 0] ad;               // Address /Data bus
   reg 		data_addr_n;      // ADS#
   reg 		we_rn;            // WE/R#
   reg 		clk;              // Clock
   reg 		reset;            // Reset
   wire 	cke;              // CKE
   wire 	cs1, cs2;         // CS
   wire [3:0] 	dqm;              // DQM
   
   wire [10:0] 	addr;
   wire [31 : 0] AD = ad;          // Address /Data bus
   wire [31 : 0] DQ;               // SDRAM Data bus
   wire 	 Reset = reset;
   wire 	 clk_con;
   
   parameter 	 hi_z = 32'bz;                   // Hi-Z
   
   sdrm sdrmc (.Reset(reset), 
			.Clkp(clk), 
			.data_addr_n(data_addr_n), 
			.we_rn(we_rn), 
			.AD(AD), 
			.Clk_FBp(clk_con), 
			.Clk_SDp(clk_con), 
			.sd_ras(ras_n), 
			.sd_cas(cas_n), 
			.sd_we(we_n), 
			.sd_data(DQ[31:0]), 
			.sd_add(addr), 
			.sd_cke(cke), 
			.sd_dqm(dqm), 
			.sd_cs1(cs1), 
			.sd_cs2(cs2), 
			.sd_ba(ba));
   
   
   mt48lc1m16a1 sdram0 (.Addr(addr), .We_n(we_n), .Cas_n(cas_n), .Ras_n(ras_n),
			.Clk(clk_con), .Cke(cke), .Cs_n(cs1), .Dqm(dqm[1:0]), .Ba(ba),
                        .Dq(DQ[15:0]));
   
   mt48lc1m16a1 sdram1 (.Addr(addr), .We_n(we_n), .Cas_n(cas_n), .Ras_n(ras_n),
			.Clk(clk_con), .Cke(cke), .Cs_n(cs2), .Dqm(dqm[3:2]), .Ba(ba),
                        .Dq(DQ[31:16]));
   
   
   initial begin
      we_rn  = 1;
      data_addr_n  = 1;
      reset  = 1;
      ad  = hi_z;
      force glbl.GSR = 1;
      #(`CYCLE/2);
      release glbl.GSR;
      #50 reset = 0;
   end
   
   initial begin
     clk = 1;
     #5;
     clk = 0;
     #15;
     forever # (`CYCLE) clk = ~clk;
   end
   
   task addr_wr;
      input [31 : 0] address;
      begin
	 data_addr_n   = 0;
	 we_rn = 1;
	 ad  = address;
      end
   endtask
   
   task data_wr;
      input [31 : 0] data_in;
      begin
	 data_addr_n   = 1;
	 we_rn = 1;
	 ad  = data_in;
      end
   endtask
   
   task addr_rd;
      input [31 : 0] address;
      begin
	 data_addr_n   = 0;
	 we_rn = 0;
	 ad  = address;
      end
   endtask
   
   task data_rd;
      input [31 : 0] data_in;
      begin
	 data_addr_n   = 1;
	 we_rn = 0;
	 ad  = data_in;
      end
   endtask
   
   task nop;
      begin
	 data_addr_n   = 1;
	 we_rn = 0;
	 ad  = hi_z;
      end
   endtask
   
   
   initial begin
      $monitor($time,, "%b", clk, ras_n, cas_n, we_n, ba, addr, DQ );
      begin
	 #(`CYCLE); nop ;                                  // Nop
	 #( 86* `CYCLE + 0.1); addr_wr (32'h20340400);     // Precharge, load Controller MR
	 #(`CYCLE); data_wr (32'h0704a076);                // value for Controller MR
	 #(`CYCLE); nop ;                                  // Nop
         #(5 * `CYCLE); addr_wr (32'h38000000);            // Auto Refresh
         #(`CYCLE); data_wr (32'h00000000);      
         #(`CYCLE); nop ;                                  // Nop
         #(15 * `CYCLE); addr_wr (32'h38000000);           // Auto Refresh
         #(`CYCLE); data_wr (32'h00000000);                
         #(13 * `CYCLE); nop ;                             // Nop
         #( 7 * `CYCLE); addr_wr (32'h1000cc00);           // Load Mode Reg
         #(`CYCLE); data_wr (32'h00000000);                
         #(`CYCLE); nop ;                                  // Nop
         #(3 * `CYCLE); addr_wr (32'h00000000);            // Write command, row addres
         #(`CYCLE); data_wr (32'h00001001);                // first data
         #(`CYCLE); data_wr (32'h00001002);                // second data
         #(`CYCLE); data_wr (32'h00001003);                // third data
         #(`CYCLE); data_wr (32'h00001004);                // fourth data
         #(`CYCLE); data_wr (32'h00001005);                // fifth data
         #(`CYCLE); data_wr (32'h00001006);                // sixth data
         #(`CYCLE); data_wr (32'h00001007);                // seventh data
         #(`CYCLE); data_wr (32'h00001008);                // eighth data
         #(`CYCLE); nop ;                                  // Nop
         #(5 * `CYCLE); addr_wr (32'h00680000);            // Write command, row address 
         #(`CYCLE); data_wr (32'h000010f1);                // first data 
         #(`CYCLE); data_wr (32'h000010f2);                // second data
         #(`CYCLE); data_wr (32'h000010f3);                // third data
         #(`CYCLE); data_wr (32'h000010f4);                // fourth data
         #(`CYCLE); data_wr (32'h000010f5);                // fifth data
         #(`CYCLE); data_wr (32'h000010f6);                // sixth data
         #(`CYCLE); data_wr (32'h000010f7);                // seventh data
         #(`CYCLE); data_wr (32'h000010f8);                // eighth data
         #(`CYCLE); nop ;                                  // Nop
         #(30 * `CYCLE); addr_rd (32'h00000000);           // Read command, row address
         #(`CYCLE); data_rd (hi_z);                        // first data
         #(`CYCLE); data_rd (hi_z);                        // second data
         #(`CYCLE); data_rd (hi_z);                        // third data
         #(`CYCLE); data_rd (hi_z);                        // fourth data
         #(`CYCLE); data_rd (hi_z);                        // fifth data
         #(`CYCLE); data_rd (hi_z);                        // sixth data
         #(`CYCLE); data_rd (hi_z);                        // seventh data
         #(`CYCLE); data_rd (hi_z);                        // eighth data
         #(`CYCLE); nop ;                                  // Nop
         #(20 * `CYCLE); addr_rd (32'h00680000);           // Read command, row address 
         #(`CYCLE); data_rd (hi_z);                        // first data
         #(`CYCLE); data_rd (hi_z);                        // second data
         #(`CYCLE); data_rd (hi_z);                        // third data
         #(`CYCLE); data_rd (hi_z);                        // fouth data
         #(`CYCLE); data_rd (hi_z);                        // fifth data
         #(`CYCLE); data_rd (hi_z);                        // sixth data
         #(`CYCLE); data_rd (hi_z);                        // seventh data
	 #(`CYCLE); data_rd (hi_z);                        // eighth data
         #(`CYCLE); nop ;                                  // Nop
         #(13 * `CYCLE); addr_wr (32'h20340400);           // Load CTRL:
         #(`CYCLE); data_wr (32'h0704a006);      
         #(`CYCLE); nop ;                                  // Nop
         #( 7 * `CYCLE); addr_wr (32'h1000c000);           // Load Mode Reg, burst length=1
         #(`CYCLE); data_wr (32'h00000000);                
         #(`CYCLE); nop ;                                  // Nop
         #(20 * `CYCLE); addr_rd (32'h00680000);           // Read, row address
         #(`CYCLE); data_rd (hi_z);                        // first data
         #(`CYCLE); nop ;                                  // Nop
         #(`CYCLE); nop ;                                  // Nop
         #(20 * `CYCLE); addr_rd (32'h00000000);           // Read, row address
         #(`CYCLE); data_rd (hi_z);                        // first data
         #(`CYCLE); nop ;                                  // Nop
         #(`CYCLE); nop ;                                  // Nop
         #(300 * `CYCLE);
      end
      $stop;
end
`include "string_decode_post_route.v"

/*********************************************************************************************
* Note: The File->Save Project As.. operation of Project Navigator does not copy 
*           files included with the `include statement.  If this example is saved to
*           a new location, the user should copy all "included" files manually.
*********************************************************************************************/
endmodule


