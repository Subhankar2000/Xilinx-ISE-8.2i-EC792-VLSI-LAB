library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SMALLCNTR is
    port (CE, CLK, CLR : in std_logic;
	  qout : out std_logic_vector(3 downto 0));
end SMALLCNTR;

architecture XILINX of SMALLCNTR is

signal QOUTSIG : std_logic_vector(3 downto 0);
    
begin

process(CE, CLK, CLR)
begin
  if (CLR = '1') then
    QOUTSIG <= "0000";
  elsif (CLK'event) then
    if (CE = '1') then
      if (QOUTSIG = "1001") then
        QOUTSIG <= "0000";
      else
        QOUTSIG <= QOUTSIG + "0001";
      end if;
    end if;
  end if;
end process;

QOUT <= QOUTSIG;
    
end XILINX;
