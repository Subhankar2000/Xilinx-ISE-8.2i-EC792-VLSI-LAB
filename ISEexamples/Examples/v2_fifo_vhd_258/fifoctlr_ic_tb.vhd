LIBRARY  ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

LIBRARY  unisim;
USE unisim.Vcomponents.all;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY tb_ic IS
END tb_ic;

ARCHITECTURE tb_ic_arch OF tb_ic IS

	COMPONENT fifoctlr_ic_v2
		PORT (
			read_clock_in:   IN  std_logic;
         write_clock_in:  IN  std_logic;
         read_enable_in:  IN  std_logic;
         write_enable_in: IN  std_logic;
         fifo_gsr_in:     IN  std_logic;
         write_data_in:   IN  std_logic_vector(35 downto 0);
         read_data_out:   OUT std_logic_vector(35 downto 0);
         full_out:        OUT std_logic;
         empty_out:       OUT std_logic;
         fifostatus_out:  OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	SIGNAL read_clock_in : std_logic;
	SIGNAL write_clock_in : std_logic;
	SIGNAL read_enable_in : std_logic;
	SIGNAL write_enable_in : std_logic;
	signal read_data_out : std_logic_vector(35 downto 0);
   signal write_data_in : std_logic_vector(35 downto 0);
	SIGNAL fifo_gsr_in : std_logic;
	SIGNAL full_out : std_logic;
	SIGNAL empty_out : std_logic;
	SIGNAL fifostatus_out : std_logic_vector (3 DOWNTO 0);

BEGIN
	UUT : fifoctlr_ic_v2
	PORT MAP (
		read_clock_in => read_clock_in,
		write_clock_in => write_clock_in,
		read_enable_in => read_enable_in,
		write_enable_in => write_enable_in,
		write_data_in => write_data_in,
		fifo_gsr_in => fifo_gsr_in,
		read_data_out => read_data_out,
		full_out => full_out,
		empty_out => empty_out,
		fifostatus_out => fifostatus_out
	);

	PROCESS -- write_clock_in 50Mhz process
	BEGIN
		CLOCK_LOOP : LOOP
		write_clock_in <= transport '0';
		WAIT FOR 8 ns;
		write_clock_in <= transport '1';
		WAIT FOR 12 ns;
		WAIT FOR 8 ns;
		write_clock_in <= transport '0';
		WAIT FOR 12 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

   PROCESS -- read_clock_in 15Mhz process
	BEGIN
		CLOCK_LOOP : LOOP
		read_clock_in <= transport '0';
		WAIT FOR 26.8 ns;
		read_clock_in <= transport '1';
		WAIT FOR 40.2 ns;
		WAIT FOR 26.8 ns;
		read_clock_in <= transport '0';
		WAIT FOR 40.2 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS
		BEGIN
		-- --------------------
		read_enable_in <= transport '0';
		write_enable_in <= transport '0';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		fifo_gsr_in <= transport '1';
		-- --------------------
		WAIT FOR 120 ns; -- Time=120 ns
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 40 ns; -- Time=160 ns
		write_enable_in <= transport '1';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000000"); --0
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 40 ns; -- Time=200 ns
		write_enable_in <= transport '1';
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000001"); --1
		fifo_gsr_in <= transport '0';
		-- --------------------
		WAIT FOR 40 ns; -- Time=240 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000010"); --2
		-- --------------------
		WAIT FOR 40 ns; -- Time=280 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000011"); --3
		-- --------------------
		WAIT FOR 40 ns; -- Time=320 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000100"); --4
		-- --------------------
		WAIT FOR 40 ns; -- Time=360 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000101"); --5
		-- --------------------
		WAIT FOR 40 ns; -- Time=400 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000110"); --6
		-- --------------------
		WAIT FOR 40 ns; -- Time=440 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000000111"); --7
		-- --------------------
		WAIT FOR 40 ns; -- Time=480 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001000"); --8
		-- --------------------
		WAIT FOR 40 ns; -- Time=520 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001001"); --9
		-- --------------------
		WAIT FOR 40 ns; -- Time=560 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001010"); --A
		-- --------------------
		WAIT FOR 40 ns; -- Time=600 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001011"); --B
		-- --------------------
		WAIT FOR 40 ns; -- Time=640 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001100"); --C
		-- --------------------
		WAIT FOR 40 ns; -- Time=680 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001101"); --D
		-- --------------------
		WAIT FOR 40 ns; -- Time=720 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001110"); --E
		-- --------------------
		WAIT FOR 40 ns; -- Time=760 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000001111"); --F
		-- --------------------
		WAIT FOR 40 ns; -- Time=800 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010000"); --10
		-- --------------------
		WAIT FOR 40 ns; -- Time=840 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010001"); --11
		-- --------------------
		WAIT FOR 40 ns; -- Time=880 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010010"); --12
		-- --------------------
		WAIT FOR 40 ns; -- Time=920 ns
		write_data_in <= transport std_logic_vector'("000000000000000000000000000000010011"); --13
		-- --------------------
		WAIT FOR 40 ns; -- Time=960 ns
		read_enable_in <= transport '1';
		write_enable_in <= transport '0';
      -- --------------------
		WAIT FOR 988 ns; -- Time=1948 ns
		-- --------------------

END PROCESS;
END tb_ic_arch;

CONFIGURATION fifoctlr_cc_cfg OF tb_ic IS
	FOR tb_ic_arch
	END FOR;
END fifoctlr_cc_cfg;
