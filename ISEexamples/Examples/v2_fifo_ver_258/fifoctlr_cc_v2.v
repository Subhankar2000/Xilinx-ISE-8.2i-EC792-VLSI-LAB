
/************************************************************************\
*                                                                        *
*  Module      : fifoctlr_cc_v2.v               Last Update: 07/14/00    *
*                                                                        *
*  Description : FIFO controller top level.                              *
*                Implements a 511x36 FIFO with common read/write clocks. *
*                                                                        *
*  The following Verilog code implements a 511x36 FIFO in a Virtex2      *
*  device.  The inputs are a Clock, a Read Enable, a Write Enable,       *
*  Write Data, and a FIFO_gsr signal as an initial reset.  The outputs   *
*  are Read Data, Full, Empty, and the FIFOcount outputs, which          *
*  indicate how full the FIFO is.                                        *
*                                                                        *
*  Designer    : Nick Camilleri                                          *
*                                                                        *
*  Company     : Xilinx, Inc.                                            *
*                                                                        *
*  Disclaimer  : THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY     *
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY        *
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR      *
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.          *
*                THEY ARE ONLY INTENDED TO BE USED BY XILINX             *
*                CUSTOMERS, AND WITHIN XILINX DEVICES.                   *
*                                                                        *
*                Copyright (c) 2000 Xilinx, Inc.                         *
*                All rights reserved                                     *
*                                                                        *
\************************************************************************/

`timescale 1ns / 10ps

`define DATA_WIDTH 35:0
`define ADDR_WIDTH 8:0

/************************************************************\
*                                                            *
*  The logic modules below are coded explicitly, to ensure   *
*  that the logic is implemented in a minimum of levels.     *   
*                                                            *
\************************************************************/

module and4b1p (in1, in2, in3, in4, out);

input in1, in2, in3, in4;
output out;

assign out = (in1 && in2 && in3 && ! in4);

endmodule

module and4p (data, out);

input [3:0] data;
output out;

assign out = (data[3] && data[2] && data[1] && data[0]);

endmodule

module and4b4p (data, out);

input [3:0] data;
output out;

assign out = (! data[3] && ! data[2] && ! data[1] && ! data[0]);

endmodule


module fifoctlr_cc_v2 (clock_in, read_enable_in, write_enable_in, 
                       write_data_in, fifo_gsr_in, read_data_out, 
                       full_out, empty_out, fifocount_out );

input clock_in, read_enable_in, write_enable_in, fifo_gsr_in;
input  [`DATA_WIDTH] write_data_in;
output [`DATA_WIDTH] read_data_out;
output full_out, empty_out;
output [3:0] fifocount_out;

wire read_enable = read_enable_in;
wire write_enable = write_enable_in;
wire fifo_gsr = fifo_gsr_in;
wire [`DATA_WIDTH] write_data = write_data_in;
wire [`DATA_WIDTH] read_data;
assign read_data_out = read_data;
reg full, empty;
assign full_out = full;
assign empty_out = empty;

reg [`ADDR_WIDTH] read_addr, write_addr, fcounter;
reg read_allow, write_allow;

wire fcnt_allow;

wire [`DATA_WIDTH] gnd_bus = 'h0;
wire gnd = 0;
wire pwr = 1;

/**********************************************************************\
*                                                                      *
* A global buffer is instantianted to avoid skew problems.             * 
*                                                                      *
\**********************************************************************/
 
BUFGP gclk1 (.I(clock_in), .O(clock));

/**********************************************************************\
*                                                                      *
* BLOCK RAM instantiation for FIFO.  Module is 512x36, of which one    * 
* address location is sacrificed for the overall speed of the design.  *
*                                                                      *
\**********************************************************************/

RAMB16_S36_S36 bram1 ( .ADDRA(read_addr), .ADDRB(write_addr), 
                       .DIA(gnd_bus[35:4]), .DIPA(gnd_bus[3:0]), 
                       .DIB(write_data[35:4]), .DIPB(write_data[3:0]), 
                       .WEA(gnd), .WEB(pwr), .CLKA(clock), .CLKB(clock), 
                       .SSRA(gnd), .SSRB(gnd), .ENA(read_allow), 
                       .ENB(write_allow), .DOA(read_data[35:4]),
                       .DOPA(read_data[3:0]), .DOB(), .DOPB() );

/***********************************************************\
*                                                           *
*  Set allow flags, which control the clock enables for     *
*  read, write, and count operations.                       *
*                                                           *
\***********************************************************/

wire [3:0] fcntandout;
wire ra_or_fcnt0, wa_or_fcnt0, emptyg, fullg;

always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) read_allow <= 0;
   else read_allow <= read_enable && 
                      ! (fcntandout[0] && fcntandout[1] && ! write_allow);

always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) write_allow <= 0;
   else write_allow <= write_enable && 
                       ! (fcntandout[2] && fcntandout[3] && ! read_allow);

assign fcnt_allow = write_allow ^ read_allow;

/***********************************************************\
*                                                           *
*  Empty flag is set on fifo_gsr (initial), or when on the  *
*  next clock cycle, Write Enable is low, and either the    *
*  FIFOcount is equal to 0, or it is equal to 1 and Read    *
*  Enable is high (about to go Empty).                      *
*                                                           *
\***********************************************************/

assign ra_or_fcnt0 = (read_allow || ! fcounter[0]);

and4b4p emptyand1 (.data(fcounter[4:1]), .out(fcntandout[0]));
and4b4p emptyand2 (.data(fcounter[8:5]), .out(fcntandout[1]));
and4b1p emptyand3 (.in1(fcntandout[0]), .in2(fcntandout[1]), .in3(ra_or_fcnt0),
                  .in4(write_allow), .out(emptyg));
 
always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) empty <= 1;
   else empty <= emptyg;

/***********************************************************\
*                                                           *
*  Full flag is set on fifo_gsr (but it is cleared on the   *
*  first valid clock edge after fifo_gsr is removed), or    *
*  when on the next clock cycle, Read Enable is low, and    *
*  either the FIFOcount is equal to 1FF (hex), or it is     *
*  equal to 1FE and the Write Enable is high (about to go   *
*  Full).                                                   *
*                                                           *
\***********************************************************/

assign wa_or_fcnt0 = (write_allow || fcounter[0]);

and4p   fulland1 (.data(fcounter[4:1]), .out(fcntandout[2]));
and4p   fulland2 (.data(fcounter[8:5]), .out(fcntandout[3]));
and4b1p fulland3 (.in1(fcntandout[2]), .in2(fcntandout[3]), .in3(wa_or_fcnt0),
                  .in4(read_allow), .out(fullg));

always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) full <= 1;
   else full <= fullg;

/************************************************************\
*                                                            *
*  Generation of Read and Write address pointers.  They now  *
*  use binary counters because it is simpler in simulation,  *
*  and the previous LFSR implementation wasn't in the        *   
*  critical path.                                            *
*                                                            *
\************************************************************/

always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) read_addr <= 'h0;
   else if (read_allow) read_addr <= read_addr + 1;
 
always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) write_addr <= 'h0;
   else if (write_allow) write_addr <= write_addr + 1;
 
/************************************************************\
*                                                            *
*  Generation of FIFOcount outputs.  Used to determine how   *
*  full FIFO is, based on a counter that keeps track of how  *
*  many words are in the FIFO.  Also used to generate Full   *
*  and Empty flags.  Only the upper four bits of the counter *
*  are sent outside the FIFO module.                         *
*                                                            *
\************************************************************/

always @(posedge clock or posedge fifo_gsr)
   if (fifo_gsr) fcounter <= 'h0;
   else if (fcnt_allow)
      fcounter <= fcounter + { read_allow, read_allow, read_allow, 
                               read_allow, read_allow, read_allow, 
                               read_allow, read_allow, pwr };

assign fifocount_out = fcounter[8:5];

endmodule

