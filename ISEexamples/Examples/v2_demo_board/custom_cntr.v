module cntr_divby2 (outclock, inclock);
	output outclock;
 	input inclock;
 	reg outclock;

 	integer counter;
	reg next_outclock;

 	always @ (negedge inclock) begin
  		if (counter == 1) 
			counter <= 0;
  		else 
			counter <= counter + 1;
 	end

 	always @ (posedge inclock) begin
  		if (counter < 1) 
			next_outclock <= 1;
  		else 
			next_outclock <= 0;
		outclock <= next_outclock;  		
 	end
endmodule

module cntr_50Mto10 (outclock, inclock);
	output outclock;
 	input inclock;
 	reg outclock;

 	integer counter;
	reg next_outclock;

 	always @ (negedge inclock) begin
  		if (counter == 5000000) 
			counter <= 0;
  		else 
			counter <= counter + 1;
 	end

 	always @ (posedge inclock) begin
  		if (counter < 2500000) 
			next_outclock = 1;
  		else 
			next_outclock = 0;
		outclock <= next_outclock;  		
 	end
endmodule

module cntr_50Mto1 (outclock, inclock);
	output outclock;
 	input inclock;
 	reg outclock;

 	integer counter;
	reg next_outclock;

 	always @ (negedge inclock) begin
  		if (counter == 50000000) 
			counter <= 0;
  		else 
			counter <= counter + 1;
 	end

 	always @ (posedge inclock) begin
  		if (counter < 25000000) 
			next_outclock <= 1;
  		else 
			next_outclock <= 0;
		outclock <= next_outclock;  		
 	end
endmodule

module cntr_50Mtohalf (outclock, inclock);
	output outclock;
 	input inclock;
 	reg outclock;

 	integer counter;
	reg next_outclock;

 	always @ (negedge inclock) begin
  		if (counter == 100000000) 
			counter <= 0;
  		else 
			counter <= counter + 1;
 	end

 	always @ (posedge inclock) begin
  		if (counter < 50000000) 
			next_outclock = 1;
  		else 
			next_outclock = 0;
		outclock <= next_outclock;  		
 	end
endmodule


module cntr_50MtoLCD (outclock, inclock);
	output 	outclock;
	input 	inclock;
	reg 		outclock;

	integer counter;
	reg next_outclock;

	always @ (negedge inclock) begin
		if (counter == 80000)
			counter <= 0;
		else
			counter <= counter + 1;
	end

	always @ (posedge inclock) begin
		if (counter < 40000)
			next_outclock <= 1;
		else
			next_outclock <= 0;
		outclock <= next_outclock;
	end
endmodule
