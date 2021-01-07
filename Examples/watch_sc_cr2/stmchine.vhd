library IEEE;
use IEEE.std_logic_1164.all;

entity stmchine is
port(CLK, RESET, STRTSTOP : in STD_LOGIC;
     CLKEN, RST : out STD_LOGIC
    );
end stmchine;

architecture inside of stmchine is

type stmchine_state is (clear, zero, start, counting, stop, stopped);
attribute syn_encoding : string;
attribute syn_encoding of stmchine_state : type is "binary";
signal current_state, next_state : stmchine_state;

begin

process(STRTSTOP, current_state)
   begin
   -- Assign defaults, so as not to set them in every state
      CLKEN <= '0';
      RST <= '0';
	case current_state is
	    when clear => next_state <= zero;
                   RST <= '1';
	    when zero =>
		if (STRTSTOP = '0') then
		   next_state <= zero;
		elsif (STRTSTOP = '1') then
		   next_state <= start;
		end if;
	    when start =>
		if (STRTSTOP = '0') then
		   next_state <= counting;
		elsif(STRTSTOP = '1') then
		   next_state <= start;
		end if;
	    when counting =>
		if (STRTSTOP = '0') then
		   next_state <= counting;
		elsif (STRTSTOP = '1') then
		   next_state <= stop;
		end if;
		   CLKEN <= '1';
	    when stop =>
		if (STRTSTOP = '0') then
		   next_state <= stopped;
		elsif (STRTSTOP = '1') then
		   next_state <= stop;
		end if;
	    when stopped =>
		if (STRTSTOP = '0') then
		   next_state <= stopped;
		elsif (STRTSTOP = '1') then
		   next_state <= start;
		end if;
            when others => null;
	end case;
    end process;

process(RESET, CLK)
    begin
	if (RESET = '1') then
	    current_state <= clear;
elsif (CLK'event) then
--	elsif (CLK'event and CLK='1') then
	    current_state <= next_state;
	end if;
    end process;

end inside;
