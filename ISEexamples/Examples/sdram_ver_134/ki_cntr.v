/******************************************************************************
*
*    File Name:  ki_cntr.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  Keep Idle Counter 
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
module ki_cntr (/*AUTOARG*/
   // Outputs
   ki_end, 
   // Inputs
   Reset, Clk, ld_ki, ki_max
   );

   output ki_end;
   input  Reset, Clk, ld_ki;
   input [3:0] ki_max;
   
   wire        ld_ki;
   reg 	       ki_end;
   
   reg [3:0]   count, count_N;
   
   always @ (posedge Clk or negedge Reset)
     if (~Reset) 
       count <= 4'h0;
     else if (ld_ki) 
       count <= ki_max;
     else 
       count <= count_N;
   
   
   always @ (count)
   begin
      if (count == 4'h0)
      begin
	 count_N = 4'h0;
	 ki_end = 1;
      end
      else
      begin
	 count_N = count - 1;
	 ki_end = 0;
      end
   end
   
endmodule
