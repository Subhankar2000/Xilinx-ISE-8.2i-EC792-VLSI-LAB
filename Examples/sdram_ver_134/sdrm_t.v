/******************************************************************************
*
*    File Name:  sdrm_t.v
*      Version:  1.15
*         Date:  Sept 19, 2005
*  Description:  SDRAM Controller
* Dependencies:  sdrmc_state, brst_cntr, rcd_cntr, ref_cntr, cslt_cntr, ki_cntr
*
*      Company:  Xilinx
*
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 1998-2005 Xilinx, Inc.
*                All rights reserved
*
******************************************************************************/
`timescale 1ns / 100ps
module sdrm_t (/*AUTOARG*/
   // Outputs
   sd_add_o, sd_ras_o, sd_cas_o, sd_we_o, sd_ba_o, ready_o, Locked_j, 
   Locked_i, kid, auto_ref_out, rcd_end, sd_doe_n, AD_tri, 
   // Inputs
   write_st, auto_ref_in, Locked1, Locked2, Clk_i, Clk_j, Act_st, 
   rcd_c_max, cas_lat_max, burst_max, ki_max, ref_max, Add_reg
   );

   output [10:0] sd_add_o;
   output 	 sd_ras_o, sd_cas_o, sd_we_o, sd_ba_o, ready_o, Locked_j, Locked_i;
   output 	 kid, auto_ref_out, rcd_end;
   output [3:0]  sd_doe_n;
   output 	 AD_tri;
   
   input 	 write_st, auto_ref_in;
   input 	 Locked1, Locked2, Clk_i, Clk_j;
   input [2:0] 	 Act_st; 
   input [1:0] 	 rcd_c_max, cas_lat_max;
   input [2:0] 	 burst_max;
   input [3:0] 	 ki_max;
   input [15:0]  ref_max;
   input [21:2]  Add_reg;
   
   wire [21:2] 	 Add_reg;
   wire [1:0] 	 rcd_c_max, cas_lat_max;
   wire [2:0] 	 burst_max;
   wire [3:0] 	 ki_max;
   wire [15:0] 	 ref_max;
   wire [2:0] 	 Act_st;
   wire 	 brst_end_m1, pre_ld_cslt, pre_ld_brst, pre_ld_rcd, auto_ref_in;
   wire 	 rcd_end, cslt_end, brst_end, auto_ref_s, p_auto_ref, pre_clr_ref;
   wire 	 pre_sd_doe_n, pre_sd_doe2_n, pre_sd_we_p;
   wire 	 pre_sd_ras_p, pre_sd_cas_p, Hit;
   wire 	 write_st, pre_sd_add_mx, ki_end, clr_ref, kid, auto_ref_out; 
   wire 	 Clk_i, Clk_j, Locked1, Locked2, pre_locked, Locked_j;
   
   reg 		 clr_ref_d, sd_ras_o, sd_cas_o, sd_we_o, ready_o;
   reg 		 ld_cslt, ld_brst, ld_rcd, sd_ba_o, Locked_i, sd_add_mx;
   reg [10:0] 	 sd_add_o;
   reg [3:0] 	 sd_doe_n;
   reg 		 AD_tri_reg;
   
   sdrmc_state sdrm_st (.Reset(Locked_i), .Clk(Clk_i),.Act_st(Act_st), 
			.write_st(write_st), .pre_sd_ras_p(pre_sd_ras_p), 
			.pre_sd_cas_p(pre_sd_cas_p), .pre_sd_we_p(pre_sd_we_p), 
			.pre_sd_doe_n(pre_sd_doe_n),.pre_sd_doe2_n(pre_sd_doe2_n), 
			.pre_sd_add_mx(pre_sd_add_mx), .cslt_end(cslt_end), 
			.pre_ld_cslt(pre_ld_cslt), .brst_end(brst_end), 
			.pre_ld_brst(pre_ld_brst), .rcd_end(rcd_end), 
			.pre_ld_rcd(pre_ld_rcd), .auto_ref(auto_ref_in), 
			.pre_clr_ref(pre_clr_ref), .clr_ref(clr_ref), 
			.ki_end(ki_end), .pre_sd_ready(pre_sd_ready), .pre_ad_tri(pre_ad_tri)); 
   
   cslt_cntr cslt_cntr (.Reset(Locked_i), .Clk(Clk_i), .cslt_max(cas_lat_max),
			.cslt_end(cslt_end), .ld_cslt(ld_cslt));
   
   brst_cntr brst_cntr (.Reset(Locked_i), .Clk(Clk_i), .brst_max(burst_max),
			.brst_end(brst_end), .brst_end_m1(brst_end_m1), 
			.ld_brst(ld_brst));
   
   rcd_cntr rcd_cntr (.Reset(Locked_i), .Clk(Clk_i), .rcd_max(rcd_c_max),
		      .rcd_end(rcd_end), .ld_rcd(ld_rcd));
   
   ref_cntr ref_cntr ( .Reset(Locked_j), .Clk(Clk_j), .ref_max(ref_max),
		       .auto_ref(auto_ref_s), .p_auto_ref(p_auto_ref),
		       .clr_ref(clr_ref));
   
   ki_cntr ki_cntr ( .Reset(Locked_i), .Clk(Clk_i), .ki_max(ki_max),
		     .ki_end(ki_end), .ld_ki(clr_ref));

   
   //delay pre_locked signal by 5 clock periods
   SRL16 SRL16 (.Q(Locked_j), .A0(1'b0), .A1(1'b0), .A2(1'b1), .A3(1'b0), 
		.D(pre_locked), .CLK(Clk_j));

   //delay pre_ad_tri by 5 clk periods
   SRL16 I_AD_tri (.Q(AD_tri), .A0(1'b0), .A1(1'b0), .A2(1'b1), .A3(1'b0), 
		.D(pre_ad_tri), .CLK(Clk_i));
   
   assign 	 clr_ref =      clr_ref_d;
   assign 	 kid =          p_auto_ref | auto_ref_s | ~ki_end;
   assign 	 auto_ref_out = auto_ref_s;
   
   assign 	 pre_locked =  Locked1 && Locked2;
   
   always @ (posedge Clk_i)
     Locked_i <= Locked_j;
   
   always @ (posedge Clk_i or negedge Locked_i)
   begin
      if (~Locked_i)
      begin
	 sd_ras_o   <=  1'b1;
	 sd_cas_o   <=  1'b1;
	 sd_we_o    <=  1'b1;
	 sd_doe_n   <=  4'hf;
	 clr_ref_d  <=  1'b0;
	 sd_add_mx  <=  1'b0;
	 ld_cslt    <=  1'b1;
	 ld_brst    <=  1'b1;
	 ready_o    <=  1'b0;
	 ld_rcd     <=  1'b1;
	 sd_add_o   <=  11'h000;
	 sd_ba_o    <=  1'b0;
	 AD_tri_reg <=  1'b1;
      end
      else
      begin
	 ld_cslt <=  pre_ld_cslt;
	 ld_brst <=  pre_ld_brst;
	 ld_rcd  <=  pre_ld_rcd;
	 clr_ref_d <= pre_clr_ref;
	 sd_add_mx <=  pre_sd_add_mx;
	 sd_doe_n  <=  {4{~((~pre_sd_doe_n & ~brst_end_m1 & ~brst_end) | 
			    (~pre_sd_doe2_n & rcd_end ))}};
	 ready_o  <= #3 pre_sd_ready;
	 sd_ras_o <= #3 pre_sd_ras_p;
	 sd_cas_o <= #3 pre_sd_cas_p;
	 sd_we_o  <=  #3 pre_sd_we_p;
	 AD_tri_reg <= pre_ad_tri;
	 if (sd_add_mx) 
	   sd_add_o[10:0] <= #3 Add_reg[20:10];
	 else
	   sd_add_o[10:0] <= #3 {3'b101,Add_reg[9:2]};
	 sd_ba_o <= #3 Add_reg[21];
      end
   end
   
endmodule
