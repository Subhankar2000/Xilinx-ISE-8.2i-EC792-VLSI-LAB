LIBRARY  ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY  UNISIM;
USE UNISIM.Vcomponents.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
	COMPONENT FLASH
		PORT (
			clkin : In  std_logic;
			reset : In  std_logic;
			HALFCLK : Out  std_logic;
			LED : Out  std_logic_vector (6 DOWNTO 0);
			P_Q7, P_Q6, P_Q5, P_Q4, P_Q3, P_Q2, P_Q1, P_Q0  : Out  std_logic
		);
	END COMPONENT;

	SIGNAL clkin : std_logic;
	SIGNAL reset : std_logic;
	SIGNAL HALFCLK : std_logic;
	SIGNAL LED : std_logic_vector (6 DOWNTO 0);
	SIGNAL P_Q : std_logic_vector (7 DOWNTO 0);

BEGIN
	UUT : FLASH
	PORT MAP (
		clkin => clkin,
		reset => reset,
		HALFCLK => HALFCLK,
		LED => LED,
		P_Q7 => P_Q(7),
		P_Q6 => P_Q(6),
		P_Q5 => P_Q(5),
		P_Q4 => P_Q(4),
		P_Q3 => P_Q(3),
		P_Q2 => P_Q(2),
		P_Q1 => P_Q(1),
		P_Q0 => P_Q(0)
	);

	PROCESS
		begin
			reset <= '1'; wait for 50 ns;
			reset <= '0'; wait;
	end process;

	PROCESS
		begin
			clkin <= '1'; wait for 20 ns;
			clkin <= '0'; wait for 20 ns;
	END PROCESS;
		
END testbench_arch;

CONFIGURATION FLASH_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END FLASH_cfg;
