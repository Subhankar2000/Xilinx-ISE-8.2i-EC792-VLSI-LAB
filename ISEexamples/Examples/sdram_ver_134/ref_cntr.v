/******************************************************************************
*
*    File Name:  ref_cntr.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  Refresh Counter 
*
*      Company:  Xilinx
*
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 1998 Xilinx, Inc.
*                All rights reserved
*
******************************************************************************/

module ref_cntr (/*AUTOARG*/
   // Outputs
   auto_ref, p_auto_ref, 
   // Inputs
   Reset, Clk, clr_ref, ref_max
   );

   output        auto_ref, p_auto_ref;
   input [15:0] ref_max;
   input 	Reset, Clk, clr_ref;

   wire 	clr_ref;
   reg 		auto_ref, p_auto_ref;
   reg [15:0] 	rcount, count_N;

   always @ (posedge Clk or negedge Reset)
     if (~Reset) begin
	rcount <= ref_max;
	auto_ref <= 0;
     end
     else begin
	rcount <= count_N;
	if (rcount == 16'h0000)
	  auto_ref <= 1;
	if (clr_ref) 
	begin
	   auto_ref <= 0;
	   p_auto_ref <= 0;
	end	
	if (rcount == 16'h0003)
	  p_auto_ref <= 1;
     end
   
   
   always @ (rcount or ref_max)
     if (rcount == 16'h0000)
       count_N = ref_max;
     else
       count_N = rcount - 1;
	
endmodule
