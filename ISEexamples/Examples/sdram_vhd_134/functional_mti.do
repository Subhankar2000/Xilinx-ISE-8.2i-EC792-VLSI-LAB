vlib work

vcom  -novitalcheck -93 ihdlutil.vhd
vcom  -novitalcheck -93 vrlgutil.vhd
vcom  -novitalcheck -93 brst_cntr.vhd
vcom  -novitalcheck -93 cslt_cntr.vhd
vcom  -novitalcheck -93 ki_cntr.vhd
vcom  -novitalcheck -93 rcd_cntr.vhd
vcom  -novitalcheck -93 ref_cntr.vhd
vcom  -novitalcheck -93 sys_int.vhd
vcom  -novitalcheck -93 sdrmc_state.vhd
vcom  -novitalcheck -93 sdrm_t.vhd
vcom  -novitalcheck -93 sdrm.vhd
     
vcom  -novitalcheck -93 micron/util1164.vhd
vcom  -novitalcheck -93 micron/stdlogar.vhd
vcom  -novitalcheck -93 micron/io_utils.vhd
vcom  -novitalcheck -93 micron/mti_pkg.vhd
vcom  -novitalcheck -93 micron/mt48lc1m16a1-8a.vhd
vcom  -novitalcheck -93 sdrm_functional_tb.vhd

vsim  -t 1ps f_sdrm_CONF

view signals wave structure
do wave_functional.do
run 2500ns
