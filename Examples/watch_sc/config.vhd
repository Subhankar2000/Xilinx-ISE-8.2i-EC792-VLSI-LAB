**** VHDL Based Design ****

library XilinxCoreLib;

CONFIGURATION stopwatch_cfg OF testbench IS

	FOR testbench_arch

		FOR ALL : stopwatch use configuration work.cfg_tenths;

		END FOR;

	END FOR;

END stopwatch_cfg;


**** Schematic Based Design ****

library XilinxCoreLib;

CONFIGURATION stopwatch_cfg OF testbench IS
	FOR testbench_arch
		for all : stopwatch use entity work.stopwatch(schematic);
         for schematic 
				for all : tenths use entity XilinxCoreLib.C_COUNTER_BINARY_V1_0(behavioral)
					generic map(
						c_sinit_val => "0",
						c_load_enable => 1,
						c_has_up => 0,
						c_sync_enable => 0,
						c_has_ainit => 1,
						c_sync_priority => 1,
						c_has_q_thresh1 => 0,
						c_has_q_thresh0 => 1,
						c_has_sinit => 0,
						c_thresh1_value => "1111111111111111",
						c_has_thresh1 => 0,
						c_has_thresh0 => 0,
						c_ainit_val => "0001",
						c_has_sset => 0,
						c_width => 4,
						c_load_low => 0,
						c_count_to => "1010",
						c_has_iv => 0,
						c_count_mode => 0,
						c_has_l => 0,
						c_has_aset => 0,
						c_has_sclr => 0,
						c_thresh0_value => "1010",
						c_pipe_stages => 0,
						c_has_load => 0,
						c_has_ce => 1,
						c_has_aclr => 0,
						c_count_by => "0001",
						c_restrict_count => 1,
						c_enable_rlocs => 1);
				end for;
			end for;
		end for;
	END FOR;
END stopwatch_cfg;
