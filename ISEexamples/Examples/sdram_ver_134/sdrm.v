/******************************************************************************
*
*    File Name:  sdrm.v
*      Version:  1.15
*         Date:  Sept 19, 2005
*  Description:  Top level module
* Dependencies:  sdrm_t, sys_int
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
`include "define.v"
/*******************************************************************************
* Note: The File->Save Project As.. operation of Project Navigator does not copy 
*       files included with the `include statement.  If this example is saved to
*       a new location, the user should copy all "included" files manually.
*******************************************************************************/

`timescale 1ns / 100ps
module sdrm (/*AUTOARG*/
   // Outputs
   sd_add, sd_ras, sd_cas, sd_we, sd_ba, Clk_SDp, sd_cke, sd_cs1, 
   sd_cs2, sd_dqm, 
   // Inouts
   sd_data, AD, 
   // Inputs
   Reset, Clkp, Clk_FBp, we_rn, data_addr_n
   );
   
   inout [(`DATA_MSB):0] sd_data, AD;
   output [10:0] 	 sd_add;
   output 		 sd_ras, sd_cas, sd_we, sd_ba, Clk_SDp;
   output 		 sd_cke, sd_cs1, sd_cs2; 
   output [3:0] 	 sd_dqm;
   
   input 		 Reset, Clkp, we_rn, data_addr_n;
	
	(*feedback = "12ns NET Clk_SDp"*)
	input Clk_FBp;
   
   wire [(`DATA_MSB):0]  sd_data;
   wire [10:0] 		 sd_add_op;
   wire [(`DATA_MSB):0]  sd_data_i, AD, AD_i;
   wire [(`DATA_MSB):0]  sd_data_reg;
   wire 		 sd_cke_o, sd_cs1_o, sd_cs2_o, sd_ba_op, ready_o;
   wire [3:0] 		 sd_dqm_o;
   wire 		 Reset, Reset_i;
   
   reg [31:0] 		 sd_data_o;
   reg [(`DATA_MSB):0] 	 sd_data_t, sd_data_R, AD_o;
   reg [10:0] 		 sd_add_o;
   reg 				 sd_ba_o, sd_cas_o, sd_ras_o, sd_we_o;
   reg [3:0] 		 sd_doe_n;
   
   wire [3:0] 		 sd_doe_np;
   wire 		 Clkp, Clk_FBp, Clk_SDp;
   wire 		 Clk_FB, Clk_i, Clk_j, Clk0A, Clk0B, Clk0C; 
   wire 		 Locked2, Locked1, Locked_i, Locked_j, logic1, logic0, Clk;
   wire 		 sd_ras_op, sd_cas_op, sd_we_op, write_st;
   wire 		 AD_tri; 
   wire [(`ADDR_MSB):0]  Add_reg;
   reg [(`ADDR_MSB):0] 	 AD_reg;
   wire [1:0] 		 rcd_c_max, cas_lat_max;
   wire [2:0] 		 burst_max, Act_st;
   wire [3:0] 		 ki_max;
   wire [15:0] 		 ref_max;

   reg 		 data_addr_n_reg, we_rn_reg;
   wire 		 data_addr_n, data_addr_n_i, we_rn, we_rn_i;
   wire 		 kid, auto_ref_in, auto_ref_out;


   /*********************************************************\
    *       Instantiation of sub modules.                     *
    *       sdrm_t  =  Top level for the SDRAM controller     *
    *       sys_int   =  System interface module              *
    *                                                         *
    \*********************************************************/
   
   sdrm_t sdrm_t (.Locked1(Locked1), .Locked2(Locked2), .Clk_i(Clk_i),
		  .sd_ras_o(sd_ras_op), .sd_cas_o(sd_cas_op), .sd_we_o(sd_we_op),
		  .sd_add_o(sd_add_op), .sd_ba_o(sd_ba_op), .sd_doe_n(sd_doe_np),
		  .ready_o(ready_o), .Locked_i(Locked_i), .Locked_j(Locked_j), 
		  .Add_reg(Add_reg[21:2]), .rcd_c_max(rcd_c_max), .kid(kid),
		  .auto_ref_in(auto_ref_in), .auto_ref_out(auto_ref_out), 
		  .cas_lat_max(cas_lat_max), .burst_max(burst_max), 
		  .Act_st(Act_st),.Clk_j(Clk_j), .write_st(write_st),
		  .ki_max(ki_max), .ref_max(ref_max), .rcd_end(rcd_end), .AD_tri(AD_tri));
   
   sys_int sys_int (.Locked(Locked_i), .Clk_i(Clk_i), .data_addr_n_reg(data_addr_n_reg),
		    .data_addr_n_i(data_addr_n_i), .we_rn_i(we_rn_i),
		    .we_rn_reg(we_rn_reg), .AD_reg(AD_reg), 
		    .Act_st(Act_st), .write_st(write_st), 
		    .Add_reg(Add_reg), .sd_data_reg(sd_data_reg), .rcd_c_max(rcd_c_max),
		    .cas_lat_max(cas_lat_max), .burst_max(burst_max),
		    .ki_max(ki_max), .ref_max(ref_max));
   
   
   /*****************************************************************\
    *       Delay Lock Loops and Global clock buffers instantiation   *
    *                                                                 *
    \****************************************************************/
   wire 		 unused1, unused2, unused3;
   //clock input to FPGA (Clkp), must go through IBUFG before entering DLL
   IBUFG ibufg0 (.I(Clkp), .O(Clk));
   
   //clock feedback from SDRAM for clock mirror (Clk_FBp), 
   // must go through IBUFG 
   IBUFG ibufg1 (.I(Clk_FBp), .O(Clk_FB));

   //dll0 is clock mirror, provide SDRAM clock(Clk_SDp)
   CLKDLL dll0(.CLKIN(Clk), .CLKFB(Clk_FB), .RST(Reset_i), .CLK0(unused1),
	       .CLK90(), .CLK180(), .CLK270(), .CLK2X(Clk0A), .CLKDV(unused2), 
	       .LOCKED(Locked1));
   //Clk_SDp is routed directly from dll0 to output buffer
   OBUF_F_16  obuf0 (.I(Clk0A), .O(Clk_SDp));

   //ddl1 provides internal clock to FPGA
   //these clocks drive global clock buffer (BUFG) to get minimum skew
   CLKDLL dll1(.CLKIN(Clk), .CLKFB(Clk_i), .RST(Reset_i), .CLK0(Clk0C),
	       .CLK90(), .CLK180(), .CLK270(), .CLK2X(Clk0B), .CLKDV(unused3), 
	       .LOCKED(Locked2));
   
   // Clk_j is the same as input clock (Clk_SDp)
   // Clk_i is is multiplied by 2x
   BUFG bufg0 (.O(Clk_i), .I(Clk0B));
   BUFG bufg1 (.O(Clk_j), .I(Clk0C));

   /*****************************************************************\
    *       IO pads  Flip-flops and tri-state logic                   *
    *                                                                 *
    \****************************************************************/

   assign 		 logic0 = 1'b0;
   assign 		 logic1 = 1'b1;
   assign 		 sd_cke_o = logic1;
   assign 		 sd_cs1_o = logic0;
   assign 		 sd_cs2_o = logic0;
   assign 		 sd_dqm_o[3:0] = {4{logic0}};
   assign 		 auto_ref_in = auto_ref_out;

   
   always @(posedge Clk_i or negedge Locked_i)
     if (~Locked_i)
     begin
	sd_data_o <= 32'hffffffff;
	sd_data_t[31:0] <= 32'hffffffff;
	sd_data_R <= 32'h00000000;
	AD_o <= 32'h00000000;
	AD_reg <= 32'h00000000;
	data_addr_n_reg <= 1;
	we_rn_reg <= 0;
     end
     else begin
	sd_data_o <=  #3 sd_data_reg;
	//tristate signal is duplicated into 4 signals, each having 8 loads
	//this helps reduce delay on sd_data_t
	sd_data_t[31:24] <= #3 {8{sd_doe_n[3]}};
	sd_data_t[23:16] <= #3 {8{sd_doe_n[2]}};
	sd_data_t[15:8] <= #3 {8{sd_doe_n[1]}};
	sd_data_t[7:0] <= #3 {8{sd_doe_n[0]}};
	sd_data_R <= sd_data_i;
	AD_o <= sd_data_R;
	AD_reg <= AD_i;
	data_addr_n_reg <= data_addr_n_i;
	we_rn_reg <= we_rn_i;
     end
   
   always @(posedge Clk_i or negedge Locked_i)
     if (~Locked_i)
     begin
	sd_add_o[10:0] <= 11'h000;
	sd_ba_o <= 1'b0;
	sd_ras_o <= 1'b1;
	sd_cas_o <= 1'b1;
	sd_we_o <= 1'b1;
	sd_doe_n <= 4'hf;
     end
     else begin
	sd_add_o[10:0] <= #3 sd_add_op[10:0];
	sd_ba_o <= #3 sd_ba_op;
	sd_ras_o <= #3 sd_ras_op;
	sd_cas_o <= #3 sd_cas_op;
	sd_we_o <= #3 sd_we_op;
	sd_doe_n <= #3 sd_doe_np;
     end
   

   /*****************************************************************\
    *       IO pads  instantiation                                    *
    *                                                                 *
    \****************************************************************/
 

   IOBUF_F_12 iod0 (.I(sd_data_o[0]), .IO(sd_data[0]), .O(sd_data_i[0]), .T(sd_data_t[0]));
   IOBUF_F_12 iod1 (.I(sd_data_o[1]), .IO(sd_data[1]), .O(sd_data_i[1]), .T(sd_data_t[1]));
   IOBUF_F_12 iod2 (.I(sd_data_o[2]), .IO(sd_data[2]), .O(sd_data_i[2]), .T(sd_data_t[2]));
   IOBUF_F_12 iod3 (.I(sd_data_o[3]), .IO(sd_data[3]), .O(sd_data_i[3]), .T(sd_data_t[3]));
   IOBUF_F_12 iod4 (.I(sd_data_o[4]), .IO(sd_data[4]), .O(sd_data_i[4]), .T(sd_data_t[4]));
   IOBUF_F_12 iod5 (.I(sd_data_o[5]), .IO(sd_data[5]), .O(sd_data_i[5]), .T(sd_data_t[5]));
   IOBUF_F_12 iod6 (.I(sd_data_o[6]), .IO(sd_data[6]), .O(sd_data_i[6]), .T(sd_data_t[6]));
   IOBUF_F_12 iod7 (.I(sd_data_o[7]), .IO(sd_data[7]), .O(sd_data_i[7]), .T(sd_data_t[7]));
   IOBUF_F_12 iod8 (.I(sd_data_o[8]), .IO(sd_data[8]), .O(sd_data_i[8]), .T(sd_data_t[8]));
   IOBUF_F_12 iod9 (.I(sd_data_o[9]), .IO(sd_data[9]), .O(sd_data_i[9]), .T(sd_data_t[9]));
   IOBUF_F_12 iod10 (.I(sd_data_o[10]), .IO(sd_data[10]), .O(sd_data_i[10]), .T(sd_data_t[10]));
   IOBUF_F_12 iod11 (.I(sd_data_o[11]), .IO(sd_data[11]), .O(sd_data_i[11]), .T(sd_data_t[11]));
   IOBUF_F_12 iod12 (.I(sd_data_o[12]), .IO(sd_data[12]), .O(sd_data_i[12]), .T(sd_data_t[12]));
   IOBUF_F_12 iod13 (.I(sd_data_o[13]), .IO(sd_data[13]), .O(sd_data_i[13]), .T(sd_data_t[13]));
   IOBUF_F_12 iod14 (.I(sd_data_o[14]), .IO(sd_data[14]), .O(sd_data_i[14]), .T(sd_data_t[14]));
   IOBUF_F_12 iod15 (.I(sd_data_o[15]), .IO(sd_data[15]), .O(sd_data_i[15]), .T(sd_data_t[15]));
   IOBUF_F_12 iod16 (.I(sd_data_o[16]), .IO(sd_data[16]), .O(sd_data_i[16]), .T(sd_data_t[16]));
   IOBUF_F_12 iod17 (.I(sd_data_o[17]), .IO(sd_data[17]), .O(sd_data_i[17]), .T(sd_data_t[17]));
   IOBUF_F_12 iod18 (.I(sd_data_o[18]), .IO(sd_data[18]), .O(sd_data_i[18]), .T(sd_data_t[18]));
   IOBUF_F_12 iod19 (.I(sd_data_o[19]), .IO(sd_data[19]), .O(sd_data_i[19]), .T(sd_data_t[19]));
   IOBUF_F_12 iod20 (.I(sd_data_o[20]), .IO(sd_data[20]), .O(sd_data_i[20]), .T(sd_data_t[20]));
   IOBUF_F_12 iod21 (.I(sd_data_o[21]), .IO(sd_data[21]), .O(sd_data_i[21]), .T(sd_data_t[21]));
   IOBUF_F_12 iod22 (.I(sd_data_o[22]), .IO(sd_data[22]), .O(sd_data_i[22]), .T(sd_data_t[22]));
   IOBUF_F_12 iod23 (.I(sd_data_o[23]), .IO(sd_data[23]), .O(sd_data_i[23]), .T(sd_data_t[23]));
   IOBUF_F_12 iod24 (.I(sd_data_o[24]), .IO(sd_data[24]), .O(sd_data_i[24]), .T(sd_data_t[24]));
   IOBUF_F_12 iod25 (.I(sd_data_o[25]), .IO(sd_data[25]), .O(sd_data_i[25]), .T(sd_data_t[25]));
   IOBUF_F_12 iod26 (.I(sd_data_o[26]), .IO(sd_data[26]), .O(sd_data_i[26]), .T(sd_data_t[26]));
   IOBUF_F_12 iod27 (.I(sd_data_o[27]), .IO(sd_data[27]), .O(sd_data_i[27]), .T(sd_data_t[27]));
   IOBUF_F_12 iod28 (.I(sd_data_o[28]), .IO(sd_data[28]), .O(sd_data_i[28]), .T(sd_data_t[28]));
   IOBUF_F_12 iod29 (.I(sd_data_o[29]), .IO(sd_data[29]), .O(sd_data_i[29]), .T(sd_data_t[29]));
   IOBUF_F_12 iod30 (.I(sd_data_o[30]), .IO(sd_data[30]), .O(sd_data_i[30]), .T(sd_data_t[30]));
   IOBUF_F_12 iod31 (.I(sd_data_o[31]), .IO(sd_data[31]), .O(sd_data_i[31]), .T(sd_data_t[31]));
   
   
   OBUF_F_12 sda0 (.O(sd_add[0]), .I(sd_add_o[0]));
   OBUF_F_12 sda1 (.O(sd_add[1]), .I(sd_add_o[1]));
   OBUF_F_12 sda2 (.O(sd_add[2]), .I(sd_add_o[2]));
   OBUF_F_12 sda3 (.O(sd_add[3]), .I(sd_add_o[3]));
   OBUF_F_12 sda4 (.O(sd_add[4]), .I(sd_add_o[4]));
   OBUF_F_12 sda5 (.O(sd_add[5]), .I(sd_add_o[5]));
   OBUF_F_12 sda6 (.O(sd_add[6]), .I(sd_add_o[6]));
   OBUF_F_12 sda7 (.O(sd_add[7]), .I(sd_add_o[7]));
   OBUF_F_12 sda8 (.O(sd_add[8]), .I(sd_add_o[8]));
   OBUF_F_12 sda9 (.O(sd_add[9]), .I(sd_add_o[9]));
   OBUF_F_12 sda10 (.O(sd_add[10]), .I(sd_add_o[10]));
   
   
   OBUF_F_12 sdb (.O(sd_ba), .I(sd_ba_o));
   OBUF_F_12 sdr (.O(sd_ras), .I(sd_ras_o));
   OBUF_F_12 sdc (.O(sd_cas), .I(sd_cas_o));
   OBUF_F_12 sdw (.O(sd_we), .I(sd_we_o));
   OBUF_F_12 sdcke (.O(sd_cke), .I(sd_cke_o));
   OBUF_F_12 sdcs1 (.O(sd_cs1), .I(sd_cs1_o));
   OBUF_F_12 sdcs2 (.O(sd_cs2), .I(sd_cs2_o));
   OBUF_F_12 dqm0 (.O(sd_dqm[0]), .I(sd_dqm_o[0]));
   OBUF_F_12 dqm1 (.O(sd_dqm[1]), .I(sd_dqm_o[1]));
   OBUF_F_12 dqm2 (.O(sd_dqm[2]), .I(sd_dqm_o[2]));
   OBUF_F_12 dqm3 (.O(sd_dqm[3]), .I(sd_dqm_o[3]));
   
   
   
   /*****************************************************************\
   *       Processor Interface IO pads  				  *
   *                                                                 *
   \****************************************************************/
   
   IBUF rst_b (.O(Reset_i), .I(Reset));
   IBUF ads_b (.O(data_addr_n_i), .I(data_addr_n));
   IBUF wern_b (.O(we_rn_i), .I(we_rn));

   
   IOBUF_F_12 ad0  (.I(AD_o[0]),  .O(AD_i[0]), .IO(AD[0]),  .T(AD_tri));
   IOBUF_F_12 ad1  (.I(AD_o[1]),  .O(AD_i[1]), .IO(AD[1]),  .T(AD_tri));
   IOBUF_F_12 ad2  (.I(AD_o[2]),  .O(AD_i[2]), .IO(AD[2]),  .T(AD_tri));
   IOBUF_F_12 ad3  (.I(AD_o[3]),  .O(AD_i[3]), .IO(AD[3]),  .T(AD_tri));
   IOBUF_F_12 ad4  (.I(AD_o[4]),  .O(AD_i[4]), .IO(AD[4]),  .T(AD_tri));
   IOBUF_F_12 ad5  (.I(AD_o[5]),  .O(AD_i[5]), .IO(AD[5]),  .T(AD_tri));
   IOBUF_F_12 ad6  (.I(AD_o[6]),  .O(AD_i[6]), .IO(AD[6]),  .T(AD_tri));
   IOBUF_F_12 ad7  (.I(AD_o[7]),  .O(AD_i[7]), .IO(AD[7]),  .T(AD_tri));
   IOBUF_F_12 ad8  (.I(AD_o[8]),  .O(AD_i[8]), .IO(AD[8]),  .T(AD_tri));
   IOBUF_F_12 ad9  (.I(AD_o[9]),  .O(AD_i[9]), .IO(AD[9]),  .T(AD_tri));
   IOBUF_F_12 ad10 (.I(AD_o[10]), .O(AD_i[10]), .IO(AD[10]), .T(AD_tri));
   IOBUF_F_12 ad11 (.I(AD_o[11]), .O(AD_i[11]), .IO(AD[11]), .T(AD_tri));
   IOBUF_F_12 ad12 (.I(AD_o[12]), .O(AD_i[12]), .IO(AD[12]), .T(AD_tri));
   IOBUF_F_12 ad13 (.I(AD_o[13]), .O(AD_i[13]), .IO(AD[13]), .T(AD_tri));
   IOBUF_F_12 ad14 (.I(AD_o[14]), .O(AD_i[14]), .IO(AD[14]), .T(AD_tri));
   IOBUF_F_12 ad15 (.I(AD_o[15]), .O(AD_i[15]), .IO(AD[15]), .T(AD_tri));
   IOBUF_F_12 ad16 (.I(AD_o[16]), .O(AD_i[16]), .IO(AD[16]), .T(AD_tri));
   IOBUF_F_12 ad17 (.I(AD_o[17]), .O(AD_i[17]), .IO(AD[17]), .T(AD_tri));
   IOBUF_F_12 ad18 (.I(AD_o[18]), .O(AD_i[18]), .IO(AD[18]), .T(AD_tri));
   IOBUF_F_12 ad19 (.I(AD_o[19]), .O(AD_i[19]), .IO(AD[19]), .T(AD_tri));
   IOBUF_F_12 ad20 (.I(AD_o[20]), .O(AD_i[20]), .IO(AD[20]), .T(AD_tri));
   IOBUF_F_12 ad21 (.I(AD_o[21]), .O(AD_i[21]), .IO(AD[21]), .T(AD_tri));
   IOBUF_F_12 ad22 (.I(AD_o[22]), .O(AD_i[22]), .IO(AD[22]), .T(AD_tri));
   IOBUF_F_12 ad23 (.I(AD_o[23]), .O(AD_i[23]), .IO(AD[23]), .T(AD_tri));
   IOBUF_F_12 ad24 (.I(AD_o[24]), .O(AD_i[24]), .IO(AD[24]), .T(AD_tri));
   IOBUF_F_12 ad25 (.I(AD_o[25]), .O(AD_i[25]), .IO(AD[25]), .T(AD_tri));
   IOBUF_F_12 ad26 (.I(AD_o[26]), .O(AD_i[26]), .IO(AD[26]), .T(AD_tri));
   IOBUF_F_12 ad27 (.I(AD_o[27]), .O(AD_i[27]), .IO(AD[27]), .T(AD_tri));
   IOBUF_F_12 ad28 (.I(AD_o[28]), .O(AD_i[28]), .IO(AD[28]), .T(AD_tri));
   IOBUF_F_12 ad29 (.I(AD_o[29]), .O(AD_i[29]), .IO(AD[29]), .T(AD_tri));
   IOBUF_F_12 ad30 (.I(AD_o[30]), .O(AD_i[30]), .IO(AD[30]), .T(AD_tri));
   IOBUF_F_12 ad31 (.I(AD_o[31]), .O(AD_i[31]), .IO(AD[31]), .T(AD_tri));
 



endmodule
