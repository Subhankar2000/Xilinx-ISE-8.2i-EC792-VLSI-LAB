module top (A, B, C, D, up, left, down, right, star, FiftyM_clk, DB, RW, RS, EN, rst, half1, half2, half3, half4);
	output 	A, B, C, D, half1, half2, half3, half4;
	output	RS, RW, EN;
	output	[7:0] DB;
	input		up, left, down, right, star, FiftyM_clk, rst;

	FSM brain (DB, RW, RS, EN, rst, ~star);	//flip star back to ~star
	cntr_50MtoLCD clkcock (EN, FiftyM_clk);
	
	not nota (A, up);
	not notb (B, left);
	not notc (C, down);
	not notd (D, right);

	cntr_divby2 uno (half1, FiftyM_clk);
	cntr_divby2 dos (half2, ~FiftyM_clk);

	cntr_divby2 tres (half3, FiftyM_clk);
	cntr_divby2 cuatro (half4, ~FiftyM_clk);

endmodule
