VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL tensout(6:0)
        SIGNAL onesout(6:0)
        SIGNAL tenthsout(9:0)
        SIGNAL reset
        SIGNAL strtstop
        SIGNAL XLXN_10
        SIGNAL XLXN_11
        SIGNAL XLXN_12
        SIGNAL locked
        SIGNAL clk
        SIGNAL clk_int
        SIGNAL XLXN_36
        SIGNAL q_thres
        SIGNAL clken_int
        SIGNAL rst_int
        SIGNAL ones(3:0)
        SIGNAL tens(3:0)
        SIGNAL one_hot(9:0)
        SIGNAL q(3:0)
        PORT Output tensout(6:0)
        PORT Output onesout(6:0)
        PORT Output tenthsout(9:0)
        PORT Input reset
        PORT Input strtstop
        PORT Input clk
        BEGIN BLOCKDEF cnt60
            TIMESTAMP 2003 11 17 20 53 22
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            RECTANGLE N 320 -172 384 -148 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -108 384 -84 
        END BLOCKDEF
        BEGIN BLOCKDEF dcm1
            TIMESTAMP 2003 11 17 20 17 52
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 320 -160 384 -160 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
            LINE N 64 -48 0 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF decode
            TIMESTAMP 2003 3 13 21 7 32
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF stmach_v
            TIMESTAMP 2003 11 17 20 53 22
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF outs3
            TIMESTAMP 2002 3 27 17 20 46
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF tenths
            TIMESTAMP 2005 9 22 19 38 50
            RECTANGLE N 32 0 448 272 
            LINE N 0 176 32 176 
            LINE N 0 208 32 208 
            LINE N 448 80 480 80 
            BEGIN LINE W 448 176 480 176 
            END LINE
            LINE N 288 272 288 304 
        END BLOCKDEF
        BEGIN BLOCKDEF hex2led
            TIMESTAMP 2003 11 17 20 53 22
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ibuf
            TIMESTAMP 2001 2 2 12 37 45
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 2 2 12 38 38
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2001 2 2 12 38 38
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCK XLXI_1 cnt60
            PIN ce XLXN_36
            PIN clk clk_int
            PIN clr rst_int
            PIN lsbsec(3:0) ones(3:0)
            PIN msbsec(3:0) tens(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 dcm1
            PIN RST_IN XLXN_11
            PIN LOCKED_OUT locked
            PIN CLK0_OUT clk_int
            PIN CLKIN_IBUFG_OUT
            PIN CLKIN_IN clk
        END BLOCK
        BEGIN BLOCK XLXI_4 decode
            PIN binary(3:0) q(3:0)
            PIN one_hot(9:0) one_hot(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_5 stmach_v
            PIN CLK clk_int
            PIN DCM_lock locked
            PIN reset XLXN_11
            PIN strtstop XLXN_12
            PIN clken clken_int
            PIN rst rst_int
        END BLOCK
        BEGIN BLOCK XLXI_6 outs3
            PIN inputs(9:0) one_hot(9:0)
            PIN outs(9:0) tenthsout(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 tenths
            PIN CE clken_int
            PIN CLK clk_int
            PIN Q_THRESH0 q_thres
            PIN Q(3:0) q(3:0)
            PIN AINIT rst_int
        END BLOCK
        BEGIN BLOCK XLXI_8 hex2led
            PIN HEX(3:0) ones(3:0)
            PIN LED(6:0) onesout(6:0)
        END BLOCK
        BEGIN BLOCK XLXI_9 hex2led
            PIN HEX(3:0) tens(3:0)
            PIN LED(6:0) tensout(6:0)
        END BLOCK
        BEGIN BLOCK XLXI_10 ibuf
            PIN I reset
            PIN O XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_11 ibuf
            PIN I strtstop
            PIN O XLXN_10
        END BLOCK
        BEGIN BLOCK XLXI_12 inv
            PIN I XLXN_10
            PIN O XLXN_12
        END BLOCK
        BEGIN BLOCK XLXI_13 and2
            PIN I0 clken_int
            PIN I1 q_thres
            PIN O XLXN_36
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 2720 1760
        BEGIN BRANCH tensout(6:0)
            WIRE 2096 1488 2272 1488
        END BRANCH
        BEGIN BRANCH onesout(6:0)
            WIRE 2080 1264 2272 1264
        END BRANCH
        BEGIN BRANCH tenthsout(9:0)
            WIRE 2096 848 2272 848
        END BRANCH
        IOMARKER 2272 1488 tensout(6:0) R0 28
        IOMARKER 2272 1264 onesout(6:0) R0 28
        BEGIN INSTANCE XLXI_5 1584 448 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_1 1088 1456 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_7 432 672 R0
        END INSTANCE
        BEGIN BRANCH XLXN_11
            WIRE 624 240 688 240
            WIRE 688 240 688 416
            WIRE 688 416 1552 416
            WIRE 688 240 800 240
            WIRE 1552 352 1584 352
            WIRE 1552 352 1552 416
        END BRANCH
        BEGIN BRANCH locked
            WIRE 1184 240 1200 240
            WIRE 1200 240 1200 288
            WIRE 1200 288 1360 288
            WIRE 1360 288 1584 288
            BEGIN DISPLAY 1360 288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_10
            WIRE 624 480 752 480
        END BRANCH
        INSTANCE XLXI_11 400 512 R0
        BEGIN BRANCH strtstop
            WIRE 224 480 400 480
        END BRANCH
        INSTANCE XLXI_12 752 512 R0
        BEGIN BRANCH XLXN_12
            WIRE 976 480 1584 480
            WIRE 1584 416 1584 480
        END BRANCH
        BEGIN INSTANCE XLXI_3 800 400 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 224 352 800 352
        END BRANCH
        BEGIN BRANCH clk_int
            WIRE 1184 304 1520 304
            WIRE 1520 224 1584 224
            WIRE 1520 224 1520 304
            BEGIN DISPLAY 1520 224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_10 400 272 R0
        BEGIN BRANCH reset
            WIRE 224 240 400 240
        END BRANCH
        IOMARKER 224 480 strtstop R180 28
        IOMARKER 224 352 clk R180 28
        IOMARKER 224 240 reset R180 28
        INSTANCE XLXI_13 656 1392 R0
        BEGIN BRANCH XLXN_36
            WIRE 912 1296 1088 1296
        END BRANCH
        BEGIN BRANCH q_thres
            WIRE 640 1168 640 1264
            WIRE 640 1264 656 1264
            WIRE 640 1168 656 1168
            WIRE 656 1168 992 1168
            WIRE 912 752 992 752
            WIRE 992 752 992 1168
            BEGIN DISPLAY 656 1168 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clken_int
            WIRE 1968 224 2112 224
            BEGIN DISPLAY 2112 224 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clken_int
            WIRE 320 848 432 848
            BEGIN DISPLAY 320 848 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clken_int
            WIRE 512 1328 656 1328
            BEGIN DISPLAY 512 1328 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rst_int
            WIRE 1968 416 2112 416
            BEGIN DISPLAY 2112 416 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rst_int
            WIRE 576 1040 720 1040
            WIRE 720 976 720 1040
            BEGIN DISPLAY 576 1040 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rst_int
            WIRE 960 1424 1088 1424
            BEGIN DISPLAY 960 1424 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_int
            WIRE 320 880 432 880
            BEGIN DISPLAY 320 880 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_int
            WIRE 960 1360 1088 1360
            BEGIN DISPLAY 960 1360 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ones(3:0)
            WIRE 1472 1296 1488 1296
            WIRE 1488 1264 1488 1296
            WIRE 1488 1264 1584 1264
            WIRE 1584 1264 1696 1264
            BEGIN DISPLAY 1584 1264 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH tens(3:0)
            WIRE 1472 1360 1488 1360
            WIRE 1488 1360 1488 1488
            WIRE 1488 1488 1584 1488
            WIRE 1584 1488 1712 1488
            BEGIN DISPLAY 1584 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH one_hot(9:0)
            WIRE 1536 848 1632 848
            WIRE 1632 848 1712 848
            BEGIN DISPLAY 1632 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH q(3:0)
            WIRE 912 848 1056 848
            WIRE 1056 848 1152 848
            BEGIN DISPLAY 1056 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_4 1152 880 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_6 1712 880 R0
        END INSTANCE
        IOMARKER 2272 848 tenthsout(9:0) R0 28
        BEGIN INSTANCE XLXI_8 1696 1296 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_9 1712 1520 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
