library IEEE;
use IEEE.std_logic_1164.all;
use  IEEE.std_logic_arith.all;
use  IEEE.std_logic_unsigned.all;

entity control is 
  port (CLK: in STD_LOGIC;
        RESET: in STD_LOGIC;
        START: in STD_LOGIC;
        END_MEASURE: out STD_LOGIC;
        GATE: out STD_LOGIC);
end;

architecture control_arch of control is

type Sreg0_type is (END_CYCLE, IDLE, OPEN_GATE);
signal Sreg0: Sreg0_type;

begin

Sreg0_machine: process (CLK, reset)

begin

if RESET='1' then
	GATE <= '0';
	END_MEASURE <= '1';
	Sreg0 <= IDLE;
elsif CLK'event and CLK = '1' then
	case Sreg0 is
		when END_CYCLE =>
			if START='1' then
				Sreg0 <= END_CYCLE;
				GATE <= '1';
				END_MEASURE <= '0';
			elsif START='0' then
				Sreg0 <= IDLE;
				GATE <= '0';
				END_MEASURE <= '1';
			end if;
		when IDLE =>
			if START='1' then
				Sreg0 <= OPEN_GATE;
				GATE <= '1';
				END_MEASURE <= '0';
			elsif START='0' then
				Sreg0 <= IDLE;
				GATE <= '0';
				END_MEASURE <= '1';
			end if;
		when OPEN_GATE =>
			Sreg0 <= END_CYCLE;
			GATE <= '0';
			END_MEASURE <= '0';
		when others =>
			null;
	end case;
end if;
end process;

end control_arch;
