
LIBRARY ieee;
--LIBRARY generics;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--USE generics.components.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT freqm
	PORT(
		F_INPUT : IN std_logic;
		F_PATTERN : IN std_logic;
		RESET : IN std_logic;
		START : IN std_logic;          
		FULL : OUT std_logic;
		LED_A : OUT std_logic_vector(6 downto 0);
		LED_B : OUT std_logic_vector(6 downto 0);
		LED_C : OUT std_logic_vector(6 downto 0);
		LED_D : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;

	SIGNAL F_INPUT :  std_logic;
	SIGNAL F_PATTERN :  std_logic;
	SIGNAL FULL :  std_logic;
	SIGNAL LED_A :  std_logic_vector(6 downto 0);
	SIGNAL LED_B :  std_logic_vector(6 downto 0);
	SIGNAL LED_C :  std_logic_vector(6 downto 0);
	SIGNAL LED_D :  std_logic_vector(6 downto 0);
	SIGNAL RESET :  std_logic;
	SIGNAL START :  std_logic;

BEGIN

	uut: freqm PORT MAP(
		F_INPUT => F_INPUT,
		F_PATTERN => F_PATTERN,
		FULL => FULL,
		LED_A => LED_A,
		LED_B => LED_B,
		LED_C => LED_C,
		LED_D => LED_D,
		RESET => RESET,
		START => START
	);


-- *** Test Bench - User Defined Section ***
   F_INPUT1 : PROCESS
   BEGIN
      F_INPUT <= '1'; wait for 25 ns;
	   F_INPUT <= '0'; wait for 25 ns;
   END PROCESS;

	F_PATTERN1 : PROCESS
	BEGIN
		F_PATTERN <= '1'; wait for 2.640 ns;
		F_PATTERN <= '0'; wait for 2.640 ns;
	END PROCESS;


	RESET1 : PROCESS
	BEGIN
		RESET <= '1'; wait for 4.975 us;
		RESET <= '0'; wait for 60 us;
		RESET <= '1'; wait for 10 us;
		RESET <= '0'; wait;
	END PROCESS;

	START1 : PROCESS
	BEGIN
		START <= '1'; wait for 30.001 us;
		START <= '0'; wait for 5.0005 us;
		START <= '1'; wait;
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;

