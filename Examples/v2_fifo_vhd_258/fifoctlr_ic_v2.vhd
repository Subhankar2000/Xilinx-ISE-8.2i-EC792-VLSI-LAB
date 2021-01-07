
---------------------------------------------------------------------------
--                                                                       --
--  Module      : fifoctlr_ic_v2.vhd              Last Update: 07/14/00  --
--                                                                       --
--  Description : FIFO controller top level.                             --
--                Implements a 511x36 FIFO with independent read/write   --
--                clocks.                                                --
--                                                                       --
--  The following VHDL code implements a 511x36 FIFO in a Virtex         --
--  device.  The inputs are a Read Clock and Read Enable, a Write Clock  -- 
--  and Write Enable, Write Data, and a FIFO_gsr signal as an initial    --
--  reset.  The outputs are Read Data, Full, Empty, and the FIFOstatus   --
--  outputs, which indicate roughly how full the FIFO is.                --
--                                                                       --
--  Designer    : Nick Camilleri                                         --
--                                                                       --
--  Company     : Xilinx, Inc.                                           --
--                                                                       --
--  Disclaimer  : THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY    --
--                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY       --
--                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR     --
--                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.         --
--                THEY ARE ONLY INTENDED TO BE USED BY XILINX            --
--                CUSTOMERS, AND WITHIN XILINX DEVICES.                  --
--                                                                       --
--                Copyright (c) 2000 Xilinx, Inc.                        --
--                All rights reserved                                    --
--                                                                       --
---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- synopsys translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- synopsys translate_on

entity fifoctlr_ic_v2 is
   port (read_clock_in:   IN  std_logic;
         write_clock_in:  IN  std_logic;
         read_enable_in:  IN  std_logic;
         write_enable_in: IN  std_logic;
         fifo_gsr_in:     IN  std_logic;
         write_data_in:   IN  std_logic_vector(35 downto 0);
         read_data_out:   OUT std_logic_vector(35 downto 0);
         full_out:        OUT std_logic;
         empty_out:       OUT std_logic;
         fifostatus_out:  OUT std_logic_vector(3 downto 0));
END fifoctlr_ic_v2;

architecture fifoctlr_ic_v2_hdl of fifoctlr_ic_v2 is
   signal read_clock:            std_logic;
   signal write_clock:           std_logic;
   signal read_enable:           std_logic;
   signal write_enable:          std_logic;
   signal fifo_gsr:              std_logic;
   signal read_data:             std_logic_vector(35 downto 0);
   signal write_data:            std_logic_vector(35 downto 0);
   signal full:                  std_logic;
   signal empty:                 std_logic;
   signal read_addr:             std_logic_vector(8 downto 0);
   signal read_addrgray:         std_logic_vector(8 downto 0);
   signal read_nextgray:         std_logic_vector(8 downto 0);
   signal read_lastgray:         std_logic_vector(8 downto 0);
   signal write_addr:            std_logic_vector(8 downto 0);
   signal write_addrgray:        std_logic_vector(8 downto 0);
   signal write_nextgray:        std_logic_vector(8 downto 0);
   signal fifostatus:            std_logic_vector(8 downto 0);
   signal read_allow:            std_logic;
   signal write_allow:           std_logic;
   signal empty_allow:           std_logic;
   signal full_allow:            std_logic;
   signal ecomp:                 std_logic_vector(8 downto 0);
   signal fcomp:                 std_logic_vector(8 downto 0);
   signal emuxcyo:               std_logic_vector(8 downto 0);
   signal fmuxcyo:               std_logic_vector(8 downto 0);
   signal emptyg:                std_logic;
   signal fullg:                 std_logic;
   signal read_truegray:         std_logic_vector(8 downto 0);
   signal rag_writesync:         std_logic_vector(8 downto 0);
   signal ra_writesync:          std_logic_vector(8 downto 0);
   signal write_addrr:           std_logic_vector(8 downto 0);
   signal xorout:                std_logic_vector(1 downto 0);
   signal gnd_bus:               std_logic_vector(35 downto 0);
   signal gnd:                   std_logic;
   signal pwr:                   std_logic;
 
component BUFGP
   port (
      I: IN std_logic;
      O: OUT std_logic);
END component;
 
component MUXCY_L
   port (
      DI:  IN std_logic;
      CI:  IN std_logic;
      S:   IN std_logic;
      LO: OUT std_logic);
END component;

component RAMB16_S36_S36
   port ( 
      ADDRA: IN std_logic_vector(8 downto 0);
      ADDRB: IN std_logic_vector(8 downto 0);
      DIA:   IN std_logic_vector(31 downto 0);
      DIB:   IN std_logic_vector(31 downto 0);
      DIPA:  IN std_logic_vector(3 downto 0);
      DIPB:  IN std_logic_vector(3 downto 0);
      WEA:   IN std_logic;
      WEB:   IN std_logic;
      CLKA:  IN std_logic;
      CLKB:  IN std_logic;
      SSRA:  IN std_logic;
      SSRB:  IN std_logic;
      ENA:   IN std_logic;
      ENB:   IN std_logic;
      DOA:   OUT std_logic_vector(31 downto 0);
      DOB:   OUT std_logic_vector(31 downto 0);
      DOPA:  OUT std_logic_vector(3 downto 0);
      DOPB:  OUT std_logic_vector(3 downto 0));
END component;
 
BEGIN
   read_enable <= read_enable_in;
   write_enable <= write_enable_in;
   fifo_gsr <= fifo_gsr_in;
   write_data <= write_data_in;
   read_data_out <= read_data;
   full_out <= full;
   empty_out <= empty;
   fifostatus_out <= fifostatus(8 downto 5);
   gnd_bus <= "000000000000000000000000000000000000";
   gnd <= '0';
   pwr <= '1';

--------------------------------------------------------------------------
--                                                                      --
-- Global input clock buffers are instantianted for both the read_clock --
-- and the write_clock, to avoid skew problems.                         --
--                                                                      --
--------------------------------------------------------------------------

gclk1: BUFGP port map (I => read_clock_in, O => read_clock);
gclk2: BUFGP port map (I => write_clock_in, O => write_clock);

--------------------------------------------------------------------------
--                                                                      --
-- Block RAM instantiation for FIFO.  Module is 512x36, of which one    --
-- address location is sacrificed for the overall speed of the design.  --
--                                                                      --
--------------------------------------------------------------------------

bram1: RAMB16_S36_S36 port map (ADDRA => read_addr, ADDRB => write_addr,
              DIA => gnd_bus(35 downto 4), DIPA => gnd_bus(3 downto 0),
              DIB => write_data(35 downto 4), DIPB => write_data(3 downto 0),
              WEA => gnd, WEB => pwr, CLKA => read_clock, CLKB => write_clock,
              SSRA => gnd, SSRB => gnd, ENA => read_allow, ENB => write_allow,
              DOA => read_data(35 downto 4), DOPA => read_data(3 downto 0) );

----------------------------------------------------------------
--                                                            --
--  Allow flags determine whether FIFO control logic can      --
--  operate.  If read_enable is driven high, and the FIFO is  --
--  not Empty, then Reads are allowed.  Similarly, if the     --
--  write_enable signal is high, and the FIFO is not Full,    --
--  then Writes are allowed.                                  --
--                                                            --
----------------------------------------------------------------

read_allow <= (read_enable AND NOT empty);
write_allow <= (write_enable AND NOT full);

full_allow <= (full OR write_enable);
empty_allow <= (empty OR read_enable);
 
---------------------------------------------------------------
--                                                           --
--  Empty flag is set on fifo_gsr (initial), or when gray    --
--  code counters are equal, or when there is one word in    --
--  the FIFO, and a Read operation is about to be performed. --
--                                                           --
---------------------------------------------------------------

proc1: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      empty <= '1';
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      IF (empty_allow = '1') THEN
         empty <= emptyg;
      END IF;
   END IF;
END PROCESS proc1;
 
---------------------------------------------------------------
--                                                           --
--  Full flag is set on fifo_gsr (initial, but it is cleared --
--  on the first valid write_clock edge after fifo_gsr is    --
--  de-asserted), or when Gray-code counters are one away    --
--  from being equal (the Write Gray-code address is equal   --
--  to the Last Read Gray-code address), or when the Next    --
--  Write Gray-code address is equal to the Last Read Gray-  --
--  code address, and a Write operation is about to be       --
--  performed.                                               --
--                                                           --
---------------------------------------------------------------

proc2: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      full <= '1';
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      IF (full_allow = '1') THEN
         full <= fullg;
      END IF;
   END IF;
END PROCESS proc2;
 
----------------------------------------------------------------
--                                                            --
--  Generation of Read address pointers.  The primary one is  --
--  binary (read_addr), and the Gray-code derivatives are     --
--  generated via pipelining the binary-to-Gray-code result.  --
--  The initial values are important, so they're in sequence. --
--                                                            --
--  Grey-code addresses are used so that the registered       --
--  Full and Empty flags are always clean, and never in an    --
--  unknown state due to the asynchonous relationship of the  --
--  Read and Write clocks.  In the worst case scenario, Full  --
--  and Empty would simply stay active one cycle longer, but  --
--  it would not generate an error or give false values.      --
--                                                            --
----------------------------------------------------------------

proc3: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_addr <= "000000000";
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      IF (read_allow = '1') THEN
         read_addr <= read_addr + 1;
      END IF;
   END IF;
END PROCESS proc3;
 
proc4: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_nextgray <= "100000000";
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      IF (read_allow = '1') THEN
         read_nextgray(8) <= read_addr(8);
         read_nextgray(7) <= read_addr(8) XOR read_addr(7);
         read_nextgray(6) <= read_addr(7) XOR read_addr(6);
         read_nextgray(5) <= read_addr(6) XOR read_addr(5);
         read_nextgray(4) <= read_addr(5) XOR read_addr(4);
         read_nextgray(3) <= read_addr(4) XOR read_addr(3);
         read_nextgray(2) <= read_addr(3) XOR read_addr(2);
         read_nextgray(1) <= read_addr(2) XOR read_addr(1);
         read_nextgray(0) <= read_addr(1) XOR read_addr(0);
      END IF;
   END IF;
END PROCESS proc4;
 
proc5: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_addrgray <= "100000001";
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      IF (read_allow = '1') THEN
         read_addrgray <= read_nextgray;
      END IF;
   END IF;
END PROCESS proc5;
 
proc6: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_lastgray <= "100000011";
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      IF (read_allow = '1') THEN
         read_lastgray <= read_addrgray;
      END IF;
   END IF;
END PROCESS proc6;
 
----------------------------------------------------------------
--                                                            --
--  Generation of Write address pointers.  Identical copy of  --
--  read pointer generation above, except for names.          --
--                                                            --
----------------------------------------------------------------

proc7: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_addr <= "000000000";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      IF (write_allow = '1') THEN
         write_addr <= write_addr + 1;
      END IF;
   END IF;
END PROCESS proc7;
 
proc8: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_nextgray <= "100000000";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      IF (write_allow = '1') THEN
         write_nextgray(8) <= write_addr(8);
         write_nextgray(7) <= write_addr(8) XOR write_addr(7);
         write_nextgray(6) <= write_addr(7) XOR write_addr(6);
         write_nextgray(5) <= write_addr(6) XOR write_addr(5);
         write_nextgray(4) <= write_addr(5) XOR write_addr(4);
         write_nextgray(3) <= write_addr(4) XOR write_addr(3);
         write_nextgray(2) <= write_addr(3) XOR write_addr(2);
         write_nextgray(1) <= write_addr(2) XOR write_addr(1);
         write_nextgray(0) <= write_addr(1) XOR write_addr(0);
      END IF;
   END IF;
END PROCESS proc8;
 
proc9: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_addrgray <= "100000001";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      IF (write_allow = '1') THEN
         write_addrgray <= write_nextgray;
      END IF;
   END IF;
END PROCESS proc9;

----------------------------------------------------------------
--                                                            --
--  Alternative generation of FIFOstatus outputs.  Used to    --
--  determine how full FIFO is, based on how far the Write    --
--  pointer is ahead of the Read pointer.  read_truegray      --   
--  is synchronized to write_clock (rag_writesync), converted --
--  to binary (ra_writesync), and then subtracted from the    --
--  pipelined write_addr (write_addrr) to find out how many   --
--  words are in the FIFO (fifostatus).  The top bits are     --   
--  then 1/2 full, 1/4 full, etc. (not mutually exclusive).   --
--  fifostatus has a one-cycle latency on write_clock; or,    --
--  one cycle after the write address is incremented on a     --   
--  write operation, fifostatus is updated with the new       --   
--  capacity information.  There is a two-cycle latency on    --
--  read operations.                                          --
--                                                            --
--  If read_clock is much faster than write_clock, it is      --   
--  possible that the fifostatus counter could drop several   --
--  positions in one write_clock cycle, so the low-order bits --
--  of fifostatus are not as reliable.                        --
--                                                            --
--  NOTE: If the fifostatus flags are not needed, then this   --
--  section of logic can be trimmed, saving 20+ slices and    --
--  improving the circuit performance.                        --
--                                                            --
----------------------------------------------------------------

proc10: PROCESS (read_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_truegray <= "000000000";
   ELSIF (read_clock'EVENT AND read_clock = '1') THEN
      read_truegray(8) <= read_addr(8);
      read_truegray(7) <= read_addr(8) XOR read_addr(7);
      read_truegray(6) <= read_addr(7) XOR read_addr(6);
      read_truegray(5) <= read_addr(6) XOR read_addr(5);
      read_truegray(4) <= read_addr(5) XOR read_addr(4);
      read_truegray(3) <= read_addr(4) XOR read_addr(3);
      read_truegray(2) <= read_addr(3) XOR read_addr(2);
      read_truegray(1) <= read_addr(2) XOR read_addr(1);
      read_truegray(0) <= read_addr(1) XOR read_addr(0);
   END IF;
END PROCESS proc10;
 
proc11: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      rag_writesync <= "000000000";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      rag_writesync <= read_truegray;
   END IF;
END PROCESS proc11;
 
xorout(0) <= (rag_writesync(8) XOR rag_writesync(7) XOR rag_writesync(6) XOR 
              rag_writesync(5));
xorout(1) <= (rag_writesync(4) XOR rag_writesync(3) XOR rag_writesync(2) XOR 
              rag_writesync(1));

ra_writesync(8) <= rag_writesync(8);
ra_writesync(7) <= (rag_writesync(8) XOR rag_writesync(7));
ra_writesync(6) <= (rag_writesync(8) XOR rag_writesync(7) XOR rag_writesync(6));
ra_writesync(5) <= xorout(0);
ra_writesync(4) <= (xorout(0) XOR rag_writesync(4));
ra_writesync(3) <= (xorout(0) XOR rag_writesync(4) XOR rag_writesync(3));
ra_writesync(2) <= (xorout(0) XOR rag_writesync(4) XOR rag_writesync(3)
                              XOR rag_writesync(2));
ra_writesync(1) <= (xorout(0) XOR xorout(1));
ra_writesync(0) <= (xorout(0) XOR xorout(1) XOR rag_writesync(0));

proc12: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_addrr <= "000000000";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      write_addrr <= write_addr;
   END IF;
END PROCESS proc12;
 
proc13: PROCESS (write_clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      fifostatus <= "000000000";
   ELSIF (write_clock'EVENT AND write_clock = '1') THEN
      IF (full = '0') THEN
         fifostatus <= (write_addrr - ra_writesync);
      END IF;
   END IF;
END PROCESS proc13;

----------------------------------------------------------------
--                                                            --
--  The two conditions decoded with special carry logic are   --
--  Empty and Full (gated versions).  These are used to       --
--  determine the next state of the Full/Empty flags.  Carry  --
--  logic is used for optimal speed.  (The previous           --
--  implementation of AlmostEmpty and AlmostFull have been    --
--  wrapped into the corresponding carry chains for faster    --
--  performance).                                             --
--                                                            --
--  When write_addrgray is equal to read_addrgray, the FIFO   --
--  is Empty, and emptyg (combinatorial) is asserted.  Or,    --
--  when write_addrgray is equal to read_nextgray (1 word in  --
--  the FIFO) then the FIFO potentially could be going Empty, --
--  so emptyg is asserted, and the Empty flip-flop enable is  --
--  gated with empty_allow, which is conditioned with a valid --
--  read.                                                     --
--                                                            --
--  Similarly, when read_lastgray is equal to write_addrgray, --
--  the FIFO is full (511 addresses).  Or, when read_lastgray --
--  is equal to write_nextgray, then the FIFO potentially     --   
--  could be going Full, so fullg is asserted, and the Full   --
--  flip-flop enable is gated with full_allow, which is       --   
--  conditioned with a valid write.                           --
--                                                            --
--  Note: To have utilized the full address space (512)       --   
--  would have required extra logic to determine Full/Empty   --
--  on equal addresses, and this would have slowed down the   --
--  overall performance, which was the top priority.          --   
--                                                            --
----------------------------------------------------------------
 
ecomp(0) <= (NOT (write_addrgray(0) XOR read_addrgray(0)) AND empty) OR
            (NOT (write_addrgray(0) XOR read_nextgray(0)) AND NOT empty);
ecomp(1) <= (NOT (write_addrgray(1) XOR read_addrgray(1)) AND empty) OR
            (NOT (write_addrgray(1) XOR read_nextgray(1)) AND NOT empty);
ecomp(2) <= (NOT (write_addrgray(2) XOR read_addrgray(2)) AND empty) OR
            (NOT (write_addrgray(2) XOR read_nextgray(2)) AND NOT empty);
ecomp(3) <= (NOT (write_addrgray(3) XOR read_addrgray(3)) AND empty) OR
            (NOT (write_addrgray(3) XOR read_nextgray(3)) AND NOT empty);
ecomp(4) <= (NOT (write_addrgray(4) XOR read_addrgray(4)) AND empty) OR
            (NOT (write_addrgray(4) XOR read_nextgray(4)) AND NOT empty);
ecomp(5) <= (NOT (write_addrgray(5) XOR read_addrgray(5)) AND empty) OR
            (NOT (write_addrgray(5) XOR read_nextgray(5)) AND NOT empty);
ecomp(6) <= (NOT (write_addrgray(6) XOR read_addrgray(6)) AND empty) OR
            (NOT (write_addrgray(6) XOR read_nextgray(6)) AND NOT empty);
ecomp(7) <= (NOT (write_addrgray(7) XOR read_addrgray(7)) AND empty) OR
            (NOT (write_addrgray(7) XOR read_nextgray(7)) AND NOT empty);
ecomp(8) <= (NOT (write_addrgray(8) XOR read_addrgray(8)) AND empty) OR
            (NOT (write_addrgray(8) XOR read_nextgray(8)) AND NOT empty);

emuxcy0: MUXCY_L port map (DI=>gnd,CI=>pwr,       S=>ecomp(0),LO=>emuxcyo(0));
emuxcy1: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(0),S=>ecomp(1),LO=>emuxcyo(1));
emuxcy2: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(1),S=>ecomp(2),LO=>emuxcyo(2));
emuxcy3: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(2),S=>ecomp(3),LO=>emuxcyo(3));
emuxcy4: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(3),S=>ecomp(4),LO=>emuxcyo(4));
emuxcy5: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(4),S=>ecomp(5),LO=>emuxcyo(5));
emuxcy6: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(5),S=>ecomp(6),LO=>emuxcyo(6));
emuxcy7: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(6),S=>ecomp(7),LO=>emuxcyo(7));
emuxcy8: MUXCY_L port map (DI=>gnd,CI=>emuxcyo(7),S=>ecomp(8),LO=>emptyg);

fcomp(0) <= (NOT (read_lastgray(0) XOR write_addrgray(0)) AND full) OR
            (NOT (read_lastgray(0) XOR write_nextgray(0)) AND NOT full);
fcomp(1) <= (NOT (read_lastgray(1) XOR write_addrgray(1)) AND full) OR
            (NOT (read_lastgray(1) XOR write_nextgray(1)) AND NOT full);
fcomp(2) <= (NOT (read_lastgray(2) XOR write_addrgray(2)) AND full) OR
            (NOT (read_lastgray(2) XOR write_nextgray(2)) AND NOT full);
fcomp(3) <= (NOT (read_lastgray(3) XOR write_addrgray(3)) AND full) OR
            (NOT (read_lastgray(3) XOR write_nextgray(3)) AND NOT full);
fcomp(4) <= (NOT (read_lastgray(4) XOR write_addrgray(4)) AND full) OR
            (NOT (read_lastgray(4) XOR write_nextgray(4)) AND NOT full);
fcomp(5) <= (NOT (read_lastgray(5) XOR write_addrgray(5)) AND full) OR
            (NOT (read_lastgray(5) XOR write_nextgray(5)) AND NOT full);
fcomp(6) <= (NOT (read_lastgray(6) XOR write_addrgray(6)) AND full) OR
            (NOT (read_lastgray(6) XOR write_nextgray(6)) AND NOT full);
fcomp(7) <= (NOT (read_lastgray(7) XOR write_addrgray(7)) AND full) OR
            (NOT (read_lastgray(7) XOR write_nextgray(7)) AND NOT full);
fcomp(8) <= (NOT (read_lastgray(8) XOR write_addrgray(8)) AND full) OR
            (NOT (read_lastgray(8) XOR write_nextgray(8)) AND NOT full);

fmuxcy0: MUXCY_L port map (DI=>gnd,CI=>pwr,       S=>fcomp(0),LO=>fmuxcyo(0));
fmuxcy1: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(0),S=>fcomp(1),LO=>fmuxcyo(1));
fmuxcy2: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(1),S=>fcomp(2),LO=>fmuxcyo(2));
fmuxcy3: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(2),S=>fcomp(3),LO=>fmuxcyo(3));
fmuxcy4: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(3),S=>fcomp(4),LO=>fmuxcyo(4));
fmuxcy5: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(4),S=>fcomp(5),LO=>fmuxcyo(5));
fmuxcy6: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(5),S=>fcomp(6),LO=>fmuxcyo(6));
fmuxcy7: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(6),S=>fcomp(7),LO=>fmuxcyo(7));
fmuxcy8: MUXCY_L port map (DI=>gnd,CI=>fmuxcyo(7),S=>fcomp(8),LO=>fullg);

END fifoctlr_ic_v2_hdl;

