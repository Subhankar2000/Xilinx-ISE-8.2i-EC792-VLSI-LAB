`timescale 1 ns / 1 ns

module watch (reset,strtstop,clk,cdrst,tensout,onesout,tenthsout);
input cdrst, reset, strtstop;
input clk ; 
output [7:0] onesout, tensout;
output [9:0] tenthsout;

wire clkint, clkenable;
wire strtstopinv, rstint, xtermcnt, cnt60enable;
wire [9:0] xcountout;
wire [3:0] lsbcnt, msbcnt;

CLK_DIV16R u1 (.CLKIN(clk),.CDRST(cdrst),.CLKDV(clkint));

stmchine MACHINE (.clk (clkint), .reset (reset),
  .strtstop (strtstopinv), .clken (clkenable), .rst (rstint));

tenths XCOUNTER (.CLOCK (clkint), .CLK_EN (clkenable),
  .ASYNC_CTRL (rstint), .TERM_CNT (xtermcnt), .Q_OUT (xcountout));

cnt60 SIXTY (.ce (cnt60enable), .clk (clkint), .clr (rstint),
  .lsbsec (lsbcnt), .msbsec (msbcnt));

hex2led LSBLED (.hex (lsbcnt), .led (onesout));

hex2led MSBLED (.hex (msbcnt), .led (tensout));

assign cnt60enable = xtermcnt & clkenable;
assign tenthsout = ~xcountout;
assign strtstopinv = ~strtstop;

endmodule

