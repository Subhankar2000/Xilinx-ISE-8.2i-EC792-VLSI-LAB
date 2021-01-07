//certain changes were made in order for simulation to take place.
//searching for "modelsim" will bring you to changes (most specifically
//commented-out code.


module FSM (DB, RW, RS, clk, rst, star);
	input		clk, rst, star;
	output 	[7:0] DB;
	output	RW, RS;

	reg		RW, RS;
	reg		[7:0] DB;
	reg 		[10:0] current_state, next_state;

	always @ (current_state or star) begin
		RW = 0;
		RS = 1;
		DB = 8'hEF;
		case (current_state)
		//Seiko LCD startup sequence
			0: begin
				RS = 0;
				DB = 8'h38;
				next_state = 1;
			end
			1: begin
				RS = 0;
				DB = 8'h38;
				next_state = 2;
			end
			2: begin
				RS = 0;
				DB = 8'h38;
				next_state = 3;
			end
			3: begin
				RS = 0;
				DB = 8'h38;
				next_state = 4;
			end
			4: begin
				RS = 0;
				DB = 8'h06;
				next_state = 5;
			end
			5: begin
				RS = 0;
				DB = 8'h0C;
				next_state = 6;
			end
			6: begin
				RS = 0;
				DB = 8'h01;
				next_state = 7;
			end
			7: begin
				RS = 0;
				DB = 8'h80;
				next_state = 8;
			end
			//[->Generate  Meter]
			//first half of LCD characters (1 - 8)
			8: begin
				RS = 1;
				DB = 8'h50; //P
				next_state = 9;
			end
			9: begin
				RS = 1;
				DB = 8'h75;	//u
				next_state = 10;
			end
			10: begin
				RS = 1;
				DB = 8'h73;	//s
				next_state = 11;
			end
			11: begin
				RS = 1;
				DB = 8'h68;	//h
				next_state = 12;
			end
			12: begin
				RS = 1;
				DB = 8'hFE;	//space
				next_state = 13;
			end
			13: begin
				RS = 1;
				DB = 8'h43;	//C
				next_state = 14;
			end
			14: begin
				RS = 1;
				DB = 8'h65;	//e
				next_state = 15;
			end
			15: begin
				RS = 1;
				DB = 8'h6E;	//n
				next_state = 16;
			end
			//go to second half of LCD
			16: begin
				RS = 0;
				DB = 8'hC0;	//next line
				next_state = 17;
			end
			//second half of LCD characters (9 - 16)
			17: begin
				RS = 1;
				DB = 8'h74;	//t
				next_state = 18;
			end
			18: begin
				RS = 1;
				DB = 8'h65;	//e
				next_state = 19;
			end
			19: begin
				RS = 1;
				DB = 8'h72;	//r
				next_state = 20;
			end
			20: begin
				RS = 1;
				DB = 8'hFE;	//space
				next_state = 21;
			end
			21: begin
				RS = 1;
				DB = 8'hFE;	//space
				next_state = 22;
			end
			22: begin
				RS = 1;
				DB = 8'hFE;	//space
				next_state = 23;
			end
			23: begin
				RS = 1;
				if (star)
					DB = 8'h4F;	//O
				else
					DB = 8'hFE;	//space
				next_state = 24;
			end
			24: begin
				RS = 1;
				if (star)
					DB = 8'h4B;	//K
				else
					DB = 8'hFE;	//space
				next_state = 7;
			end
			default: begin
				RS = 0;
				DB = 8'h38;
				next_state = 0;
			end			
		endcase
	end

	always @ (posedge clk or negedge rst) begin
		if (~rst)
			current_state = 0;
		else
			current_state = next_state;
	end
endmodule
