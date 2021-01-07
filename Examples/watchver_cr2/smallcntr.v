module smallcntr (ce, clk, clr, qout);
input ce, clk, clr;
output [3:0] qout;

reg [3:0] qout;

always @ (posedge clk or negedge clk or posedge clr)
   begin
      if (clr)
	 qout = 4'b0000;
      else if (ce)
	if (qout == 4'b1001)
	  qout = 4'b0000;
	else
	  qout = qout + 1;
   end
   
endmodule
