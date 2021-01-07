module cnt60 (ce, clk, clr, lsbsec, msbsec);
input ce, clk, clr;
output [3:0] lsbsec, msbsec;

wire msbce, lsbtc, msbclr, msbtc;
   
smallcntr LSBCOUNT (.ce (ce), .clk (clk),
                    .clr (clr), .qout (lsbsec));

smallcntr MSBCOUNT (.ce (msbce), .clk (clk),
                    .clr (msbclr), .qout (msbsec));

assign lsbtc = (lsbsec == 4'b1001) ? 1'b1 : 1'b0;
assign msbtc = (msbsec == 4'b0110) ? 1'b1 : 1'b0;
assign msbce = ce & lsbtc;
assign msbclr = clr | msbtc;
   
endmodule
