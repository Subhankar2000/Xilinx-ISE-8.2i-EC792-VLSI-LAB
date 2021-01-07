library IEEE;
use IEEE.std_logic_1164.all;


entity tenths is
port(
    CLK_EN: IN std_logic;
    CLOCK: IN std_logic;
    ASYNC_CTRL: IN std_logic;
    Q_OUT: OUT std_logic_vector(9 DOWNTO 0);
    TERM_CNT: OUT std_logic
);
end tenths;

architecture inside of tenths is

type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
attribute enum_encoding: string;
attribute enum_encoding of state_type: type is "0000000001 0000000010 0000000100 0000001000 0000010000 0000100000 0001000000 0010000000 0100000000 1000000000";

signal cs: state_type;
signal ns: state_type;

begin

process(CLK_EN,CLOCK,ASYNC_CTRL)
begin
if(ASYNC_CTRL='1') then
cs <= s0;
elsif(CLK_EN='1') then
if(CLOCK'event) then
--	if(CLOCK'event and CLOCK='1') then
		cs <= ns;
	end if;
end if;
end process;

process(cs)
begin
case cs is
when s0=>
	ns<=s1;
	Q_OUT<="0000000001";
when s1=>
	ns<=s2;
	Q_OUT<="0000000010";
when s2=>
	ns<=s3;
	Q_OUT<="0000000100";
when s3=>
	ns<=s4;
	Q_OUT<="0000001000";
when s4=>
	ns<=s5;
	Q_OUT<="0000010000";
when s5=>
	ns<=s6;
	Q_OUT<="0000100000";
when s6=>
	ns<=s7;
	Q_OUT<="0001000000";
when s7=>
	ns<=s8;
	Q_OUT<="0010000000";
when s8=>
	ns<=s9;
	Q_OUT<="0100000000";
when s9=>
	ns<=s0;
	Q_OUT<="1000000000";
end case;
end process;

process(cs)
begin
if(cs=s9) then
TERM_CNT<='1';
else
TERM_CNT<='0';
end if;
end process;

end inside;
