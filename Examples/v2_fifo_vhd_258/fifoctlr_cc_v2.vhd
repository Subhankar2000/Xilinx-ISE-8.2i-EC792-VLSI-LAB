
---------------------------------------------------------------------------
--                                                                       --
--  Module      : fifoctlr_cc_v2.vhd              Last Update: 08/28/00  --
--                                                                       --
--  Description : FIFO controller top level.                             --
--                Implements a 511x36 FIFO w/common read/write clocks.   --
--                                                                       --
--  The following VHDL code implements a 511x36 FIFO in a Virtex2        --
--  device.  The inputs are a Clock, a Read Enable, a Write Enable,      --
--  Write Data, and a FIFO_gsr signal as an initial reset.  The outputs  --
--  are Read Data, Full, Empty, and the FIFOcount outputs, which         --
--  indicate how full the FIFO is.                                       --
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

entity fifoctlr_cc_v2 is
   port (clock_in:        IN  std_logic;
         read_enable_in:  IN  std_logic;
         write_enable_in: IN  std_logic;
         write_data_in:   IN  std_logic_vector(35 downto 0);
         fifo_gsr_in:     IN  std_logic;
         read_data_out:   OUT std_logic_vector(35 downto 0);
         full_out:        OUT std_logic;
         empty_out:       OUT std_logic;
         fifocount_out:   OUT std_logic_vector(3 downto 0));
END fifoctlr_cc_v2;

architecture fifoctlr_cc_v2_hdl of fifoctlr_cc_v2 is
   signal clock:                 std_logic;
   signal read_enable:           std_logic;
   signal write_enable:          std_logic;
   signal fifo_gsr:              std_logic;
   signal read_data:             std_logic_vector(35 downto 0) := "000000000000000000000000000000000000";
   signal write_data:            std_logic_vector(35 downto 0);
   signal full:                  std_logic;
   signal empty:                 std_logic;
   signal read_addr:             std_logic_vector(8 downto 0) := "000000000";
   signal write_addr:            std_logic_vector(8 downto 0) := "000000000";
   signal fcounter:              std_logic_vector(8 downto 0) := "000000000";
   signal read_allow:            std_logic;
   signal write_allow:           std_logic;
   signal fcnt_allow:            std_logic;
   signal fcntandout:            std_logic_vector(3 downto 0);
   signal ra_or_fcnt0:           std_logic;
   signal wa_or_fcnt0:           std_logic;
   signal emptyg:                std_logic;
   signal fullg:                 std_logic;
   signal gnd_bus:               std_logic_vector(35 downto 0);
   signal gnd:                   std_logic;
   signal pwr:                   std_logic;

component BUFGP
   port (
      I: IN std_logic;  
      O: OUT std_logic);
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
   gnd_bus <= "000000000000000000000000000000000000";
   gnd <= '0';
   pwr <= '1';
   
--------------------------------------------------------------------------
--                                                                      --
-- A global buffer is instantianted to avoid skew problems.             -- 
--                                                                      --
--------------------------------------------------------------------------
 
gclk1: BUFGP port map (I => clock_in, O => clock);

--------------------------------------------------------------------------
--                                                                      --
-- Block RAM instantiation for FIFO.  Module is 512x36, of which one    -- 
-- address location is sacrificed for the overall speed of the design.  --
--                                                                      --
--------------------------------------------------------------------------

bram1: RAMB16_S36_S36 port map (ADDRA => read_addr, ADDRB => write_addr, 
              DIA => gnd_bus(35 downto 4), DIPA => gnd_bus(3 downto 0),
              DIB => write_data(35 downto 4), DIPB => write_data(3 downto 0),
              WEA => gnd, WEB => pwr, CLKA => clock, CLKB => clock, 
              SSRA => gnd, SSRB => gnd, ENA => read_allow, ENB => write_allow, 
              DOA => read_data(35 downto 4), DOPA => read_data(3 downto 0) );

---------------------------------------------------------------
--                                                           --
--  Set allow flags, which control the clock enables for     --
--  read, write, and count operations.                       --
--                                                           --
---------------------------------------------------------------
 
proc1: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_allow <= '0';
   ELSIF (clock'EVENT AND clock = '1') THEN
      read_allow <= read_enable AND NOT (fcntandout(0) AND fcntandout(1)
                    AND NOT write_allow);
   END IF;
END PROCESS proc1;

proc2: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_allow <= '0';
   ELSIF (clock'EVENT AND clock = '1') THEN
      write_allow <= write_enable AND NOT (fcntandout(2) AND fcntandout(3)
                     AND NOT read_allow);
   END IF;
END PROCESS proc2;

fcnt_allow <= write_allow XOR read_allow;

---------------------------------------------------------------
--                                                           --
--  Empty flag is set on fifo_gsr (initial), or when on the  --
--  next clock cycle, Write Enable is low, and either the    --
--  FIFOcount is equal to 0, or it is equal to 1 and Read    --
--  Enable is high (about to go Empty).                      --
--                                                           --
---------------------------------------------------------------

ra_or_fcnt0 <= (read_allow OR NOT fcounter(0));
fcntandout(0) <= NOT (fcounter(4) OR fcounter(3) OR fcounter(2) OR fcounter(1) OR fcounter(0));
fcntandout(1) <= NOT (fcounter(8) OR fcounter(7) OR fcounter(6) OR fcounter(5));
emptyg <= (fcntandout(0) AND fcntandout(1) AND ra_or_fcnt0 AND NOT write_allow);

proc3: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      empty <= '1';
   ELSIF (clock'EVENT AND clock = '1') THEN
      empty <= emptyg;
   END IF;
END PROCESS proc3;

---------------------------------------------------------------
--                                                           --
--  Full flag is set on fifo_gsr (but it is cleared on the   --
--  first valid clock edge after fifo_gsr is removed), or    --
--  when on the next clock cycle, Read Enable is low, and    --
--  either the FIFOcount is equal to 1FF (hex), or it is     --
--  equal to 1FE and the Write Enable is high (about to go   --
--  Full).                                                   --
--                                                           --
---------------------------------------------------------------

wa_or_fcnt0 <= (write_allow OR fcounter(0));
fcntandout(2) <= (fcounter(4) AND fcounter(3) AND fcounter(2) AND fcounter(1));
fcntandout(3) <= (fcounter(8) AND fcounter(7) AND fcounter(6) AND fcounter(5));
fullg <= (fcntandout(2) AND fcntandout(3) AND wa_or_fcnt0 AND NOT read_allow);

proc4: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      full <= '1';
   ELSIF (clock'EVENT AND clock = '1') THEN
      full <= fullg;
   END IF;
END PROCESS proc4;

----------------------------------------------------------------
--                                                            --
--  Generation of Read and Write address pointers.  They now  --
--  use binary counters, because it is simpler in simulation, --
--  and the previous LFSR implementation wasn't in the        --
--  critical path.                                            --
--                                                            --
----------------------------------------------------------------

proc5: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      read_addr <= "000000000";
   ELSIF (clock'EVENT AND clock = '1') THEN
      IF (read_allow = '1') THEN
         read_addr <= read_addr + '1';
      END IF;
   END IF;
END PROCESS proc5;

proc6: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      write_addr <= "000000000";
   ELSIF (clock'EVENT AND clock = '1') THEN
      IF (write_allow = '1') THEN
         write_addr <= write_addr + '1';
      END IF;
   END IF;
END PROCESS proc6;

----------------------------------------------------------------
--                                                            --
--  Generation of FIFOcount outputs.  Used to determine how   --
--  full FIFO is, based on a counter that keeps track of how  --
--  many words are in the FIFO.  Also used to generate Full   --
--  and Empty flags.  Only the upper four bits of the counter --
--  are sent outside the module.                              --
--                                                            --
----------------------------------------------------------------

proc7: PROCESS (clock, fifo_gsr)
BEGIN
   IF (fifo_gsr = '1') THEN
      fcounter <= "000000000";
   ELSIF (clock'EVENT AND clock = '1') THEN
      IF (fcnt_allow = '1') THEN
         IF (read_allow = '0') THEN
            fcounter <= fcounter + '1';
         ELSE
            fcounter <= fcounter - '1';
         END IF;
      END IF;
   END IF;
END PROCESS proc7;

fifocount_out <= fcounter(8 downto 5);

END fifoctlr_cc_v2_hdl;

