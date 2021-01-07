module smallcntr(CE,CLK,CLR,QOUT);

input CE;
input CLK;
input CLR;
output [3:0] QOUT;

reg [3:0] QOUT;

always@(posedge CLK or posedge CLR)
   begin
      if(CLR)     //change "fi" to "if"
	 QOUT = 4'b0000;
      else if(CE)
	 if(QOUT==4'b1001)
	    QOUT=4'b0000;
         else
	    QOUT = QOUT + 1;
   end
   
endmodule
