/*
The following is example code that implements two LFSRs which can be used as part of pn generators.
The number of taps are fixed however the tap points and LFSR width are parameratized.  This code 
is not technology specific and can be used to target Virtex or non-Virtex (ie, ASICs).  When 
targetting Xilinx (Virtex) however, all the latest synthesis vendors (Leonardo, Synplicity, and 
FPGA Express) will infer the shift register LUTS (SRL16E) resulting in a very efficient implementation.

Control signals have been provided to allow external circuitry to control such things as filling,
puncturing, stalling (augmentation), etc.

Mike Gulotta
11/4/99


###################################################################################################
          I and Q Polinomials:                                                                    #
          I(x) = X**17 + X**5 + 1                                                                 #
          Q(x) = X**17 + X**9 + X**5 + X**4 + 1                                                   #
                                                                                                  #
          LFSR implementation format examples:                                                    #
###################################################################################################
                                                                                                  #
          I(x) = X**17 + X**5 + 1                                                                 #
                        ________                                                                  #
                       |        |<<...............................                                #
            par_fdbk_i | Parity |                                 |                               #
      .................|        |<<...                            |                               #
     |                 |________|    |                            |                               #
     |                               |                            |                               #
     |          __________________   |   ______________ ____      |                               #
     |...|\    |    |        |    |  |  |    |         |    |     | pn_out_i                      #
         ||-->>| 16 | - - - -|  5 |-----|  4 | - - - - |  0 | >>---------->>                      #
DataIn_i.|/    |____|________|____|     |____|_________|____|                                     #
          |                      srl_i                                                            #
 FillSel..|                                                                                       #
                                  ---> shifting -->>                                              #
###################################################################################################
                                                                                                  #
                                                                                                  #
           Q(x) = X**17 + X**9 + X**5 + X**4 + 1                                                  #
                 ________                                                                         #
                |        |..........................................................              #
                |        |......................................                    |             #
      ..........| Parity |...........................           |                   |             #
     |          |        |.......                    |          |                   |             #
     |          |________|       |                   |          |                   |             #
     |           _____________   |   ____ ________   |   ____   |   ______________  |             #
     |...|\     |    |    |   |  |  |    |    |   |  |  |    |  |  |    |    |    | |   pn_out_q  #
         ||--->>| 16 | - -| 9 |-----|  8 | - -| 5 |-----|  4 |-----|  3 |- - |  0 |--------->>    #
DataIn_q.|/     |____|____|___|     |____|____|___|     |____|     |____|____|____|               #
          |                                srl_q                                                  #
 FillSel..|                                                                                       #
                                           -->> shifting  -->>                                    #
###################################################################################################
*/


// A compiler directive can be used to steer the following code to infer FF's
// (w/async resets), or infer Virtex SLR16E elements.  Defining the compiler can be swithed
// on/off by uncommenting the following line.  It could also be done from a top level module.

// `define non_Virtex

`ifdef non_Virtex  // compiler directive, if defined, will infer asyn reset FF.
module iq_pn_gen (clk, pn_out_i, pn_out_q, ShiftEn, FillSel, DataIn_i, DataIn_q, RESET);

// Ports
input  clk, DataIn_i, DataIn_q, FillSel, ShiftEn, RESET;
output  pn_out_i;
output  pn_out_q;

`else
module iq_pn_gen (clk, pn_out_i, pn_out_q, ShiftEn, FillSel, DataIn_i, DataIn_q);

// Ports
input  clk, DataIn_i, DataIn_q, FillSel, ShiftEn;
output  pn_out_i;
output  pn_out_q;

`endif

// LFSR length (ie, number of storage elements)
parameter Width = 17;

// Parameratize I LFSR taps.
// I channel LFSR has two taps.
// I(x) = X**17 + X**5 + 1
parameter I_tap1 = 0;
parameter I_tap2 = 5;

// Parameratize Q LFSR taps.
// Q channel LFSR has four taps.
// Q(x) = X**17 + X**9 + X**5 + X**4 + 1
parameter Q_tap1 = 0;
parameter Q_tap2 = 4;
parameter Q_tap3 = 5;
parameter Q_tap4 = 9;

// I  channel ////////////////////
reg [Width-1:0] srl_i;
wire lfsr_in_i, par_fdbk_i;

assign   pn_out_i = srl_i[I_tap1];
assign   par_fdbk_i = srl_i[I_tap2] ^ srl_i[I_tap1];
assign   lfsr_in_i = FillSel ? DataIn_i : par_fdbk_i;

`ifdef non_Virtex  // compiler directive, if defined, will infer asyn reset FF.
always @(posedge clk or negedge RESET)  begin
   if (!RESET) begin
     srl_i <= 0;
   end
   else
`else  // compiler directive, if not defined, will infer SRL16.
 always @(posedge clk)  begin
`endif
   if (ShiftEn) begin
     srl_i <= {lfsr_in_i, srl_i[Width-1:1]};
   end
end


// Q  channel ///////////////////
reg [Width-1:0] srl_q;
wire lfsr_in_q, par_fdbk_q;

assign   pn_out_q = srl_q[0];
assign   par_fdbk_q = srl_q[Q_tap4] ^ srl_q[Q_tap3] ^ srl_q[Q_tap2] ^ srl_q[Q_tap1];
assign   lfsr_in_q = FillSel ? DataIn_q : par_fdbk_q;

`ifdef non_Virtex  // compiler directive, if defined, will infer asyn reset FF.
always @(posedge clk or negedge RESET)  begin
   if (!RESET) begin
     srl_q <= 0;
   end
   else
`else  // compiler directive, if not defined, will infer SRL16.
 always @(posedge clk)  begin
`endif
   if (ShiftEn) begin
     srl_q <= {lfsr_in_q, srl_q[Width-1:1]};
   end
end

endmodule

