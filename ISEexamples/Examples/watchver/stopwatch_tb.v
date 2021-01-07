`timescale 1 ns / 1 ps

module testbench;
  reg tbreset, tbstrtstop;
  reg tbclk;
  wire [6:0] onesout, tensout;
  wire [9:0] tbtenthsout;

// /////////////////////////////
// Instantiatation of the Design
// /////////////////////////////
  stopwatch UUT (
    .CLK (tbclk), 
    .RESET (tbreset), 
    .STRTSTOP (tbstrtstop),
    .ONESOUT (onesout), 
    .TENSOUT (tensout), 
    .TENTHSOUT (tbtenthsout)
  );

  wire [4:0] tbonesout, tbtensout;

  assign tbtensout = led2hex(tensout);
  assign tbonesout = led2hex(onesout);

// ////////////////
// Assert the Global Set/Reset for the first 100 ns of the simulation
// ////////////////  
  reg GSR;
  assign glbl.GSR = GSR;
  initial begin
    GSR = 1;
    #100 GSR = 0;
  end
 
// ////////////////
// Create the clock
// ////////////////
  initial begin
    tbclk = 0;
    forever #10 tbclk = ~tbclk;
  end

  initial begin
    // //////////////////////////
    // Initialize All Input Ports
    // //////////////////////////
    tbreset = 1;
    tbstrtstop = 1;

    // wait for GSR to de-assert
    #100 tbreset = 0;

    ///////////////////////
    // Apply Design Stimulus
    ///////////////////////
    //Wait long enough for DCM to lock
    #900 tbstrtstop = 0;
  
    // ///////////////////////////////////////////////////////////
    // stop the simulation after running for an additional 1000 ns
    // ///////////////////////////////////////////////////////////
    #1000 $stop;
  end

  function [4:0] led2hex;
  //HEX-to-seven-segment decoder
  //
  // segment encoding
  //      0
  //     ---  
  //  5 |   | 1
  //     ---   <- 6
  //  4 |   | 2
  //     ---
  //      3
    input [6:0] LED ;

    case (LED)
      7'b1111001 : led2hex = 4'd1;
	 7'b0100100 : led2hex = 4'd2;
	 7'b0110000 : led2hex = 4'd3;
	 7'b0011001 : led2hex = 4'd4;
	 7'b0010010 : led2hex = 4'd5;
	 7'b0000010 : led2hex = 4'd6;
	 7'b1111000 : led2hex = 4'd7;
	 7'b0000000 : led2hex = 4'd8;
	 7'b0010000 : led2hex = 4'd9;
	 default : led2hex = 4'd0;
    endcase
  endfunction

endmodule 
