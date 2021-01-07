VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "xc9500xl"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL q_int3
        SIGNAL q_int2
        SIGNAL q_int1
        SIGNAL q_int0
        SIGNAL q(0)
        SIGNAL q(1)
        SIGNAL q(3:0)
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
        SIGNAL left
        SIGNAL right
        SIGNAL XLXN_14
        SIGNAL q(2)
        SIGNAL q(3)
        PORT Output q(3:0)
        PORT Input clk
        PORT Input stop
        PORT Input left
        PORT Input right
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2001 5 22 18 42 44
            LINE N 64 -64 64 -96 
            LINE N 76 -48 52 -48 
            LINE N 68 -32 60 -32 
            LINE N 88 -64 40 -64 
            LINE N 64 -64 64 -80 
            LINE N 64 -128 64 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF obuf
            TIMESTAMP 2001 5 22 18 42 44
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ibuf
            TIMESTAMP 2001 5 22 18 42 44
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 5 22 18 42 44
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF or2b2
            TIMESTAMP 2001 5 22 18 42 44
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
            TIMESTAMP 2001 5 22 18 42 44
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
            TIMESTAMP 2002 3 27 18 20 44
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -144 0 -144 
            LINE N 64 -64 0 -64 
            LINE N 320 -224 384 -224 
            LINE N 320 -160 384 -160 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK I14 gnd
            PIN G XLXN_15
        END BLOCK
        BEGIN BLOCK I15 obuf
            PIN I q_int3
            PIN O q(3)
        END BLOCK
        BEGIN BLOCK I16 obuf
            PIN I q_int0
            PIN O q(0)
        END BLOCK
        BEGIN BLOCK I17 obuf
            PIN I q_int1
            PIN O q(1)
        END BLOCK
        BEGIN BLOCK I18 obuf
            PIN I q_int2
            PIN O q(2)
        END BLOCK
        BEGIN BLOCK I6 ibuf
            PIN I clk
            PIN O XLXN_14
        END BLOCK
        BEGIN BLOCK I7 ibuf
            PIN I stop
            PIN O XLXN_22
        END BLOCK
        BEGIN BLOCK I8 ibuf
            PIN I right
            PIN O XLXN_20
        END BLOCK
        BEGIN BLOCK I9 ibuf
            PIN I left
            PIN O XLXN_21
        END BLOCK
        BEGIN BLOCK I10 inv
            PIN I XLXN_21
            PIN O XLXN_16
        END BLOCK
        BEGIN BLOCK I11 inv
            PIN I XLXN_20
            PIN O XLXN_17
        END BLOCK
        BEGIN BLOCK I12 inv
            PIN I XLXN_22
            PIN O XLXN_18
        END BLOCK
        BEGIN BLOCK I13 or2b2
            PIN I0 XLXN_20
            PIN I1 XLXN_21
            PIN O XLXN_19
        END BLOCK
        BEGIN BLOCK run_reg fjkc
            PIN C XLXN_14
            PIN CLR XLXN_15
            PIN J XLXN_17
            PIN K XLXN_16
            PIN Q dir
        END BLOCK
        BEGIN BLOCK dir_reg1 fjkc
            PIN C XLXN_14
            PIN CLR XLXN_15
            PIN J XLXN_19
            PIN K XLXN_18
            PIN Q run
        END BLOCK
        BEGIN BLOCK I19 jcounter
            PIN CE run
            PIN LEFT dir
            PIN CLK XLXN_14
            PIN Q3 q_int3
            PIN Q2 q_int2
            PIN Q1 q_int1
            PIN Q0 q_int0
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE I14 1472 2048 R0
        INSTANCE I15 2608 1024 R0
        INSTANCE I16 2608 1216 R0
        INSTANCE I17 2608 1152 R0
        INSTANCE I18 2608 1088 R0
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
        BEGIN BRANCH q_int3
            WIRE 2512 992 2560 992
            WIRE 2560 992 2592 992
            WIRE 2592 992 2608 992
            BEGIN DISPLAY 2560 992 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int2
            WIRE 2512 1056 2560 1056
            WIRE 2560 1056 2592 1056
            WIRE 2592 1056 2608 1056
            BEGIN DISPLAY 2560 1056 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int1
            WIRE 2512 1120 2560 1120
            WIRE 2560 1120 2592 1120
            WIRE 2592 1120 2608 1120
            BEGIN DISPLAY 2560 1120 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q_int0
            WIRE 2512 1184 2560 1184
            WIRE 2560 1184 2592 1184
            WIRE 2592 1184 2608 1184
            BEGIN DISPLAY 2560 1184 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q(3)
            WIRE 2832 992 2848 992
            WIRE 2848 992 2880 992
            WIRE 2880 992 2944 992
            BEGIN DISPLAY 2848 992 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2960 992 2944 992
        BEGIN BRANCH q(2)
            WIRE 2832 1056 2848 1056
            WIRE 2848 1056 2880 1056
            WIRE 2880 1056 2944 1056
            BEGIN DISPLAY 2848 1056 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2960 1056 2944 1056
        BEGIN BRANCH q(1)
            WIRE 2832 1120 2848 1120
            WIRE 2848 1120 2880 1120
            WIRE 2880 1120 2944 1120
            BEGIN DISPLAY 2848 1120 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2960 1120 2944 1120
        BEGIN BRANCH q(0)
            WIRE 2832 1184 2848 1184
            WIRE 2848 1184 2880 1184
            WIRE 2880 1184 2944 1184
            BEGIN DISPLAY 2848 1184 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2960 1184 2944 1184
        BEGIN BRANCH q(3:0)
            WIRE 2960 928 2960 992
            WIRE 2960 992 2960 1056
            WIRE 2960 1056 2960 1120
            WIRE 2960 1120 2960 1184
            WIRE 2960 1184 2960 1264
            WIRE 2960 1264 3040 1264
        END BRANCH
        IOMARKER 3040 1264 q(3:0) R0 28
        BEGIN BRANCH run
            WIRE 1968 992 1968 1008
            WIRE 1968 992 2016 992
            WIRE 2016 992 2128 992
            BEGIN DISPLAY 2016 992 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH dir
            WIRE 1968 1504 2016 1504
            WIRE 2016 1072 2016 1120
            WIRE 2016 1120 2016 1504
            WIRE 2016 1072 2128 1072
            BEGIN DISPLAY 2016 1120 ATTR Name
                ALIGNMENT TVCENTER
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
            WIRE 1536 1232 1584 1232
            WIRE 1536 1232 1536 1728
            WIRE 1536 1728 1536 1920
            WIRE 1536 1728 1584 1728
        END BRANCH
        BEGIN BRANCH XLXN_16
            WIRE 1440 1504 1584 1504
        END BRANCH
        BEGIN BRANCH XLXN_17
            WIRE 1440 1440 1584 1440
        END BRANCH
        BEGIN BRANCH XLXN_18
            WIRE 1440 1008 1440 1104
            WIRE 1440 1008 1584 1008
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 1472 944 1584 944
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 1120 976 1200 976
            WIRE 1200 976 1216 976
            WIRE 1200 976 1200 1440
            WIRE 1200 1440 1216 1440
        END BRANCH
        BEGIN BRANCH XLXN_21
            WIRE 1120 912 1168 912
            WIRE 1168 912 1216 912
            WIRE 1168 912 1168 1504
            WIRE 1168 1504 1216 1504
        END BRANCH
        BEGIN BRANCH XLXN_22
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
        BEGIN BRANCH XLXN_14
            WIRE 1120 1840 1488 1840
            WIRE 1488 1840 2080 1840
            WIRE 1488 1136 1488 1632
            WIRE 1488 1632 1488 1840
            WIRE 1488 1632 1584 1632
            WIRE 1488 1136 1584 1136
            WIRE 2080 1152 2128 1152
            WIRE 2080 1152 2080 1840
        END BRANCH
        BEGIN INSTANCE I19 2128 1216 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
