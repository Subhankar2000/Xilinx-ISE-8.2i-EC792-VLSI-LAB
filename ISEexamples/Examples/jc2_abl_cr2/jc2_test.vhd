-- VHDL Test Bench for jc2_top design functional and timing simulation

LIBRARY  IEEE;
USE IEEE.std_logic_1164.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
	COMPONENT jc2_top
		PORT (
			CLKIN : in  STD_LOGIC;
			CDRST : in  STD_LOGIC;
			LEFT : in  STD_LOGIC;
			RIGHT : in  STD_LOGIC;
			STOP : in  STD_LOGIC;
         		Q: inout STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL CDRST : STD_LOGIC;
	SIGNAL CLK : STD_LOGIC;
	SIGNAL LEFT : STD_LOGIC;
	SIGNAL RIGHT : STD_LOGIC;
	SIGNAL STOP : STD_LOGIC;
	SIGNAL Q : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN
	UUT : jc2_top
	PORT MAP (
		LEFT => LEFT,
		RIGHT => RIGHT,
		STOP => STOP,
		CLKIN => CLK,
		CDRST => CDRST,
		Q => Q
	);

	RESET_P: PROCESS
		BEGIN
		CDRST <= transport '1';
    		WAIT FOR 50 ns;
		CDRST <= transport '0';
		WAIT;
	END PROCESS;

	CLK_P : PROCESS
		BEGIN
      	CLK <= '0'; wait for 10 ns; 
		CLK <= '1'; wait for 10 ns;
	END PROCESS;
   

	Control_P: PROCESS
		BEGIN
		LEFT <= transport '1';
		RIGHT <= transport '1';
		STOP <= transport '1';
		-- --------------------
		WAIT FOR 140 ns;
		LEFT <= transport '0';
		-- --------------------
		WAIT FOR 200 ns;
		LEFT <= transport '1';
		-- --------------------
		WAIT FOR 300 ns;
		STOP <= transport '0';
		-- --------------------
		WAIT FOR 200 ns;
		STOP <= transport '1';
		-- --------------------
		WAIT FOR 160 ns;
		RIGHT <= transport '0';
		-- --------------------
	    	WAIT FOR 400 ns;
		LEFT <= transport '0';
		-- --------------------
		WAIT FOR 1000 ns;
		RIGHT <= transport '1';
		-- --------------------
 		WAIT FOR 160 ns;
		LEFT <= transport '1';
		-- --------------------
		WAIT FOR 400 ns;
		-- --------------------
		WAIT;
	END PROCESS;
END testbench_arch;

CONFIGURATION jc2_top_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END jc2_top_cfg;
