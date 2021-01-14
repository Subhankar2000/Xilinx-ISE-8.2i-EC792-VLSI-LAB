// Module dcm1
// Generated by Xilinx Architecture Wizard
// Verilog
// Written for synthesis tool: LeonardoSpectrum

module dcm1(
      RST_IN,
      LOCKED_OUT,
      CLKIN_IN,
      CLK0_OUT,
      CLKIN_IBUFG_OUT);

input RST_IN;
input CLKIN_IN;

output LOCKED_OUT;
output CLK0_OUT;
output CLKIN_IBUFG_OUT;

wire CLKIN_IBUFG;
wire CLKFB_IN;
wire CLK0_BUF;

assign CLKIN_IBUFG_OUT = CLKIN_IBUFG;
assign CLK0_OUT = CLKFB_IN;

DCM DCM_INST(
    .CLKIN (CLKIN_IBUFG),
    .CLKFB (CLKFB_IN),
    .RST (RST_IN),
    .PSEN (1'b0),
    .PSINCDEC (1'b0),
    .PSCLK (1'b0),
    .DSSEN (1'b0),
    .CLK0 (CLK0_BUF),
    .CLK90 (),
    .CLK180 (),
    .CLK270 (),
    .CLKDV (),
    .CLK2X (),
    .CLK2X180 (),
    .CLKFX (),
    .CLKFX180 (),
    .STATUS (),
    .LOCKED (LOCKED_OUT),
    .PSDONE ());
// exemplar attribute DCM_INST CLK_FEEDBACK 1X
// exemplar attribute DCM_INST CLKDV_DIVIDE 2
// exemplar attribute DCM_INST CLKFX_DIVIDE 1
// exemplar attribute DCM_INST CLKFX_MULTIPLY 4
// exemplar attribute DCM_INST CLKIN_DIVIDE_BY_2 FALSE
// exemplar attribute DCM_INST CLKIN_PERIOD 20
// exemplar attribute DCM_INST CLKOUT_PHASE_SHIFT NONE
// exemplar attribute DCM_INST DESKEW_ADJUST SYSTEM_SYNCHRONOUS
// exemplar attribute DCM_INST DFS_FREQUENCY_MODE LOW
// exemplar attribute DCM_INST DLL_FREQUENCY_MODE LOW
// exemplar attribute DCM_INST DUTY_CYCLE_CORRECTION TRUE
// exemplar attribute DCM_INST PHASE_SHIFT 0
// exemplar attribute DCM_INST STARTUP_WAIT TRUE
// synthesis translate_off
 defparam DCM_INST.CLK_FEEDBACK="1X";
 defparam DCM_INST.CLKDV_DIVIDE=2;
 defparam DCM_INST.CLKFX_DIVIDE=1;
 defparam DCM_INST.CLKFX_MULTIPLY=4;
 defparam DCM_INST.CLKIN_DIVIDE_BY_2="FALSE";
 defparam DCM_INST.CLKIN_PERIOD=20;
 defparam DCM_INST.CLKOUT_PHASE_SHIFT="NONE";
 defparam DCM_INST.DESKEW_ADJUST="SYSTEM_SYNCHRONOUS";
 defparam DCM_INST.DFS_FREQUENCY_MODE="LOW";
 defparam DCM_INST.DLL_FREQUENCY_MODE="LOW";
 defparam DCM_INST.DUTY_CYCLE_CORRECTION="TRUE";
 defparam DCM_INST.PHASE_SHIFT=0;
 defparam DCM_INST.STARTUP_WAIT="TRUE";
// synthesis translate_on

IBUFG CLKIN_IBUFG_INST(
    .I (CLKIN_IN),
    .O (CLKIN_IBUFG));

BUFG CLK0_BUFG_INST(
    .I (CLK0_BUF),
    .O (CLKFB_IN));

endmodule