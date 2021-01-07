/******************************************************************************
*
*    File Name:  cslt_cntr.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  Cas Latency Counter
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
module cslt_cntr (/*AUTOARG*/
   // Outputs
   cslt_end, 
   // Inputs
   Reset, Clk, ld_cslt, cslt_max
   );

   output cslt_end;
   input  Reset, Clk, ld_cslt;
   input [1:0] cslt_max;
   
   wire        ld_cslt;
   reg 	       cslt_end;   
   reg [1:0]   count, count_N;
   
   always @ (posedge Clk or negedge Reset)
     if (~Reset) 
       count <= 2'b00;
     else if (ld_cslt) 
       count <= cslt_max;
     else 
       count <= count_N;
   
   
   always @ (count)
   begin
      if (count == 2'b00)
      begin
	 count_N = 2'b00;
	 cslt_end = 1;
      end
      else
      begin
	 count_N = count - 1;
	 cslt_end = 0;
      end
   end
   
endmodule
