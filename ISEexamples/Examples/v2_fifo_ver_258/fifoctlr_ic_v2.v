
/***********************************************************************\
*                                                                       *
*  Module      : fifoctlr_ic_v2.v               Last Update: 07/14/00   *
*                                                                       *
*  Description : FIFO controller top level.                             *
*                Implements a 511x36 FIFO with independent read/write   *
*                clocks.                                                *
*                                                                       *
*  The following Verilog code implements a 511x36 FIFO in a Virtex2     *
*  device.  The inputs are a Read Clock and Read Enable, a Write Clock  * 
*  and Write Enable, Write Data, and a FIFO_gsr signal as an initial    *
*  reset.  The outputs are Read Data, Full, Empty, and the FIFOstatus   *
*  outputs, which indicate roughly how full the FIFO is.                *
*                                                                       *
*  Designer    : Nick Camilleri                                         *
*                                                                       *
*  Company     : Xilinx, Inc.                                           *
*                                                                       *
*  Disclaimer  : THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY    *
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY       *
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR     *
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.         *
*                THEY ARE ONLY INTENDED TO BE USED BY XILINX            *
*                CUSTOMERS, AND WITHIN XILINX DEVICES.                  *
*                                                                       *
*                Copyright (c) 2000 Xilinx, Inc.                        *
*                All rights reserved                                    *
*                                                                       *
\***********************************************************************/

`timescale 1ns / 10ps

`define DATA_WIDTH 35:0
`define ADDR_WIDTH 8:0
`define CARRY_WIDTH 8:0

/************************************************************\
*                                                            *
*  The logic modules below are coded explicitly, to ensure   *
*  that the logic is implemented in a minimum of levels.     *
*                                                            *
\************************************************************/

module xor5p (data, out);

input [4:0] data;
output out;

wire muxout, mdata1, mdata0;

assign mdata1 = ! (data[4] ^ data[3] ^ data[2] ^ data[1]);
assign mdata0 = (data[4] ^ data[3] ^ data[2] ^ data[1]);

MUXF5 muxf5_1 (.I0(mdata0), .I1(mdata1), .S(data[0]), .O(muxout));

assign out = muxout;

endmodule

module xor4p (data, out);

input [3:0] data;
output out;

assign out = (data[3] ^ data[2] ^ data[1] ^ data[0]);

endmodule

module muxorp (a, b, c, sel, out);

input a, b, c, sel;
output out;

assign #1 out = (((a == b) && sel) || ((a == c) && ! sel));

endmodule

module fifoctlr_ic_v2 (read_clock_in, write_clock_in, read_enable_in, 
                       write_enable_in, fifo_gsr_in, write_data_in, 
                       read_data_out, fifostatus_out, full_out, 
                       empty_out);

input read_clock_in, write_clock_in;
input read_enable_in, write_enable_in;
input fifo_gsr_in;
input  [`DATA_WIDTH] write_data_in;
output [`DATA_WIDTH] read_data_out;
output [3:0] fifostatus_out;
output full_out, empty_out;

wire read_enable = read_enable_in;
wire write_enable = write_enable_in;
wire fifo_gsr = fifo_gsr_in;
wire [`DATA_WIDTH] write_data = write_data_in;
wire [`DATA_WIDTH] read_data;
assign read_data_out = read_data;
reg [8:0] fifostatus;
assign fifostatus_out = fifostatus[8:5];
reg full, empty;
assign full_out = full;
assign empty_out = empty;

reg [`ADDR_WIDTH] read_addr, write_addr;
reg [`ADDR_WIDTH] write_addrgray, write_nextgray;
reg [`ADDR_WIDTH] read_addrgray, read_nextgray, read_lastgray;

wire read_allow, write_allow, empty_allow, full_allow;

wire [`CARRY_WIDTH] ecomp, fcomp;
wire [`CARRY_WIDTH] emuxcyo, fmuxcyo;

wire emptyg, fullg;

wire [`DATA_WIDTH] gnd_bus = 'h0;
wire gnd = 0;
wire pwr = 1;

/**********************************************************************\
*                                                                      *
* Global input clock buffers are instantianted for both the read_clock *
* and the write_clock, to avoid skew problems.                         *
*                                                                      *
\**********************************************************************/

BUFGP gclkread (.I(read_clock_in), .O(read_clock));
BUFGP gclkwrite (.I(write_clock_in), .O(write_clock));

/**********************************************************************\
*                                                                      *
* BLOCK RAM instantiation for FIFO.  Module is 512x36, of which one    *
* address location is sacrificed for the overall speed of the design.  *
*                                                                      *
\**********************************************************************/

RAMB16_S36_S36 bram1 ( .ADDRA(read_addr), .ADDRB(write_addr),
                       .DIA(gnd_bus[35:4]), .DIPA(gnd_bus[3:0]), 
                       .DIB(write_data[35:4]), .DIPB(write_data[3:0]),
                       .WEA(gnd), .WEB(pwr), .CLKA(read_clock), 
                       .CLKB(write_clock), .SSRA(gnd), .SSRB(gnd), 
                       .ENA(read_allow), .ENB(write_allow), 
                       .DOA(read_data[35:4]), .DOPA(read_data[3:0]), 
                       .DOB(), .DOPB() );
 
/************************************************************\
*                                                            *
*  Allow flags determine whether FIFO control logic can      *
*  operate.  If read_enable is driven high, and the FIFO is  *
*  not Empty, then Reads are allowed.  Similarly, if the     *
*  write_enable signal is high, and the FIFO is not Full,    *
*  then Writes are allowed.                                  *
*                                                            *
\************************************************************/

assign read_allow = (read_enable && ! empty);
assign write_allow = (write_enable && ! full);

assign full_allow = (full || write_enable);
assign empty_allow = (empty || read_enable);

/***********************************************************\
*                                                           *
*  Empty flag is set on fifo_gsr (initial), or when gray    *
*  code counters are equal, or when there is one word in    *
*  the FIFO, and a Read operation is about to be performed  *
*                                                           *
\***********************************************************/

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) empty <= 'b1;
   else if (empty_allow) empty <= emptyg;

/***********************************************************\
*                                                           *
*  Full flag is set on fifo_gsr (initial, but it is cleared *
*  on the first valid write_clock edge after fifo_gsr is    *
*  de-asserted), or when Gray-code counters are one away    *
*  from being equal (the Write Gray-code address is equal   *
*  to the Last Read Gray-code address), or when the Next    *
*  Write Gray-code address is equal to the Last Read Gray-  *
*  code address, and a Write operation is about to be       *
*  performed.                                               *
*                                                           *
\***********************************************************/

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) full <= 'b1;
   else if (full_allow) full <= fullg;

/************************************************************\
*                                                            *
*  Generation of Read address pointers.  The primary one is  *
*  binary (read_addr), and the Gray-code derivatives are     *
*  generated via pipelining the binary-to-Gray-code result.  *
*  The initial values are important, so they're in sequence. *
*  Grey-code addresses are used so that the registered       *
*  Full and Empty flags are always clean, and never in an    *
*  unknown state due to the asynchonous relationship of the  *
*  Read and Write clocks.  In the worst case scenario, Full  *
*  and Empty would simply stay active one cycle longer, but  *
*  it would not generate an error or give false values.      *
*                                                            *
\************************************************************/

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) read_addr <= 'h0;
   else if (read_allow) read_addr <= read_addr + 1;

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) read_nextgray <= 9'b100000000;
   else if (read_allow) 
      read_nextgray <= { read_addr[8], (read_addr[8] ^ read_addr[7]), 
           (read_addr[7] ^ read_addr[6]), (read_addr[6] ^ read_addr[5]),
           (read_addr[5] ^ read_addr[4]), (read_addr[4] ^ read_addr[3]),
           (read_addr[3] ^ read_addr[2]), (read_addr[2] ^ read_addr[1]),
           (read_addr[1] ^ read_addr[0]) };

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) read_addrgray <= 9'b100000001;
   else if (read_allow) read_addrgray <= read_nextgray;

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) read_lastgray <= 9'b100000011;
   else if (read_allow) read_lastgray <= read_addrgray;

/************************************************************\
*                                                            *
*  Generation of Write address pointers.  Identical copy of  *
*  read pointer generation above, except for names.          *
*                                                            *
\************************************************************/

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) write_addr <= 'h0;
   else if (write_allow) write_addr <= write_addr + 1;

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) write_nextgray <= 9'b100000000;
   else if (write_allow) 
      write_nextgray <= { write_addr[8], (write_addr[8] ^ write_addr[7]), 
           (write_addr[7] ^ write_addr[6]), (write_addr[6] ^ write_addr[5]),
           (write_addr[5] ^ write_addr[4]), (write_addr[4] ^ write_addr[3]),
           (write_addr[3] ^ write_addr[2]), (write_addr[2] ^ write_addr[1]),
           (write_addr[1] ^ write_addr[0]) };

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) write_addrgray <= 9'b100000001;
   else if (write_allow) write_addrgray <= write_nextgray;

/************************************************************\
*                                                            *
*  Alternative generation of FIFOstatus outputs.  Used to    *
*  determine how full FIFO is, based on how far the Write    *
*  pointer is ahead of the Read pointer.  read_truegray      *   
*  is synchronized to write_clock (rag_writesync), converted *
*  to binary (ra_writesync), and then subtracted from the    *
*  pipelined write_addr (write_addrr) to find out how many   *
*  words are in the FIFO (fifostatus).  The top bits are     *   
*  then 1/2 full, 1/4 full, etc. (not mutually exclusive).   *
*  fifostatus has a one-cycle latency on write_clock; or,    *
*  one cycle after the write address is incremented on a     *   
*  write operation, fifostatus is updated with the new       *   
*  capacity information.  There is a two-cycle latency on    *
*  read operations.                                          *
*                                                            *
*  If read_clock is much faster than write_clock, it is      *   
*  possible that the fifostatus counter could drop several   *
*  positions in one write_clock cycle, so the low-order bits *
*  of fifostatus are not as reliable.                        *
*                                                            *
*  NOTE: If the fifostatus flags are not needed, then this   *
*  section of logic can be trimmed, saving 20+ slices and    *
*  improving the circuit performance.                        *
*                                                            *
\************************************************************/

reg [`ADDR_WIDTH] read_truegray, rag_writesync, write_addrr;
wire [`ADDR_WIDTH] ra_writesync;
wire [2:0] xorout;

always @(posedge read_clock or posedge fifo_gsr)
   if (fifo_gsr) read_truegray <= 'h0;
   else read_truegray <= { read_addr[8], (read_addr[8] ^ read_addr[7]), 
          (read_addr[7] ^ read_addr[6]), (read_addr[6] ^ read_addr[5]),
          (read_addr[5] ^ read_addr[4]), (read_addr[4] ^ read_addr[3]),
          (read_addr[3] ^ read_addr[2]), (read_addr[2] ^ read_addr[1]),
          (read_addr[1] ^ read_addr[0]) };

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) rag_writesync <= 'h0;
   else rag_writesync <= read_truegray;

xor4p xor8_5 (.data(rag_writesync[8:5]), .out(xorout[0]));
xor5p xor8_4 (.data(rag_writesync[8:4]), .out(xorout[1]));
xor4p xor4_1 (.data(rag_writesync[4:1]), .out(xorout[2]));

assign ra_writesync = { 
       rag_writesync[8], (rag_writesync[8] ^ rag_writesync[7]),
      (rag_writesync[8] ^ rag_writesync[7] ^ rag_writesync[6]),
       xorout[0], xorout[1], (xorout[1] ^ rag_writesync[3]),
      (xorout[1] ^ rag_writesync[3] ^ rag_writesync[2]),
      (xorout[0] ^ xorout[2]), (xorout[0] ^ xorout[2] ^ rag_writesync[0])
      };

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) write_addrr <= 'h0;
   else write_addrr <= write_addr;

always @(posedge write_clock or posedge fifo_gsr)
   if (fifo_gsr) fifostatus <= 'h0;
   else if (! full) fifostatus <= write_addrr - ra_writesync;

/************************************************************\
*                                                            *
*  The two conditions decoded with special carry logic are   *
*  Empty and Full (gated versions).  These are used to       *   
*  determine the next state of the Full/Empty flags.  Carry  *
*  logic is used for optimal speed.  (The previous           *   
*  implementation of AlmostEmpty and AlmostFull have been    *
*  wrapped into the corresponding carry chains for faster    *
*  performance).                                             *
*                                                            *
*  When write_addrgray is equal to read_addrgray, the FIFO   *
*  is Empty, and emptyg (combinatorial) is asserted.  Or,    *
*  when write_addrgray is equal to read_nextgray (1 word in  *
*  the FIFO) then the FIFO potentially could be going Empty, *
*  so emptyg is asserted, and the Empty flip-flop enable is  *
*  gated with empty_allow, which is conditioned with a valid *
*  read.                                                     *
*                                                            *
*  Similarly, when read_lastgray is equal to write_addrgray, *
*  the FIFO is full (511 addresses).  Or, when read_lastgray *
*  is equal to write_nextgray, then the FIFO potentially     *   
*  could be going Full, so fullg is asserted, and the Full   *
*  flip-flop enable is gated with full_allow, which is       *   
*  conditioned with a valid write.                           *
*                                                            *
*  Note: To have utilized the full address space (512)       *   
*  would have required extra logic to determine Full/Empty   *
*  on equal addresses, and this would have slowed down the   *
*  overall performance, which was the top priority.          *   
*                                                            *
\************************************************************/

muxorp emuxor0 (.a(write_addrgray[0]), .b(read_addrgray[0]),
               .c(read_nextgray[0]), .sel(empty), .out(ecomp[0]));
muxorp emuxor1 (.a(write_addrgray[1]), .b(read_addrgray[1]),
               .c(read_nextgray[1]), .sel(empty), .out(ecomp[1]));
muxorp emuxor2 (.a(write_addrgray[2]), .b(read_addrgray[2]),
               .c(read_nextgray[2]), .sel(empty), .out(ecomp[2]));
muxorp emuxor3 (.a(write_addrgray[3]), .b(read_addrgray[3]),
               .c(read_nextgray[3]), .sel(empty), .out(ecomp[3]));
muxorp emuxor4 (.a(write_addrgray[4]), .b(read_addrgray[4]),
               .c(read_nextgray[4]), .sel(empty), .out(ecomp[4]));
muxorp emuxor5 (.a(write_addrgray[5]), .b(read_addrgray[5]),
               .c(read_nextgray[5]), .sel(empty), .out(ecomp[5]));
muxorp emuxor6 (.a(write_addrgray[6]), .b(read_addrgray[6]),
               .c(read_nextgray[6]), .sel(empty), .out(ecomp[6]));
muxorp emuxor7 (.a(write_addrgray[7]), .b(read_addrgray[7]),
               .c(read_nextgray[7]), .sel(empty), .out(ecomp[7]));
muxorp emuxor8 (.a(write_addrgray[8]), .b(read_addrgray[8]),
               .c(read_nextgray[8]), .sel(empty), .out(ecomp[8]));

MUXCY_L emuxcy0 (.DI(gnd), .CI(pwr),        .S(ecomp[0]), .LO(emuxcyo[0]));
MUXCY_L emuxcy1 (.DI(gnd), .CI(emuxcyo[0]), .S(ecomp[1]), .LO(emuxcyo[1]));
MUXCY_L emuxcy2 (.DI(gnd), .CI(emuxcyo[1]), .S(ecomp[2]), .LO(emuxcyo[2]));
MUXCY_L emuxcy3 (.DI(gnd), .CI(emuxcyo[2]), .S(ecomp[3]), .LO(emuxcyo[3]));
MUXCY_L emuxcy4 (.DI(gnd), .CI(emuxcyo[3]), .S(ecomp[4]), .LO(emuxcyo[4]));
MUXCY_L emuxcy5 (.DI(gnd), .CI(emuxcyo[4]), .S(ecomp[5]), .LO(emuxcyo[5]));
MUXCY_L emuxcy6 (.DI(gnd), .CI(emuxcyo[5]), .S(ecomp[6]), .LO(emuxcyo[6]));
MUXCY_L emuxcy7 (.DI(gnd), .CI(emuxcyo[6]), .S(ecomp[7]), .LO(emuxcyo[7]));
MUXCY_L emuxcy8 (.DI(gnd), .CI(emuxcyo[7]), .S(ecomp[8]), .LO(emptyg));

muxorp fmuxor0 (.a(read_lastgray[0]), .b(write_addrgray[0]),
               .c(write_nextgray[0]), .sel(full), .out(fcomp[0]));
muxorp fmuxor1 (.a(read_lastgray[1]), .b(write_addrgray[1]),
               .c(write_nextgray[1]), .sel(full), .out(fcomp[1]));
muxorp fmuxor2 (.a(read_lastgray[2]), .b(write_addrgray[2]),
               .c(write_nextgray[2]), .sel(full), .out(fcomp[2]));
muxorp fmuxor3 (.a(read_lastgray[3]), .b(write_addrgray[3]),
               .c(write_nextgray[3]), .sel(full), .out(fcomp[3]));
muxorp fmuxor4 (.a(read_lastgray[4]), .b(write_addrgray[4]),
               .c(write_nextgray[4]), .sel(full), .out(fcomp[4]));
muxorp fmuxor5 (.a(read_lastgray[5]), .b(write_addrgray[5]),
               .c(write_nextgray[5]), .sel(full), .out(fcomp[5]));
muxorp fmuxor6 (.a(read_lastgray[6]), .b(write_addrgray[6]),
               .c(write_nextgray[6]), .sel(full), .out(fcomp[6]));
muxorp fmuxor7 (.a(read_lastgray[7]), .b(write_addrgray[7]),
               .c(write_nextgray[7]), .sel(full), .out(fcomp[7]));
muxorp fmuxor8 (.a(read_lastgray[8]), .b(write_addrgray[8]),
               .c(write_nextgray[8]), .sel(full), .out(fcomp[8]));
 
MUXCY_L fmuxcy0 (.DI(gnd), .CI(pwr),        .S(fcomp[0]), .LO(fmuxcyo[0]));
MUXCY_L fmuxcy1 (.DI(gnd), .CI(fmuxcyo[0]), .S(fcomp[1]), .LO(fmuxcyo[1]));
MUXCY_L fmuxcy2 (.DI(gnd), .CI(fmuxcyo[1]), .S(fcomp[2]), .LO(fmuxcyo[2]));
MUXCY_L fmuxcy3 (.DI(gnd), .CI(fmuxcyo[2]), .S(fcomp[3]), .LO(fmuxcyo[3]));
MUXCY_L fmuxcy4 (.DI(gnd), .CI(fmuxcyo[3]), .S(fcomp[4]), .LO(fmuxcyo[4]));
MUXCY_L fmuxcy5 (.DI(gnd), .CI(fmuxcyo[4]), .S(fcomp[5]), .LO(fmuxcyo[5]));
MUXCY_L fmuxcy6 (.DI(gnd), .CI(fmuxcyo[5]), .S(fcomp[6]), .LO(fmuxcyo[6]));
MUXCY_L fmuxcy7 (.DI(gnd), .CI(fmuxcyo[6]), .S(fcomp[7]), .LO(fmuxcyo[7]));
MUXCY_L fmuxcy8 (.DI(gnd), .CI(fmuxcyo[7]), .S(fcomp[8]), .LO(fullg));
 
endmodule 
