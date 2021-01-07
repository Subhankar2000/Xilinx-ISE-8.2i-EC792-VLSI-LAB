/******************************************************************************
*
*    File Name:  sys_int.v
*      Version:  1.15
*         Date:  Sept 19, 2005
*  Description:  System Interface
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

module sys_int (/*AUTOARG*/
   // Outputs
   Add_reg, sd_data_reg, Act_st, write_st, rcd_c_max, cas_lat_max, 
   burst_max, ki_max, ref_max, 
   // Inputs
   AD_reg, Locked, Clk_i, data_addr_n_i, we_rn_i, data_addr_n_reg, 
   we_rn_reg
   );
   output [(`ADDR_MSB):0] Add_reg;
   output [(`DATA_MSB):0] sd_data_reg;
   output [2:0] 	  Act_st;
   output 		  write_st;   
   output [1:0] 	  rcd_c_max, cas_lat_max;
   output [2:0] 	  burst_max;
   output [3:0] 	  ki_max;
   output [15:0] 	  ref_max;
   
   input [(`DATA_MSB):0]  AD_reg;
   input 		  Locked, Clk_i, data_addr_n_i, we_rn_i, data_addr_n_reg, we_rn_reg;

   wire [(`DATA_MSB):0]   AD_reg;   
   reg [(`ADDR_MSB):0] 	  Addr;
   reg [(`DATA_MSB):0] 	  cntrl;
   reg [(`ADDR_MSB):0] 	  Add_reg;
   reg [(`DATA_MSB):0] 	  Data_reg;
   wire [(`DATA_MSB):0]   sd_data_reg;
   reg 			  ld_cnt_reg;
   reg [2:0] 		  Act_st;
   wire 		  Clk_i, Locked, write_st;
   wire 		  data_addr_n_reg, we_rn_reg;

   /*********************************************************\
    *       We're using AD[29:28] to decode SDRAM commands    *
    *                                                         *
    *       A29  A28                                          *
    *       ---  ---                                          *
    *        0    0      Normal SDRAM Access                  *
    *        0    1      Load SDRAM Mode Register             *
    *        1    0      Precharge both Banks &               *
    *                    load Controller Control Register     *
    *        1    1      Auto Refresh                         *
    *                                                         *
    \*********************************************************/
      
   always @(posedge Clk_i)
     if (~data_addr_n_reg)
     casex(AD_reg[29:28])
       2'b00:   Act_st <= 3'b100;
       2'b01:   Act_st <= 3'b101;
       2'b10:   Act_st <= 3'b110;
       2'b11:   Act_st <= 3'b111;
       default: Act_st <= 3'b000;
     endcase
     else
       Act_st <= 3'b000;
   
   assign 		  write_st = we_rn_i;
   
   
   /*********************************************************\
    *       SDRAM Controller Control Register Logic           *
    *                                                         *
    \********************************************************/
   
   
   assign 		  cas_lat_max[1:0] = cntrl[1:0];
   assign 		  rcd_c_max[1:0] = cntrl[3:2];
   assign 		  burst_max[2:0] = cntrl[6:4];
   assign 		  ref_max[15:0] = cntrl[23:8];
   assign 		  ki_max[3:0] = cntrl[27:24];
   
   
   always @(posedge Clk_i or negedge Locked)
     if (~Locked)
     begin
	ld_cnt_reg <= 1'b0;
	cntrl <= 32'h0070320a;
	Add_reg <= 32'h00000000;
	Data_reg <= 32'h00000000;
     end
     else begin
        if (ld_cnt_reg)	  cntrl <= Data_reg;
        ld_cnt_reg <= (Act_st[2] & Act_st[1] & ~Act_st[0]); 
        if (data_addr_n_reg) Data_reg <= AD_reg;
	else Add_reg <= AD_reg;
     end // else: !if(~Locked)
   
   //delay Data_reg  by 4 clock periods
   SRL16 SRL16_0 (.Q(sd_data_reg[0]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[0]), .CLK(Clk_i));
   SRL16 SRL16_1 (.Q(sd_data_reg[1]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[1]), .CLK(Clk_i));
   SRL16 SRL16_2 (.Q(sd_data_reg[2]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[2]), .CLK(Clk_i));
   SRL16 SRL16_3 (.Q(sd_data_reg[3]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[3]), .CLK(Clk_i));
   SRL16 SRL16_4 (.Q(sd_data_reg[4]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[4]), .CLK(Clk_i));
   SRL16 SRL16_5 (.Q(sd_data_reg[5]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[5]), .CLK(Clk_i));
   SRL16 SRL16_6 (.Q(sd_data_reg[6]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[6]), .CLK(Clk_i));
   SRL16 SRL16_7 (.Q(sd_data_reg[7]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[7]), .CLK(Clk_i));
   SRL16 SRL16_8 (.Q(sd_data_reg[8]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[8]), .CLK(Clk_i));
   SRL16 SRL16_9 (.Q(sd_data_reg[9]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[9]), .CLK(Clk_i));
   SRL16 SRL16_10 (.Q(sd_data_reg[10]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[10]), .CLK(Clk_i));
   SRL16 SRL16_11 (.Q(sd_data_reg[11]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[11]), .CLK(Clk_i));
   SRL16 SRL16_12 (.Q(sd_data_reg[12]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[12]), .CLK(Clk_i));
   SRL16 SRL16_13 (.Q(sd_data_reg[13]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[13]), .CLK(Clk_i));
   SRL16 SRL16_14 (.Q(sd_data_reg[14]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[14]), .CLK(Clk_i));
   SRL16 SRL16_15 (.Q(sd_data_reg[15]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[15]), .CLK(Clk_i));
   SRL16 SRL16_16 (.Q(sd_data_reg[16]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[16]), .CLK(Clk_i));
   SRL16 SRL16_17 (.Q(sd_data_reg[17]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[17]), .CLK(Clk_i));
   SRL16 SRL16_18 (.Q(sd_data_reg[18]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[18]), .CLK(Clk_i));
   SRL16 SRL16_19 (.Q(sd_data_reg[19]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[19]), .CLK(Clk_i));
   SRL16 SRL16_20 (.Q(sd_data_reg[20]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[20]), .CLK(Clk_i));
   SRL16 SRL16_21 (.Q(sd_data_reg[21]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[21]), .CLK(Clk_i));
   SRL16 SRL16_22 (.Q(sd_data_reg[22]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[22]), .CLK(Clk_i));
   SRL16 SRL16_23 (.Q(sd_data_reg[23]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[23]), .CLK(Clk_i));
   SRL16 SRL16_24 (.Q(sd_data_reg[24]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[24]), .CLK(Clk_i));
   SRL16 SRL16_25 (.Q(sd_data_reg[25]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[25]), .CLK(Clk_i));
   SRL16 SRL16_26 (.Q(sd_data_reg[26]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[26]), .CLK(Clk_i));
   SRL16 SRL16_27 (.Q(sd_data_reg[27]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[27]), .CLK(Clk_i));
   SRL16 SRL16_28 (.Q(sd_data_reg[28]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[28]), .CLK(Clk_i));
   SRL16 SRL16_29 (.Q(sd_data_reg[29]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[29]), .CLK(Clk_i));
   SRL16 SRL16_30 (.Q(sd_data_reg[30]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[30]), .CLK(Clk_i));
   SRL16 SRL16_31 (.Q(sd_data_reg[31]), .A0(1'b1), .A1(1'b1), .A2(1'b0), .A3(1'b0), 
		.D(Data_reg[31]), .CLK(Clk_i));
   
endmodule
