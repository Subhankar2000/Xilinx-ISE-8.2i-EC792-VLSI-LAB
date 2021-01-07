VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "xc9500xl"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL q(0)
        SIGNAL q(1)
        SIGNAL q(2)
        SIGNAL q(3)
        SIGNAL q(3:0)
        SIGNAL q_int(3:0)
        SIGNAL q_int(0)
        SIGNAL q_int(1)
        SIGNAL q_int(2)
        SIGNAL q_int(3)
        SIGNAL run
        SIGNAL dir
        SIGNAL clk
        SIGNAL stop
        SIGNAL XLXN_15
        SIGNAL XLXN_16
        SIGNAL XLXN_17
        SIGNAL XLXN_18
        SIGNAL XLXN_19
        SIGNAL XLXN_20
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
        SIGNAL left
        SIGNAL right
        PORT Output q(3:0)
        PORT Input clk
        PORT Input stop
        PORT Input left
        PORT Input right
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2003 3 5 16 45 32
            LINE N 64 -128 64 -96 
            LINE N 64 -64 64 -80 
            LINE N 88 -64 40 -64 
            LINE N 68 -32 60 -32 
            LINE N 76 -48 52 -48 
            LINE N 64 -64 64 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF obuf
            TIMESTAMP 2003 3 5 16 45 32
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ibuf
            TIMESTAMP 2003 3 5 16 45 32
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2003 3 5 16 45 32
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF or2b2
            TIMESTAMP 2003 3 5 16 45 32
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
            TIMESTAMP 2003 3 5 16 45 32
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
        BEGIN BLOCKDEF jcounter
            TIMESTAMP 2003 3 13 21 7 28
            BEGIN LINE W 352 80 384 80 
            END LINE
            LINE N 0 112 32 112 
            LINE N 0 80 32 80 
            LINE N 0 48 32 48 
            BEGIN RECTANGLE W 32 0 352 160 
            END RECTANGLE
        END BLOCKDEF
        BEGIN BLOCK I14 gnd
            PIN G XLXN_16
        END BLOCK
        BEGIN BLOCK I15 obuf
            PIN I q_int(0)
            PIN O q(0)
        END BLOCK
        BEGIN BLOCK I16 obuf
            PIN I q_int(3)
            PIN O q(3)
        END BLOCK
        BEGIN BLOCK I17 obuf
            PIN I q_int(2)
            PIN O q(2)
        END BLOCK
        BEGIN BLOCK I18 obuf
            PIN I q_int(1)
            PIN O q(1)
        END BLOCK
        BEGIN BLOCK I6 ibuf
            PIN I clk
            PIN O XLXN_15
        END BLOCK
        BEGIN BLOCK I7 ibuf
            PIN I stop
            PIN O XLXN_23
        END BLOCK
        BEGIN BLOCK I8 ibuf
            PIN I right
            PIN O XLXN_21
        END BLOCK
        BEGIN BLOCK I9 ibuf
            PIN I left
            PIN O XLXN_22
        END BLOCK
        BEGIN BLOCK I10 inv
            PIN I XLXN_22
            PIN O XLXN_17
        END BLOCK
        BEGIN BLOCK I11 inv
            PIN I XLXN_21
            PIN O XLXN_18
        END BLOCK
        BEGIN BLOCK I12 inv
            PIN I XLXN_23
            PIN O XLXN_19
        END BLOCK
        BEGIN BLOCK I13 or2b2
            PIN I0 XLXN_21
            PIN I1 XLXN_22
            PIN O XLXN_20
        END BLOCK
        BEGIN BLOCK run_reg fjkc
            PIN C XLXN_15
            PIN CLR XLXN_16
            PIN J XLXN_18
            PIN K XLXN_17
            PIN Q dir
        END BLOCK
        BEGIN BLOCK dir_reg1 fjkc
            PIN C XLXN_15
            PIN CLR XLXN_16
            PIN J XLXN_20
            PIN K XLXN_19
            PIN Q run
        END BLOCK
        BEGIN BLOCK U1 jcounter
            PIN CE run
            PIN CLK XLXN_15
            PIN LEFT dir
            PIN Q(3:0) q_int(3:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE I14 1472 2048 R0
        INSTANCE I15 2720 800 R0
        INSTANCE I16 2720 992 R0
        INSTANCE I17 2720 928 R0
        INSTANCE I18 2720 864 R0
        INSTANCE I6 896 1872 R0
        INSTANCE I7 896 1136 R0
        INSTANCE I8 896 1008 R0
        INSTANCE I9 896 944 R0
        INSTANCE I10 1216 1536 R0
        INSTANCE I11 1216 1472 R0
        INSTANCE I12 1216 1136 R0
        INSTANCE I13 1216 1040 R0
        INSTANCE run_reg 1584 1760 R0
        INSTANCE dir_reg1 1584 1264 R0
        BEGIN INSTANCE U1 2128 960 R0
        END INSTANCE
        BEGIN BRANCH q(0)
            WIRE 2944 768 2992 768
            WIRE 2992 768 3056 768
            BEGIN DISPLAY 2992 768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3072 768 3056 768
        BEGIN BRANCH q(1)
            WIRE 2944 832 2992 832
            WIRE 2992 832 3056 832
            BEGIN DISPLAY 2992 832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3072 832 3056 832
        BEGIN BRANCH q(2)
            WIRE 2944 896 2992 896
            WIRE 2992 896 3056 896
            BEGIN DISPLAY 2992 896 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3072 896 3056 896
        BEGIN BRANCH q(3)
            WIRE 2944 960 2992 960
            WIRE 2992 960 3056 960
            BEGIN DISPLAY 2992 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 3072 960 3056 960
        BEGIN BRANCH q(3:0)
            WIRE 3072 704 3072 768
            WIRE 3072 768 3072 832
            WIRE 3072 832 3072 896
            WIRE 3072 896 3072 960
            WIRE 3072 960 3072 1040
            WIRE 3072 1040 3152 1040
        END BRANCH
        IOMARKER 3152 1040 q(3:0) R0 28
        BEGIN BRANCH q_int(3:0)
            WIRE 2512 1040 2560 1040
            WIRE 2560 704 2560 768
            WIRE 2560 768 2560 832
            WIRE 2560 832 2560 896
            WIRE 2560 896 2560 960
            WIRE 2560 960 2560 1040
            BEGIN DISPLAY 2560 704 ATTR Name
                ALIGNMENT SOFT-VLEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int(0)
            WIRE 2576 768 2672 768
            WIRE 2672 768 2720 768
            BEGIN DISPLAY 2672 768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2560 768 2576 768
        BEGIN BRANCH q_int(1)
            WIRE 2576 832 2672 832
            WIRE 2672 832 2720 832
            BEGIN DISPLAY 2672 832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2560 832 2576 832
        BEGIN BRANCH q_int(2)
            WIRE 2576 896 2672 896
            WIRE 2672 896 2720 896
            BEGIN DISPLAY 2672 896 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2560 896 2576 896
        BEGIN BRANCH q_int(3)
            WIRE 2576 960 2672 960
            WIRE 2672 960 2720 960
            BEGIN DISPLAY 2672 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2560 960 2576 960
        BEGIN BRANCH run
            WIRE 1968 1008 2016 1008
            WIRE 2016 1008 2128 1008
            BEGIN DISPLAY 2016 1008 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH dir
            WIRE 1968 1504 2016 1504
            WIRE 2016 1040 2016 1120
            WIRE 2016 1120 2016 1504
            WIRE 2016 1040 2128 1040
            BEGIN DISPLAY 2016 1120 ATTR Name
                ALIGNMENT SOFT-TVCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 800 1840 896 1840
        END BRANCH
        IOMARKER 800 1840 clk R180 28
        BEGIN BRANCH stop
            WIRE 800 1104 896 1104
        END BRANCH
        IOMARKER 800 1104 stop R180 28
        BEGIN BRANCH XLXN_15
            WIRE 1120 1840 1488 1840
            WIRE 1488 1840 2080 1840
            WIRE 1488 1136 1488 1632
            WIRE 1488 1632 1488 1840
            WIRE 1488 1632 1584 1632
            WIRE 1488 1136 1584 1136
            WIRE 2080 1072 2080 1840
            WIRE 2080 1072 2128 1072
        END BRANCH
        BEGIN BRANCH XLXN_16
            WIRE 1536 1232 1584 1232
            WIRE 1536 1232 1536 1728
            WIRE 1536 1728 1536 1920
            WIRE 1536 1728 1584 1728
        END BRANCH
        BEGIN BRANCH XLXN_17
            WIRE 1440 1504 1584 1504
        END BRANCH
        BEGIN BRANCH XLXN_18
            WIRE 1440 1440 1584 1440
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 1440 1008 1440 1104
            WIRE 1440 1008 1584 1008
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 1472 944 1584 944
        END BRANCH
        BEGIN BRANCH XLXN_21
            WIRE 1120 976 1200 976
            WIRE 1200 976 1216 976
            WIRE 1200 976 1200 1440
            WIRE 1200 1440 1216 1440
        END BRANCH
        BEGIN BRANCH XLXN_22
            WIRE 1120 912 1168 912
            WIRE 1168 912 1216 912
            WIRE 1168 912 1168 1504
            WIRE 1168 1504 1216 1504
        END BRANCH
        BEGIN BRANCH XLXN_23
            WIRE 1120 1104 1216 1104
        END BRANCH
        BEGIN BRANCH left
            WIRE 800 912 896 912
        END BRANCH
        IOMARKER 800 912 left R180 28
        BEGIN BRANCH right
            WIRE 800 976 896 976
        END BRANCH
        IOMARKER 800 976 right R180 28
    END SHEET
END SCHEMATIC
