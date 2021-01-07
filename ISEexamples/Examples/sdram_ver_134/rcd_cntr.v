/******************************************************************************
*
*    File Name:  rcd_cntr.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  RAS to CAS Delay Counter 
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
module rcd_cntr (/*AUTOARG*/
   // Outputs
   rcd_end, 
   // Inputs
   Reset, Clk, ld_rcd, rcd_max
   );

   output      rcd_end;
   input [1:0] rcd_max;
   input       Reset, Clk, ld_rcd;


   wire        ld_rcd;
   reg 	       rcd_end;
   reg [1:0]   count, count_N;
   
   always @ (posedge Clk or negedge Reset)
     if (~Reset) 
       count <= 2'b00;
     else if (ld_rcd) 
       count <= rcd_max;
     else 
       count <= count_N;
   
   
   always @ (count)
   begin
      if (count == 2'b00)
      begin
	 count_N = 2'b00;
	 rcd_end = 1;
      end
      else
      begin
	 count_N = count - 1;
	 rcd_end = 0;
      end
   end
   
endmodule
