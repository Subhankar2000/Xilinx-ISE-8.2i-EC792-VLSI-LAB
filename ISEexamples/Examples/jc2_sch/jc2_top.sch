VERSION 5
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName XC9500XL
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    End ATTR
    BEGIN NETLIST
        SIGNAL q_int0
        SIGNAL q_int1
        SIGNAL q_int2
        SIGNAL q_int3
        SIGNAL q(0)
        SIGNAL q(1)
        SIGNAL q(2)
        SIGNAL q(3)
        SIGNAL q(3:0)
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL XLXN_12
        SIGNAL run
        SIGNAL dir
        SIGNAL clk
        SIGNAL stop
        SIGNAL XLXN_17
        SIGNAL XLXN_18
        SIGNAL XLXN_19
        SIGNAL XLXN_20
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
        SIGNAL XLXN_24
        SIGNAL XLXN_25
        SIGNAL left
        SIGNAL right
        PORT Output q(3:0)
        PORT Input clk
        PORT Input stop
        PORT Input left
        PORT Input right
        BEGIN BLOCKDEF sr4cled
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 0 -384 64 -384 
            LINE N 0 -256 64 -256 
            LINE N 0 -192 64 -192 
            LINE N 64 -112 80 -128 
            LINE N 80 -128 64 -144 
            LINE N 0 -128 64 -128 
            LINE N 192 -64 192 -32 
            LINE N 192 -32 64 -32 
            LINE N 0 -32 64 -32 
            LINE N 0 -704 64 -704 
            LINE N 0 -640 64 -640 
            LINE N 0 -576 64 -576 
            LINE N 0 -512 64 -512 
            LINE N 0 -448 64 -448 
            LINE N 384 -640 320 -640 
            LINE N 384 -576 320 -576 
            LINE N 384 -512 320 -512 
            LINE N 384 -448 320 -448 
            LINE N 0 -320 64 -320 
            RECTANGLE N 64 -768 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 64 -128 64 -96 
            LINE N 64 -64 64 -80 
            LINE N 88 -64 40 -64 
            LINE N 68 -32 60 -32 
            LINE N 76 -48 52 -48 
            LINE N 64 -64 64 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF obuf
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ibuf
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF or2b2
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 0 -64 32 -64 
            CIRCLE N 32 -76 56 -52 
            LINE N 0 -128 32 -128 
            CIRCLE N 32 -140 56 -116 
            LINE N 256 -96 192 -96 
            ARC N -40 -152 72 -40 48 -48 48 -144 
            LINE N 112 -48 48 -48 
            ARC N 28 -144 204 32 192 -96 112 -144 
            LINE N 112 -144 48 -144 
            ARC N 28 -224 204 -48 112 -48 192 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF fjkc
            TIMESTAMP 2001 5 22 18 47 27
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 0 -320 64 -320 
            LINE N 384 -256 320 -256 
            LINE N 0 -256 64 -256 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            RECTANGLE N 64 -384 320 -64 
        END BLOCKDEF
        BEGIN BLOCK jcounter sr4cled
            PIN C XLXN_17
            PIN CE run
            PIN CLR XLXN_12
            PIN D0 XLXN_12
            PIN D1 XLXN_12
            PIN D2 XLXN_12
            PIN D3 XLXN_12
            PIN L XLXN_12
            PIN LEFT dir
            PIN SLI XLXN_11
            PIN SRI XLXN_10
            PIN Q0 q_int0
            PIN Q1 q_int1
            PIN Q2 q_int2
            PIN Q3 q_int3
        END BLOCK
        BEGIN BLOCK I19 gnd
            PIN G XLXN_12
        END BLOCK
        BEGIN BLOCK I14 gnd
            PIN G XLXN_18
        END BLOCK
        BEGIN BLOCK I15 obuf
            PIN I q_int0
            PIN O q(0)
        END BLOCK
        BEGIN BLOCK I16 obuf
            PIN I q_int3
            PIN O q(3)
        END BLOCK
        BEGIN BLOCK I17 obuf
            PIN I q_int2
            PIN O q(2)
        END BLOCK
        BEGIN BLOCK I18 obuf
            PIN I q_int1
            PIN O q(1)
        END BLOCK
        BEGIN BLOCK I6 ibuf
            PIN I clk
            PIN O XLXN_17
        END BLOCK
        BEGIN BLOCK I7 ibuf
            PIN I stop
            PIN O XLXN_25
        END BLOCK
        BEGIN BLOCK I8 ibuf
            PIN I right
            PIN O XLXN_23
        END BLOCK
        BEGIN BLOCK I9 ibuf
            PIN I left
            PIN O XLXN_24
        END BLOCK
        BEGIN BLOCK I20 inv
            PIN I q_int0
            PIN O XLXN_10
        END BLOCK
        BEGIN BLOCK I21 inv
            PIN I q_int3
            PIN O XLXN_11
        END BLOCK
        BEGIN BLOCK I10 inv
            PIN I XLXN_24
            PIN O XLXN_19
        END BLOCK
        BEGIN BLOCK I11 inv
            PIN I XLXN_23
            PIN O XLXN_20
        END BLOCK
        BEGIN BLOCK I12 inv
            PIN I XLXN_25
            PIN O XLXN_21
        END BLOCK
        BEGIN BLOCK I13 or2b2
            PIN I0 XLXN_23
            PIN I1 XLXN_24
            PIN O XLXN_22
        END BLOCK
        BEGIN BLOCK run_reg fjkc
            PIN C XLXN_17
            PIN CLR XLXN_18
            PIN J XLXN_20
            PIN K XLXN_19
            PIN Q dir
        END BLOCK
        BEGIN BLOCK dir_reg1 fjkc
            PIN C XLXN_17
            PIN CLR XLXN_18
            PIN J XLXN_22
            PIN K XLXN_21
            PIN Q run
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE jcounter 2208 1200 R0
        INSTANCE I19 2112 1456 R0
        INSTANCE I14 1472 2048 R0
        INSTANCE I15 2800 592 R0
        INSTANCE I16 2800 784 R0
        INSTANCE I17 2800 720 R0
        INSTANCE I18 2800 656 R0
        INSTANCE I6 896 1872 R0
        INSTANCE I7 896 1136 R0
        INSTANCE I8 896 1008 R0
        INSTANCE I9 896 944 R0
        INSTANCE I20 1920 848 R0
        INSTANCE I21 1920 528 R0
        INSTANCE I10 1216 1536 R0
        INSTANCE I11 1216 1472 R0
        INSTANCE I12 1216 1136 R0
        INSTANCE I13 1216 1040 R0
        INSTANCE run_reg 1584 1760 R0
        INSTANCE dir_reg1 1584 1264 R0
        BEGIN BRANCH q_int0
            WIRE 1904 352 2624 352
            WIRE 2624 352 2624 560
            WIRE 2624 560 2736 560
            WIRE 2736 560 2752 560
            WIRE 2752 560 2800 560
            WIRE 1904 352 1904 816
            WIRE 1904 816 1920 816
            WIRE 2592 560 2624 560
            BEGIN DISPLAY 2736 560 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int1
            WIRE 2592 624 2736 624
            WIRE 2736 624 2752 624
            WIRE 2752 624 2800 624
            BEGIN DISPLAY 2736 624 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int2
            WIRE 2592 688 2736 688
            WIRE 2736 688 2752 688
            WIRE 2752 688 2800 688
            BEGIN DISPLAY 2736 688 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int3
            WIRE 1872 320 2656 320
            WIRE 2656 320 2656 752
            WIRE 2656 752 2736 752
            WIRE 2736 752 2752 752
            WIRE 2752 752 2800 752
            WIRE 1872 320 1872 496
            WIRE 1872 496 1920 496
            WIRE 2592 752 2656 752
            BEGIN DISPLAY 2736 752 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q(0)
            WIRE 3024 560 3072 560
            WIRE 3072 560 3136 560
            BEGIN DISPLAY 3072 560 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3152 560 3136 560
        BEGIN BRANCH q(1)
            WIRE 3024 624 3072 624
            WIRE 3072 624 3136 624
            BEGIN DISPLAY 3072 624 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3152 624 3136 624
        BEGIN BRANCH q(2)
            WIRE 3024 688 3072 688
            WIRE 3072 688 3136 688
            BEGIN DISPLAY 3072 688 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3152 688 3136 688
        BEGIN BRANCH q(3)
            WIRE 3024 752 3072 752
            WIRE 3072 752 3136 752
            BEGIN DISPLAY 3072 752 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3152 752 3136 752
        BEGIN BRANCH q(3:0)
            WIRE 3152 512 3152 560
            WIRE 3152 560 3152 624
            WIRE 3152 624 3152 688
            WIRE 3152 688 3152 752
            WIRE 3152 752 3152 832
            WIRE 3152 832 3232 832
        END BRANCH
        IOMARKER 3232 832 q(3:0)
        BEGIN BRANCH XLXN_10
            WIRE 2144 816 2208 816
        END BRANCH
        BEGIN BRANCH XLXN_11
            WIRE 2144 496 2208 496
        END BRANCH
        BEGIN BRANCH XLXN_12
            WIRE 2176 560 2176 624
            WIRE 2176 624 2176 688
            WIRE 2176 688 2176 752
            WIRE 2176 752 2176 880
            WIRE 2176 880 2176 1168
            WIRE 2176 1168 2176 1328
            WIRE 2176 1168 2208 1168
            WIRE 2176 880 2208 880
            WIRE 2176 752 2208 752
            WIRE 2176 688 2208 688
            WIRE 2176 624 2208 624
            WIRE 2176 560 2208 560
        END BRANCH
        BEGIN BRANCH run
            WIRE 1968 1008 2080 1008
            WIRE 2080 1008 2208 1008
            BEGIN DISPLAY 2080 1008 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH dir
            WIRE 1968 1504 2016 1504
            WIRE 2016 944 2016 1120
            WIRE 2016 1120 2016 1504
            WIRE 2016 944 2208 944
            BEGIN DISPLAY 2016 1120 ATTR Name
                ALIGNMENT TVCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 800 1840 896 1840
        END BRANCH
        IOMARKER 800 1840 clk
        BEGIN BRANCH stop
            WIRE 800 1104 896 1104
        END BRANCH
        IOMARKER 800 1104 stop
        BEGIN BRANCH XLXN_17
            WIRE 1120 1840 1488 1840
            WIRE 1488 1840 2080 1840
            WIRE 1488 1136 1488 1632
            WIRE 1488 1632 1488 1840
            WIRE 1488 1632 1584 1632
            WIRE 1488 1136 1584 1136
            WIRE 2080 1072 2080 1840
            WIRE 2080 1072 2208 1072
        END BRANCH
        BEGIN BRANCH XLXN_18
            WIRE 1536 1232 1584 1232
            WIRE 1536 1232 1536 1728
            WIRE 1536 1728 1536 1920
            WIRE 1536 1728 1584 1728
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 1440 1504 1584 1504
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 1440 1440 1584 1440
        END BRANCH
        BEGIN BRANCH XLXN_21
            WIRE 1440 1008 1440 1104
            WIRE 1440 1008 1584 1008
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 1472 944 1584 944
        END BRANCH
        BEGIN BRANCH XLXN_23
            WIRE 1120 976 1200 976
            WIRE 1200 976 1216 976
            WIRE 1200 976 1200 1440
            WIRE 1200 1440 1216 1440
        END BRANCH
        BEGIN BRANCH XLXN_24
            WIRE 1120 912 1168 912
            WIRE 1168 912 1216 912
            WIRE 1168 912 1168 1504
            WIRE 1168 1504 1216 1504
        END BRANCH
        BEGIN BRANCH XLXN_25
            WIRE 1120 1104 1216 1104
        END BRANCH
        BEGIN BRANCH left
            WIRE 800 912 896 912
        END BRANCH
        IOMARKER 800 912 left
        BEGIN BRANCH right
            WIRE 800 976 896 976
        END BRANCH
        IOMARKER 800 976 right
    END SHEET
END SCHEMATIC
