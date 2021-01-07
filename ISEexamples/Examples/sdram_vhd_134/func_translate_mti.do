vlib work

vcom -93 micron/util1164.vhd
vcom -93 micron/stdlogar.vhd
vcom -93 micron/io_utils.vhd
vcom -93 micron/mti_pkg.vhd
vcom -93 micron/mt48lc1m16a1-8a.vhd

vcom sdrm_translate.vhd

vcom -93 ihdlutil.vhd
vcom -93 vrlgutil.vhd
vcom sdrm_timing_tb.vhd

vsim  t_sdrm_CONF
view signals wave structure
do wave_timing.do

run 2500ns

