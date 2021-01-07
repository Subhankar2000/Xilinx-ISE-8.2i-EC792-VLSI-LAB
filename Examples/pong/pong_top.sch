VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        BEGIN SIGNAL seg_a
            BEGIN ATTR LOC "e14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_b
            BEGIN ATTR LOC "g13"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_c
            BEGIN ATTR LOC "n15"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_d
            BEGIN ATTR LOC "p15"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_e
            BEGIN ATTR LOC "r16"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_f
            BEGIN ATTR LOC "f13"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_g
            BEGIN ATTR LOC "n16"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL seg_dp
            BEGIN ATTR LOC "p16"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL an(0)
            BEGIN ATTR LOC "d14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL an(1)
            BEGIN ATTR LOC "g14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL an(2)
            BEGIN ATTR LOC "f14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL an(3)
            BEGIN ATTR LOC "e13"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL vga_red
            BEGIN ATTR LOC "r12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL vga_green
            BEGIN ATTR LOC "t12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL vga_blue
            BEGIN ATTR LOC "r11"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL vga_hs
            BEGIN ATTR LOC "r9"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL vga_vs
            BEGIN ATTR LOC "t10"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ps2c
            BEGIN ATTR LOC "m16"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL clk_ic4
            BEGIN ATTR LOC "t9"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ps2d
            BEGIN ATTR LOC "m15"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        SIGNAL an(3:0)
        SIGNAL ld(7:0)
        BEGIN SIGNAL btn3
            BEGIN ATTR LOC "l14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(0)
            BEGIN ATTR LOC "k12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(1)
            BEGIN ATTR LOC "p14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(2)
            BEGIN ATTR LOC "l12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(4)
            BEGIN ATTR LOC "p13"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(5)
            BEGIN ATTR LOC "n12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(6)
            BEGIN ATTR LOC "p12"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(7)
            BEGIN ATTR LOC "p11"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL ld(3)
            BEGIN ATTR LOC "n14"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        SIGNAL XLXN_31(1:0)
        SIGNAL hsync
        SIGNAL vsync
        SIGNAL lf_dir(1:0)
        SIGNAL rt_dir(1:0)
        SIGNAL serve
        SIGNAL seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g,seg_dp
        PORT Output seg_a
        PORT Output seg_b
        PORT Output seg_c
        PORT Output seg_d
        PORT Output seg_e
        PORT Output seg_f
        PORT Output seg_g
        PORT Output seg_dp
        PORT Output an(0)
        PORT Output an(1)
        PORT Output an(2)
        PORT Output an(3)
        PORT Output vga_red
        PORT Output vga_green
        PORT Output vga_blue
        PORT Output vga_hs
        PORT Output vga_vs
        PORT Input ps2c
        PORT Input clk_ic4
        PORT Input ps2d
        PORT Input btn3
        PORT Output ld(0)
        PORT Output ld(1)
        PORT Output ld(2)
        PORT Output ld(4)
        PORT Output ld(5)
        PORT Output ld(6)
        PORT Output ld(7)
        PORT Output ld(3)
        BEGIN BLOCKDEF vga_int
            TIMESTAMP 2004 9 13 18 46 48
            RECTANGLE N 64 -320 352 0 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -60 64 -36 
            LINE N 64 -48 0 -48 
            LINE N 352 -288 416 -288 
            LINE N 352 -224 416 -224 
            LINE N 352 -160 416 -160 
            LINE N 352 -96 416 -96 
            LINE N 352 -32 416 -32 
            LINE N 64 -208 0 -208 
            LINE N 64 -128 0 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF cntrl
            TIMESTAMP 2004 10 27 16 54 38
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 320 -208 384 -208 
            LINE N 320 -128 384 -128 
            RECTANGLE N 320 -60 384 -36 
            LINE N 320 -48 384 -48 
            RECTANGLE N 64 -320 320 0 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF read_ps2
            TIMESTAMP 2004 10 26 14 41 2
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -108 384 -84 
            RECTANGLE N 320 -172 384 -148 
            RECTANGLE N 64 -256 320 12 
            LINE N 320 -224 384 -224 
            RECTANGLE N 320 -44 384 -20 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF game_title
            TIMESTAMP 2004 9 27 16 48 42
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -108 384 -84 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCK read_ps2_inst read_ps2
            PIN Clk clk_ic4
            PIN PS2_Clk ps2c
            PIN PS2_Data ps2d
            PIN Reset btn3
            PIN left_dir(1:0) lf_dir(1:0)
            PIN right_dir(1:0) rt_dir(1:0)
            PIN serve serve
            PIN ps2_code(7:0) ld(7:0)
        END BLOCK
        BEGIN BLOCK cntrl_inst cntrl
            PIN CLK clk_ic4
            PIN RESET btn3
            PIN SERVE serve
            PIN HSYNCH hsync
            PIN VSYNCH vsync
            PIN COLOR(1:0) XLXN_31(1:0)
            PIN left_dir(1:0) lf_dir(1:0)
            PIN right_dir(1:0) rt_dir(1:0)
        END BLOCK
        BEGIN BLOCK vga_inst vga_int
            PIN CLK clk_ic4
            PIN COLOR(1:0) XLXN_31(1:0)
            PIN RED vga_red
            PIN BLUE vga_blue
            PIN GREEN vga_green
            PIN VSYNCH_OUT vga_vs
            PIN HSYNCH_OUT vga_hs
            PIN HSYNCH_IN hsync
            PIN VSYNCH_IN vsync
        END BLOCK
        BEGIN BLOCK title_inst game_title
            PIN clk clk_ic4
            PIN seven_seg(7:0) seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g,seg_dp
            PIN an(3:0) an(3:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH seg_a
            WIRE 3024 208 3104 208
            WIRE 3104 208 3184 208
            BEGIN DISPLAY 3104 208 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_b
            WIRE 3024 272 3104 272
            WIRE 3104 272 3184 272
            BEGIN DISPLAY 3104 272 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_c
            WIRE 3024 336 3104 336
            WIRE 3104 336 3184 336
            BEGIN DISPLAY 3104 336 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_d
            WIRE 3024 400 3104 400
            WIRE 3104 400 3184 400
            BEGIN DISPLAY 3104 400 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_e
            WIRE 3024 464 3104 464
            WIRE 3104 464 3184 464
            BEGIN DISPLAY 3104 464 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_f
            WIRE 3024 528 3104 528
            WIRE 3104 528 3184 528
            BEGIN DISPLAY 3104 528 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_g
            WIRE 3024 592 3104 592
            WIRE 3104 592 3184 592
            BEGIN DISPLAY 3104 592 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_dp
            WIRE 3024 656 3104 656
            WIRE 3104 656 3184 656
            BEGIN DISPLAY 3104 656 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        IOMARKER 3184 208 seg_a R0 28
        IOMARKER 3184 272 seg_b R0 28
        IOMARKER 3184 336 seg_c R0 28
        IOMARKER 3184 400 seg_d R0 28
        IOMARKER 3184 464 seg_e R0 28
        IOMARKER 3184 528 seg_f R0 28
        IOMARKER 3184 592 seg_g R0 28
        IOMARKER 3184 656 seg_dp R0 28
        LINE N 2428 420 2428 684 
        LINE N 2660 420 2660 680 
        LINE N 2196 420 2196 680 
        BEGIN RECTANGLE N 2328 464 2360 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2232 464 2264 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2232 560 2264 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2328 560 2360 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2264 636 2328 664 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2264 540 2328 572 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2264 436 2328 464 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN DISPLAY 2284 448 TEXT a
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2336 508 TEXT b
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2340 600 TEXT c
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2288 652 TEXT d
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2236 600 TEXT e
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2244 500 TEXT f
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2288 552 TEXT g
            FONT 40 "Arial"
        END DISPLAY
        BEGIN CIRCLE N 2364 624 2416 676 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN DISPLAY 2372 644 TEXT dp
            FONT 40 "Arial"
        END DISPLAY
        BEGIN RECTANGLE N 2552 464 2584 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2456 464 2488 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2456 560 2488 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2552 560 2584 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2488 636 2552 664 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2488 540 2552 572 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2488 436 2552 464 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN DISPLAY 2508 448 TEXT a
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2560 508 TEXT b
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2564 600 TEXT c
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2512 652 TEXT d
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2460 600 TEXT e
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2468 500 TEXT f
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2512 552 TEXT g
            FONT 40 "Arial"
        END DISPLAY
        BEGIN CIRCLE N 2588 624 2640 676 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN DISPLAY 2596 644 TEXT dp
            FONT 40 "Arial"
        END DISPLAY
        BEGIN RECTANGLE N 2792 464 2824 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2696 464 2728 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2696 560 2728 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2792 560 2824 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2728 636 2792 664 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2728 540 2792 572 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2728 436 2792 464 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN DISPLAY 2748 448 TEXT a
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2800 508 TEXT b
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2804 600 TEXT c
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2752 652 TEXT d
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2700 600 TEXT e
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2708 500 TEXT f
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2752 552 TEXT g
            FONT 40 "Arial"
        END DISPLAY
        BEGIN CIRCLE N 2828 624 2880 676 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN DISPLAY 2836 644 TEXT dp
            FONT 40 "Arial"
        END DISPLAY
        RECTANGLE N 1968 420 2892 680 
        BEGIN RECTANGLE N 2088 464 2120 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 1992 464 2024 544 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 1992 560 2024 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2088 560 2120 640 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2024 636 2088 664 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2024 540 2088 572 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN RECTANGLE N 2024 436 2088 464 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN DISPLAY 2044 448 TEXT a
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2096 508 TEXT b
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2100 600 TEXT c
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2048 652 TEXT d
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 1996 600 TEXT e
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2004 500 TEXT f
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2048 552 TEXT g
            FONT 40 "Arial"
        END DISPLAY
        BEGIN CIRCLE N 2124 624 2176 676 
            FILLCOLOR 255 255 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN DISPLAY 2132 644 TEXT dp
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2040 396 TEXT AN3
            FONT 48 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2276 396 TEXT AN2
            FONT 48 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2496 396 TEXT AN1
            FONT 48 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2724 400 TEXT AN0
            FONT 48 "Arial"
        END DISPLAY
        BEGIN BRANCH an(0)
            WIRE 1632 464 1712 464
            WIRE 1712 464 1792 464
            BEGIN DISPLAY 1712 464 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH an(1)
            WIRE 1632 528 1712 528
            WIRE 1712 528 1792 528
            BEGIN DISPLAY 1712 528 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH an(2)
            WIRE 1632 592 1712 592
            WIRE 1712 592 1792 592
            BEGIN DISPLAY 1712 592 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH an(3)
            WIRE 1632 656 1712 656
            WIRE 1712 656 1792 656
            BEGIN DISPLAY 1712 656 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        IOMARKER 1792 464 an(0) R0 28
        IOMARKER 1792 528 an(1) R0 28
        IOMARKER 1792 592 an(2) R0 28
        IOMARKER 1792 656 an(3) R0 28
        BEGIN RECTANGLE N 1544 120 3376 800 
            LINESTYLE Dash
        END RECTANGLE
        BEGIN DISPLAY 1688 260 TEXT "Four-Digit, Seven-Segment LED Display"
            FONT 64 "Arial"
        END DISPLAY
        BEGIN BRANCH an(3:0)
            WIRE 1632 736 1728 736
            WIRE 1728 736 1840 736
            BEGIN DISPLAY 1728 736 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_red
            WIRE 3008 2096 3088 2096
            WIRE 3088 2096 3168 2096
            BEGIN DISPLAY 3088 2096 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_green
            WIRE 3008 2160 3088 2160
            WIRE 3088 2160 3168 2160
            BEGIN DISPLAY 3088 2160 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_blue
            WIRE 3008 2224 3088 2224
            WIRE 3088 2224 3168 2224
            BEGIN DISPLAY 3088 2224 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_hs
            WIRE 3008 2288 3088 2288
            WIRE 3088 2288 3168 2288
            BEGIN DISPLAY 3088 2288 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_vs
            WIRE 3008 2352 3088 2352
            WIRE 3088 2352 3168 2352
            BEGIN DISPLAY 3088 2352 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 2900 2092 TEXT pin1
            FONT 32 "Arial"
            TEXTCOLOR 255 0 0
        END DISPLAY
        BEGIN DISPLAY 2900 2156 TEXT pin2
            FONT 32 "Arial"
            TEXTCOLOR 0 255 0
        END DISPLAY
        BEGIN DISPLAY 2900 2216 TEXT pin3
            FONT 32 "Arial"
            TEXTCOLOR 0 0 255
        END DISPLAY
        BEGIN DISPLAY 2900 2284 TEXT pin13
            FONT 32 "Arial"
            TEXTCOLOR 128 0 128
        END DISPLAY
        BEGIN DISPLAY 2900 2352 TEXT pin14
            FONT 32 "Arial"
            TEXTCOLOR 255 0 255
        END DISPLAY
        BEGIN DISPLAY 2904 2484 TEXT "pins 6,7,8,10,11 => GND"
            FONT 32 "Arial"
            TEXTCOLOR 0 128 0
        END DISPLAY
        BEGIN DISPLAY 2904 2524 TEXT "pins 4,5,9,12,15 => OPEN"
            FONT 32 "Arial"
            TEXTCOLOR 160 160 164
        END DISPLAY
        LINE N 2304 2272 2668 2272 
        LINE N 2628 2436 2344 2436 
        LINE N 2684 2312 2656 2416 
        LINE N 2276 2312 2308 2420 
        ARC N 2276 2272 2328 2324 2304 2272 2276 2308 
        ARC N 2612 2392 2660 2436 2628 2436 2660 2412 
        ARC N 2636 2272 2688 2320 2684 2312 2664 2272 
        ARC N 2304 2372 2372 2436 2308 2416 2352 2436 
        BEGIN CIRCLE N 2596 2384 2624 2412 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2532 2384 2560 2412 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2468 2384 2496 2412 
            FILLCOLOR 128 0 128
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2404 2384 2432 2412 
            FILLCOLOR 255 0 255
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2340 2384 2368 2412 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2628 2336 2656 2364 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2564 2336 2592 2364 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2500 2336 2528 2364 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2436 2336 2464 2364 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2372 2336 2400 2364 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2596 2288 2624 2316 
            FILLCOLOR 255 0 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2532 2288 2560 2316 
            FILLCOLOR 0 255 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2468 2288 2496 2316 
            FILLCOLOR 0 0 255
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2404 2288 2432 2316 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 2340 2288 2368 2316 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN DISPLAY 2648 2236 TEXT pin1
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2684 2396 TEXT pin6
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2624 2484 TEXT pin11
            FONT 40 "Arial"
        END DISPLAY
        LINE N 2628 2416 2644 2460 
        LINE N 2660 2356 2708 2380 
        LINE N 2636 2300 2680 2260 
        BEGIN DISPLAY 2248 2228 TEXT pin5
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2160 2332 TEXT pin10
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 2200 2448 TEXT pin15
            FONT 40 "Arial"
        END DISPLAY
        LINE N 2272 2244 2336 2292 
        LINE N 2204 2348 2360 2348 
        LINE N 2236 2428 2328 2400 
        BEGIN DISPLAY 2360 2168 TEXT "VGA Port"
            FONT 64 "Arial"
        END DISPLAY
        BEGIN RECTANGLE N 2088 1964 3380 2644 
            LINESTYLE Dash
        END RECTANGLE
        IOMARKER 3168 2096 vga_red R0 28
        IOMARKER 3168 2160 vga_green R0 28
        IOMARKER 3168 2224 vga_blue R0 28
        IOMARKER 3168 2288 vga_hs R0 28
        IOMARKER 3168 2352 vga_vs R0 28
        BEGIN BRANCH ld(0)
            WIRE 3088 1200 3168 1200
            WIRE 3168 1200 3248 1200
            BEGIN DISPLAY 3168 1200 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(1)
            WIRE 3088 1264 3168 1264
            WIRE 3168 1264 3248 1264
            BEGIN DISPLAY 3168 1264 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(2)
            WIRE 3088 1328 3168 1328
            WIRE 3168 1328 3248 1328
            BEGIN DISPLAY 3168 1328 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(4)
            WIRE 3088 1456 3168 1456
            WIRE 3168 1456 3248 1456
            BEGIN DISPLAY 3168 1456 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(5)
            WIRE 3088 1520 3168 1520
            WIRE 3168 1520 3248 1520
            BEGIN DISPLAY 3168 1520 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(6)
            WIRE 3088 1584 3168 1584
            WIRE 3168 1584 3248 1584
            BEGIN DISPLAY 3168 1584 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(7)
            WIRE 3088 1648 3168 1648
            WIRE 3168 1648 3248 1648
            BEGIN DISPLAY 3168 1648 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 2852 1400 TEXT LEDs
            FONT 64 "Arial"
        END DISPLAY
        BEGIN RECTANGLE N 2792 1112 3376 1720 
            LINESTYLE Dash
        END RECTANGLE
        BEGIN BRANCH ld(3)
            WIRE 3088 1392 3168 1392
            WIRE 3168 1392 3248 1392
            BEGIN DISPLAY 3168 1392 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ld(7:0)
            WIRE 2832 1568 2928 1568
            WIRE 2928 1568 3024 1568
            BEGIN DISPLAY 2928 1568 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 3248 1200 ld(0) R0 28
        IOMARKER 3248 1264 ld(1) R0 28
        IOMARKER 3248 1328 ld(2) R0 28
        IOMARKER 3248 1392 ld(3) R0 28
        IOMARKER 3248 1456 ld(4) R0 28
        IOMARKER 3248 1520 ld(5) R0 28
        IOMARKER 3248 1584 ld(6) R0 28
        IOMARKER 3248 1648 ld(7) R0 28
        CIRCLE N 204 2324 476 2596 
        BEGIN RECTANGLE N 312 2376 364 2468 
            FILLCOLOR 192 192 192
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN CIRCLE N 388 2384 416 2412 
            FILLCOLOR 0 0 255
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 260 2384 288 2412 
            FILLCOLOR 128 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 292 2528 320 2556 
            FILLCOLOR 128 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 372 2528 400 2556 
            FILLCOLOR 160 160 164
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 420 2464 448 2492 
            FILLCOLOR 0 128 0
            FILLSTYLE Solid
        END CIRCLE
        BEGIN CIRCLE N 244 2464 272 2492 
            FILLCOLOR 255 0 0
            FILLSTYLE Solid
        END CIRCLE
        LINE N 252 2564 252 2532 
        LINE N 252 2532 224 2532 
        LINE N 432 2556 432 2528 
        LINE N 432 2528 452 2528 
        BEGIN DISPLAY 408 2528 TEXT 5
            FONT 36 "Arial"
        END DISPLAY
        BEGIN DISPLAY 416 2388 TEXT 1
            FONT 36 "Arial"
        END DISPLAY
        BEGIN DISPLAY 244 2392 TEXT 2
            FONT 36 "Arial"
        END DISPLAY
        BEGIN DISPLAY 448 2456 TEXT 3
            FONT 36 "Arial"
        END DISPLAY
        BEGIN DISPLAY 224 2468 TEXT 4
            FONT 36 "Arial"
        END DISPLAY
        BEGIN DISPLAY 276 2532 TEXT 6
            FONT 36 "Arial"
        END DISPLAY
        BEGIN RECTANGLE N 312 2328 364 2348 
            FILLCOLOR 192 192 192
            FILLSTYLE Solid
        END RECTANGLE
        BEGIN BRANCH ps2c
            WIRE 1104 2528 1184 2528
            WIRE 1184 2528 1264 2528
            BEGIN DISPLAY 1184 2528 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 572 2444 TEXT "Pin3  -  GND"
            FONT 40 "Arial"
            TEXTCOLOR 0 128 0
        END DISPLAY
        BEGIN DISPLAY 572 2480 TEXT "Pin4  -  Voltage Supply"
            FONT 40 "Arial"
        END DISPLAY
        BEGIN DISPLAY 572 2556 TEXT "Pin6  -  Reserved"
            FONT 40 "Arial"
            TEXTCOLOR 128 128 0
        END DISPLAY
        BEGIN DISPLAY 572 2408 TEXT "Pin2  -  Reserved"
            FONT 40 "Arial"
            TEXTCOLOR 128 128 0
        END DISPLAY
        BEGIN DISPLAY 572 2368 TEXT "Pin1  -  Data (PS2D)"
            FONT 40 "Arial"
            TEXTCOLOR 0 0 255
        END DISPLAY
        BEGIN DISPLAY 572 2520 TEXT "Pin5  -  CLK (PS2C)"
            FONT 40 "Arial"
            TEXTCOLOR 255 0 255
        END DISPLAY
        BEGIN RECTANGLE N 108 2264 1400 2644 
            LINESTYLE Dash
        END RECTANGLE
        BEGIN BRANCH ps2d
            WIRE 1104 2416 1184 2416
            WIRE 1184 2416 1264 2416
            BEGIN DISPLAY 1184 2416 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 128 2296 TEXT "PS2 Port"
            FONT 56 "Arial"
        END DISPLAY
        IOMARKER 1104 2528 ps2c R180 28
        IOMARKER 1104 2416 ps2d R180 28
        BEGIN RECTANGLE N 100 376 696 600 
            LINESTYLE Dash
        END RECTANGLE
        BEGIN BRANCH clk_ic4
            WIRE 256 240 336 240
            WIRE 336 240 400 240
            BEGIN DISPLAY 336 240 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        BEGIN RECTANGLE N 100 104 468 336 
            LINESTYLE Dash
        END RECTANGLE
        BEGIN DISPLAY 188 156 TEXT Clock
            FONT 64 "Arial"
        END DISPLAY
        IOMARKER 256 240 clk_ic4 R180 28
        BEGIN DISPLAY 124 432 TEXT "Push Button Reset"
            FONT 64 "Arial"
        END DISPLAY
        BEGIN BRANCH btn3
            WIRE 256 528 336 528
            WIRE 336 528 416 528
            BEGIN DISPLAY 336 528 ATTR LOC
                ALIGNMENT SOFT-BCENTER
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END BRANCH
        IOMARKER 256 528 btn3 R180 28
        BEGIN BRANCH XLXN_31(1:0)
            WIRE 1552 1632 1680 1632
        END BRANCH
        BEGIN BRANCH hsync
            WIRE 1552 1472 1616 1472
            WIRE 1616 1472 1680 1472
            BEGIN DISPLAY 1616 1472 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vsync
            WIRE 1552 1552 1616 1552
            WIRE 1616 1552 1680 1552
            BEGIN DISPLAY 1616 1552 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_ic4
            WIRE 1616 1392 1664 1392
            WIRE 1664 1392 1680 1392
            BEGIN DISPLAY 1664 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_ic4
            WIRE 1024 1392 1088 1392
            WIRE 1088 1392 1168 1392
            BEGIN DISPLAY 1088 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH btn3
            WIRE 1024 1456 1072 1456
            WIRE 1072 1456 1168 1456
            BEGIN DISPLAY 1072 1456 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH lf_dir(1:0)
            WIRE 976 1584 1056 1584
            WIRE 1056 1584 1168 1584
            BEGIN DISPLAY 1056 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rt_dir(1:0)
            WIRE 976 1648 1056 1648
            WIRE 1056 1648 1168 1648
            BEGIN DISPLAY 1056 1648 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_ic4
            WIRE 464 1520 528 1520
            WIRE 528 1520 592 1520
            BEGIN DISPLAY 528 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH btn3
            WIRE 464 1584 528 1584
            WIRE 528 1584 592 1584
            BEGIN DISPLAY 528 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ps2d
            WIRE 464 1648 528 1648
            WIRE 528 1648 592 1648
            BEGIN DISPLAY 528 1648 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ps2c
            WIRE 464 1712 528 1712
            WIRE 528 1712 592 1712
            BEGIN DISPLAY 528 1712 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH serve
            WIRE 976 1520 1056 1520
            WIRE 1056 1520 1168 1520
            BEGIN DISPLAY 1056 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE read_ps2_inst 592 1744 R0
        END INSTANCE
        BEGIN BRANCH ld(7:0)
            WIRE 976 1712 1072 1712
            WIRE 1072 1712 1184 1712
            BEGIN DISPLAY 1072 1712 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE cntrl_inst 1168 1680 R0
        END INSTANCE
        BEGIN INSTANCE vga_inst 1680 1680 R0
        END INSTANCE
        BEGIN BRANCH vga_hs
            WIRE 2096 1648 2192 1648
            WIRE 2192 1648 2272 1648
            BEGIN DISPLAY 2192 1648 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_vs
            WIRE 2096 1584 2192 1584
            WIRE 2192 1584 2192 1584
            WIRE 2192 1584 2272 1584
            BEGIN DISPLAY 2196 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_green
            WIRE 2096 1520 2176 1520
            WIRE 2176 1520 2272 1520
            BEGIN DISPLAY 2176 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_blue
            WIRE 2096 1456 2176 1456
            WIRE 2176 1456 2176 1456
            WIRE 2176 1456 2272 1456
            BEGIN DISPLAY 2180 1456 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH vga_red
            WIRE 2096 1392 2192 1392
            WIRE 2192 1392 2192 1392
            WIRE 2192 1392 2272 1392
            BEGIN DISPLAY 2188 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_ic4
            WIRE 832 1056 896 1056
            WIRE 896 1056 960 1056
            BEGIN DISPLAY 896 1056 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH an(3:0)
            WIRE 1344 1120 1520 1120
            WIRE 1520 1120 1616 1120
            BEGIN DISPLAY 1520 1120 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH seg_a,seg_b,seg_c,seg_d,seg_e,seg_f,seg_g,seg_dp
            WIRE 1344 1056 1616 1056
            WIRE 1616 1056 1888 1056
            BEGIN DISPLAY 1616 1056 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE title_inst 960 1152 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
