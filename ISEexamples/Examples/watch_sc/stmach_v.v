//  This Verilog code was generated using: 
//  binary encoded state assignment with structured code format.
//  Minimization is disabled,  implied else is enabled, 
//  and outputs are manually optimized.

`timescale 1s/1s

module STMACH_V(CLK,reset,strtstop,clkout,rst);

	input CLK;
	input reset,strtstop;
	output clkout,rst;
	reg clkout,rst;
	reg [2:0] sreg;
	reg [2:0] next_sreg;

	`define CLEAR 3'b000
	`define counting 3'b001
	`define start 3'b010
	`define stop 3'b011
	`define stopped 3'b100
	`define zero 3'b101


	always @(posedge CLK or posedge reset)
	begin
		if ( reset ) sreg = `CLEAR;
		else sreg = next_sreg;
	end

	always @ (sreg or strtstop)
	begin
		clkout = 0; rst = 0; 

		next_sreg=`CLEAR;

		case (sreg)
			`CLEAR : begin
				clkout=0;
				rst=1;
				if ( 1'h1) begin
					next_sreg=`zero;
				end
				else begin
					next_sreg=`CLEAR;
				end
			end
			`counting : begin
				clkout=1;
				rst=0;
				if ( ~( ( strtstop  ) | ( ~strtstop  ) )) begin
					next_sreg=`counting;
				end
				if ( strtstop ) begin
					next_sreg=`stop;
				end
				if ( ~strtstop ) begin
					next_sreg=`counting;
				end
			end
			`start : begin
				clkout=1;
				rst=0;
				if ( ~( ( ~strtstop  ) | ( strtstop  ) )) begin
					next_sreg=`start;
				end
				if ( ~strtstop ) begin
					next_sreg=`counting;
				end
				if ( strtstop ) begin
					next_sreg=`start;
				end
			end
			`stop : begin
				clkout=0;
				rst=0;
				if ( ~( ( ~strtstop  ) | ( strtstop  ) )) begin
					next_sreg=`stop;
				end
				if ( ~strtstop ) begin
					next_sreg=`stopped;
				end
				if ( strtstop ) begin
					next_sreg=`stop;
				end
			end
			`stopped : begin
				clkout=0;
				rst=0;
				if ( ~( ( strtstop  ) | ( ~strtstop  ) )) begin
					next_sreg=`stopped;
				end
				if ( strtstop ) begin
					next_sreg=`start;
				end
				if ( ~strtstop ) begin
					next_sreg=`stopped;
				end
			end
			`zero : begin
				clkout=0;
				rst=0;
				if ( ~( ( strtstop  ) | ( ~strtstop  ) )) begin
					next_sreg=`zero;
				end
				if ( strtstop ) begin
					next_sreg=`start;
				end
				if ( ~strtstop ) begin
					next_sreg=`zero;
				end
			end
		endcase
	end
endmodule
