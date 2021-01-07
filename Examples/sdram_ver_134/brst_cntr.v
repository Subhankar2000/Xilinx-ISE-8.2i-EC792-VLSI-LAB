/******************************************************************************
*
*    File Name:  brst_cntr.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  Burst Counter
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
module brst_cntr (/*AUTOARG*/
   // Outputs
   brst_end, brst_end_m1, 
   // Inputs
   Reset, Clk, ld_brst, brst_max
   );

   output brst_end, brst_end_m1;
   input  Reset, Clk, ld_brst;
   input [2:0] brst_max;

   wire        ld_brst;
   reg 	       brst_end, brst_end_m1;

   reg [2:0]   count, count_N;

   always @ (posedge Clk or negedge Reset)
     if (~Reset) 
       count <= 3'b000;
     else if (ld_brst) 
       count <= brst_max;
     else 
       count <= count_N;
   

   always @ (count)
   begin
      brst_end_m1 = (count == 3'b001) ? 1'b1 : 1'b0 ;
      if (count == 3'b000)
      begin
	 count_N = 3'b000;
	 brst_end = 1;
      end
      else
      begin
	 count_N = count - 1;
	 brst_end = 0;
      end
   end
   
endmodule
