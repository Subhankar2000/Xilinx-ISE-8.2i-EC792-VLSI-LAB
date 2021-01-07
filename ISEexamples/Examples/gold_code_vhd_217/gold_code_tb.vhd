LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench IS
generic (width : integer := 1);
END testbench;

ARCHITECTURE behavior OF testbench IS 

	COMPONENT gold_code
	PORT(
			Clk :in std_logic;
 			Enable : in std_logic;
			Fill_En_A : in std_logic;
			Fill_En_B : in std_logic;
			New_Fill_A : in std_logic_vector(width -1 downto 0);
			New_Fill_B : in std_logic_vector(width -1 downto 0);
			Gold_Code_r :out std_logic_vector(width - 1 downto 0)
		);
	END COMPONENT;

	SIGNAL Clk :  std_logic;
	SIGNAL Enable :  std_logic;
	SIGNAL Fill_En_A :  std_logic;
	SIGNAL Fill_En_B :  std_logic;
	SIGNAL New_Fill_A : std_logic_vector(width -1 downto 0);
	SIGNAL New_Fill_B : std_logic_vector(width -1 downto 0);
	SIGNAL Gold_Code_r : std_logic_vector(width - 1 downto 0);

BEGIN

	uut: gold_code 
		PORT MAP(
		Clk => Clk,
		Enable => Enable,
		Fill_En_A => Fill_En_A,
		Fill_En_B => Fill_En_B,
		New_Fill_A => New_Fill_A,
		New_Fill_B => New_Fill_B,
		Gold_Code_r => Gold_Code_r
	);

	tb_clk : PROCESS
   BEGIN
      clk <= '0'; wait for 20 ns; 
		clk <= '1'; wait for 20 ns;
   END PROCESS;

	tb_fill : PROCESS
	BEGIN
		Fill_En_A <= '0';
		Fill_En_B <= '0'; wait for 800 ns;
		Fill_En_A <= '1'; wait for 800 ns;
		Fill_En_B <= '1'; wait for 800 ns;
	END PROCESS;

	tb_new : PROCESS
	BEGIN
		Enable <= '1';
		New_Fill_A <= "0";
		New_Fill_B <= "0"; wait for 1 us;
      New_Fill_A <= "1"; wait for 1 us;
      New_Fill_B <= "1"; wait for 2 us;
      New_Fill_A <= "0";
      New_Fill_B <= "0"; wait for 3 us;
      New_Fill_A <= "1";
      New_Fill_B <= "1";
	END PROCESS;   
END;

