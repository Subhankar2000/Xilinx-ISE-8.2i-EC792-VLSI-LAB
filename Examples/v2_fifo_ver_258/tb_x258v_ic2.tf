
/**********************************************************************\
*                                                                      *
* Module      : tb_x258v_ic2.v                Last updated: 07/14/00   *
*                                                                      *
* Description : Testbench for independent-clock FIFO controller in a   *
*               Virtex2 device, using source fifoctlr_ic_v2.v,         *
*               which is 511x36.                                       *
*                                                                      *
*               Read clock = 15Mhz, Write clock = 50Mhz.               * 
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

module tb_ic2_func;

reg GSR;
`define GSR_SIGNAL tb_ic2_func.GSR

reg read_clockin, write_clockin;
reg read_enable, write_enable;
wire [35:0] read_data;
reg [35:0] write_data;

wire full, empty;
wire [3:0] fifostatus;

fifoctlr_ic_v2 fifo_controller (.read_clock_in(read_clockin), 
                    .write_clock_in(write_clockin), .read_enable_in(read_enable),
                    .read_data_out(read_data), .write_enable_in(write_enable), 
                    .write_data_in(write_data), .full_out(full), 
                    .empty_out(empty), .fifostatus_out(fifostatus), 
                    .fifo_gsr_in(GSR) );

initial begin
   read_enable = 0;
   write_enable = 0;
   write_data = 'h0;
   tb_ic2_func.fifo_controller.read_addr = 'h0;
   tb_ic2_func.fifo_controller.read_nextgray = 'b100000000;
   tb_ic2_func.fifo_controller.read_addrgray = 'b100000001;
   tb_ic2_func.fifo_controller.read_lastgray = 'b100000011;
   tb_ic2_func.fifo_controller.read_truegray = 'h0;
   tb_ic2_func.fifo_controller.rag_writesync = 'h0;
   tb_ic2_func.fifo_controller.write_addr = 'h0;
   tb_ic2_func.fifo_controller.write_nextgray = 'b100000000;
   tb_ic2_func.fifo_controller.write_addrgray = 'b100000001;
   tb_ic2_func.fifo_controller.fifostatus = 'h0;
   tb_ic2_func.fifo_controller.full = 'b1;
   tb_ic2_func.fifo_controller.empty = 'b1;
   GSR = 1;
   #83 GSR = 0;

   $display("       time  R  R  R      R      W  W  W      W      F E  F   R   R   R   W   W  EF  R   R   W");
   $display("             C  D  A      D      C  R  A      D      U M  S   A   A   A   A   A      T   A   A");
   $display("             L  E  D      A      L  E  D      A      L P  T   N   D   L   N   D      G   _   D");
   $display("             K  N  D      T      K  N  D      T      L T  A   G   G   G   G   G          W   _");
   $display("                   R      A            R      A        Y  T                              S   R");
   $display("");
   $monitor(" %10.2f  %b  %b %3x %9x  %b  %b %3x %9x  %b %b %3x %3x %3x %3x %3x %3x %b%b %3x %3x %3x",
             $realtime, read_clockin, read_enable, 
             tb_ic2_func.fifo_controller.read_addr, read_data, 
             write_clockin, write_enable, 
             tb_ic2_func.fifo_controller.write_addr, write_data,
             tb_ic2_func.fifo_controller.full,
             tb_ic2_func.fifo_controller.empty,
             tb_ic2_func.fifo_controller.fifostatus,
             tb_ic2_func.fifo_controller.read_nextgray,
             tb_ic2_func.fifo_controller.read_addrgray,
             tb_ic2_func.fifo_controller.read_lastgray,
             tb_ic2_func.fifo_controller.write_nextgray,
             tb_ic2_func.fifo_controller.write_addrgray,
             tb_ic2_func.fifo_controller.emptyg,
             tb_ic2_func.fifo_controller.fullg,
             tb_ic2_func.fifo_controller.read_truegray,
             tb_ic2_func.fifo_controller.ra_writesync,
             tb_ic2_func.fifo_controller.write_addrr
             );
end

initial begin
   read_clockin = 1;
   write_clockin = 1;
end

always #33 read_clockin = ~read_clockin;    // write faster than read
always #10 write_clockin = ~write_clockin;

task delay;
   begin
      #100;
   end
endtask

task writeburst;
   input [35:0] wdata;
   begin
      @(posedge write_clockin) begin 
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
      @(posedge write_clockin) begin 
         write_enable = #2 0;
         write_data = #2 'h0;
      end
   end
endtask

task readburst;
   begin
      @(posedge read_clockin) #2 read_enable = 1;
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
      @(posedge read_clockin) #2 read_enable = 0;
   end
endtask

initial begin

// Stimulus when write faster than read

   delay;
   writeburst128;
   writeburst128;
   writeburst128;
   writeburst128;
   delay;
   read_enable = 1;
   writeburst128;
   endwriteburst;
   readburst128;
   readburst128;
   readburst128;
   readburst128;
   delay;
   endreadburst;

end

endmodule

