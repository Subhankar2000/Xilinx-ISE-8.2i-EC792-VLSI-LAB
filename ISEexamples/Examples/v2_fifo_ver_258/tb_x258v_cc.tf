
/**********************************************************************\
*                                                                      *
* Module      : tb_x258v_cc.v                 Last updated: 07/14/00   *
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

module tb_cc_func;

reg GSR;
`define GSR_SIGNAL tb_cc_func.GSR

reg clockin;
reg read_enable, write_enable;
wire [35:0] read_data;
reg [35:0] write_data;
reg temp;

wire full, empty;
wire [3:0] fifocount;

fifoctlr_cc_v2 fifo_controller (.clock_in(clockin), .read_enable_in(read_enable),
                    .read_data_out(read_data), .write_data_in(write_data), 
                    .write_enable_in(write_enable), .full_out(full), 
                    .empty_out(empty), .fifocount_out(fifocount),
                    .fifo_gsr_in(GSR) );

initial begin
   GSR = 1;
   #83 GSR = 0;
   read_enable = 0;
   write_enable = 0;
   write_data = 'h0;
   tb_cc_func.fifo_controller.read_addr = 'h0;
   tb_cc_func.fifo_controller.write_addr = 'h0;
   tb_cc_func.fifo_controller.read_allow = 'b0;
   tb_cc_func.fifo_controller.write_allow = 'b0;
   tb_cc_func.fifo_controller.fcounter = 'h0;
   tb_cc_func.fifo_controller.full = 1;
   tb_cc_func.fifo_controller.empty = 1;

   $display("       time  C  R  R   R      R      W  W   W      W      F E  F  F  F");
   $display("             L  D  A   A      D      R  A   A      D      U M  C  I  C");
   $display("             O  E  L   D      A      E  L   D      A      L P  A  F  N");
   $display("             C  N  O   D      T      N  O   D      T      L T  L  O  T");
   $display("             K     W   R      A         W   R      A        Y  W  C   ");
   $display("");
   $monitor(" %10.2f  %b  %b  %b  %3x %9x  %b  %b  %3x %9x  %b %b  %b  %x %3x",
             $realtime, clockin, read_enable, tb_cc_func.fifo_controller.read_allow,
             tb_cc_func.fifo_controller.read_addr, read_data, 
             write_enable, tb_cc_func.fifo_controller.write_allow,
             tb_cc_func.fifo_controller.write_addr, write_data, full, empty, 
             tb_cc_func.fifo_controller.fcnt_allow, fifocount, 
             tb_cc_func.fifo_controller.fcounter
             );
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
   input [35:0] wdata;
   begin
      @(posedge clockin) begin 
         write_enable = #2 1;
         write_data = #2 wdata;
      end
   end
endtask

task writeburst32;
   begin
      writeburst(36'h001122333); writeburst(36'h112233444); writeburst(36'h223344555);
      writeburst(36'h334455666); writeburst(36'h445566777); writeburst(36'h556677888);
      writeburst(36'h667788999); writeburst(36'h778899aaa); writeburst(36'h8899aabbb);
      writeburst(36'h99aabbccc); writeburst(36'haabbccddd); writeburst(36'hbbccddeee);
      writeburst(36'hccddeefff); writeburst(36'hddeeff000); writeburst(36'heeff00111);
      writeburst(36'hff0011222);
      writeburst(36'h112211222); writeburst(36'h223322333); writeburst(36'h334433444);
      writeburst(36'h445544555); writeburst(36'h556655666); writeburst(36'h667766777);
      writeburst(36'h778877888); writeburst(36'h889988999); writeburst(36'h99aa99aaa);
      writeburst(36'haabbaabbb); writeburst(36'hbbccbbccc); writeburst(36'hccddccddd);
      writeburst(36'hddeeddeee); writeburst(36'heeffeefff); writeburst(36'hff00ff000);
      writeburst(36'h001100111);
  end
endtask

task writeburst128;
   begin 
      writeburst32; writeburst32; writeburst32; writeburst32;
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

