/**********************************************************************\
*                                                                      *
* Module      : tb_x258v_cc_timing.v          Last updated: 07/14/00   *
*                                                                      *
* Description : Testbench for common-clock FIFO controller in a        *
*               Virtex2 device, using source fifoctlr_cc_v2.v,         *
*               which is 511x36.                                       *
*                                                                      *
*  Designer    : Nick Camilleri                                        *
*                                                                      *
*  Company     : Xilinx, Inc.                                          *
*                                                                      *
*  Disclaimer  : THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY   *
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY      *
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR    *
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.        *
*                THEY ARE ONLY INTENDED TO BE USED BY XILINX           *
*                CUSTOMERS, AND WITHIN XILINX DEVICES.                 *
*                                                                      *
*                Copyright (c) 2000 Xilinx, Inc.                       *
*                All rights reserved                                   *
*                                                                      *
\**********************************************************************/

`timescale 1ns / 10ps

module tb_cc_time;

reg GSR;
`define GSR_SIGNAL test.GSR

reg clockin;
reg read_enable, write_enable;
wire [7:0] read_data;
reg [7:0] write_data;
reg temp;

wire full, empty;
wire [3:0] fifocount;

fifoctlr_cc_v2 fifoctlr_cc_v2 (.clock_in(clockin), .read_enable_in(read_enable),
                         .read_data_out(read_data), .write_data_in(write_data), 
                         .write_enable_in(write_enable), .full_out(full), 
                         .empty_out(empty), .fifocount_out(fifocount),
                         .fifo_gsr_in(GSR));

initial begin
   GSR = 1;
   #83 GSR = 0;
   read_enable = 0;
   write_enable = 0;
   write_data = 'h0;
end

initial
   clockin = 1;
   always #10 clockin = ~clockin;

task delay;
   begin
      @(posedge clockin) temp = 0;
      @(posedge clockin) temp = 0;
      @(posedge clockin) temp = 0;
      @(posedge clockin) temp = 0;
      @(posedge clockin) temp = 0;
   end
endtask

task writeburst;
   input [7:0] wdata;
   begin
      @(posedge clockin) begin 
         write_enable = #2 1;
         write_data = #2 wdata;
      end
   end
endtask

task writeburst128;
   begin 
      writeburst(128); writeburst(129); writeburst(130); writeburst(131);
      writeburst(132); writeburst(133); writeburst(134); writeburst(135);
      writeburst(136); writeburst(137); writeburst(138); writeburst(139);
      writeburst(140); writeburst(141); writeburst(142); writeburst(143);
      writeburst(144); writeburst(145); writeburst(146); writeburst(147);
      writeburst(148); writeburst(149); writeburst(150); writeburst(151);
      writeburst(152); writeburst(153); writeburst(154); writeburst(155);
      writeburst(156); writeburst(157); writeburst(158); writeburst(159);
      writeburst(160); writeburst(161); writeburst(162); writeburst(163);
      writeburst(164); writeburst(165); writeburst(166); writeburst(167);
      writeburst(168); writeburst(169); writeburst(170); writeburst(171);
      writeburst(172); writeburst(173); writeburst(174); writeburst(175);
      writeburst(176); writeburst(177); writeburst(178); writeburst(179);
      writeburst(180); writeburst(181); writeburst(182); writeburst(183);
      writeburst(184); writeburst(185); writeburst(186); writeburst(187);
      writeburst(188); writeburst(189); writeburst(190); writeburst(191);
      writeburst(192); writeburst(193); writeburst(194); writeburst(195);
      writeburst(196); writeburst(197); writeburst(198); writeburst(199);
      writeburst(200); writeburst(201); writeburst(202); writeburst(203);
      writeburst(204); writeburst(205); writeburst(206); writeburst(207);
      writeburst(208); writeburst(209); writeburst(210); writeburst(211);
      writeburst(212); writeburst(213); writeburst(214); writeburst(215);
      writeburst(216); writeburst(217); writeburst(218); writeburst(219);
      writeburst(220); writeburst(221); writeburst(222); writeburst(223);
      writeburst(224); writeburst(225); writeburst(226); writeburst(227);
      writeburst(228); writeburst(229); writeburst(230); writeburst(231);
      writeburst(232); writeburst(233); writeburst(234); writeburst(235);
      writeburst(236); writeburst(237); writeburst(238); writeburst(239);
      writeburst(240); writeburst(241); writeburst(242); writeburst(243);
      writeburst(244); writeburst(245); writeburst(246); writeburst(247);
      writeburst(248); writeburst(249); writeburst(250); writeburst(251);
      writeburst(252); writeburst(253); writeburst(254); writeburst(255);
  end
endtask

task endwriteburst;
   begin
      @(posedge clockin) begin 
         write_enable = #2 0;
         write_data = #2 'h0;
      end
   end
endtask

task readburst;
   begin
      @(posedge clockin) #2 read_enable = 1;
   end
endtask

task readburst32;
   begin
      readburst; readburst; readburst; readburst; readburst; readburst;
      readburst; readburst; readburst; readburst; readburst; readburst;
      readburst; readburst; readburst; readburst; readburst; readburst;
      readburst; readburst; readburst; readburst; readburst; readburst;
      readburst; readburst; readburst; readburst; readburst; readburst;
      readburst; readburst;
   end
endtask
 
task readburst128;
   begin
      readburst32; readburst32; readburst32; readburst32;
   end
endtask
 
task endreadburst;
   begin
      @(posedge clockin) #2 read_enable = 0;
   end
endtask

initial begin

   delay;
   writeburst128; 
   writeburst128; 
   writeburst128; 
   writeburst128; 
   read_enable = 1;
   writeburst128; 
   read_enable = 0;
   endwriteburst; 
   delay; 
   readburst128; 
   readburst128; 
   readburst128; 
   readburst128; 
   endreadburst;

end

endmodule

