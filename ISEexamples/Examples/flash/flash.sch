VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL P_Q0
        SIGNAL P_Q1
        SIGNAL P_Q2
        SIGNAL P_Q3
        SIGNAL P_Q4
        SIGNAL P_Q5
        SIGNAL P_Q6
        SIGNAL P_Q7
        SIGNAL clkin
        SIGNAL XLXN_36
        SIGNAL HALFCLK
        SIGNAL LED(6:0)
        SIGNAL XLXN_37
        SIGNAL XLXN_23
        SIGNAL RESET
        PORT Output P_Q0
        PORT Output P_Q1
        PORT Output P_Q2
        PORT Output P_Q3
        PORT Output P_Q4
        PORT Output P_Q5
        PORT Output P_Q6
        PORT Output P_Q7
        PORT Input clkin
        PORT Output HALFCLK
        PORT Output LED(6:0)
        PORT Input RESET
        BEGIN BLOCKDEF fdc
            TIMESTAMP 2001 5 4 14 12 1
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 0 -256 64 -256 
            LINE N 384 -256 320 -256 
            RECTANGLE N 64 -320 320 -64 
            LINE N 64 -112 80 -128 
            LINE N 80 -128 64 -144 
            LINE N 192 -64 192 -32 
            LINE N 192 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF lxroll7
            TIMESTAMP 2004 3 9 23 41 16
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -108 384 -84 
        END BLOCKDEF
        BEGIN BLOCKDEF bounce8
            TIMESTAMP 2004 3 9 23 41 16
            RECTANGLE N 64 -512 320 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -224 0 -224 
            LINE N 320 -480 384 -480 
            LINE N 320 -416 384 -416 
            LINE N 320 -352 384 -352 
            LINE N 320 -288 384 -288 
            LINE N 320 -224 384 -224 
            LINE N 320 -160 384 -160 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 5 4 14 12 1
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF bufg
            TIMESTAMP 2001 5 4 14 12 1
            LINE N 64 -64 64 0 
            LINE N 128 -32 64 -64 
            LINE N 64 0 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCK I7 fdc
            PIN C XLXN_36
            PIN CLR RESET
            PIN D XLXN_23
            PIN Q HALFCLK
        END BLOCK
        BEGIN BLOCK I6 lxroll7
            PIN reset RESET
            PIN clk XLXN_37
            PIN LED(6:0) LED(6:0)
        END BLOCK
        BEGIN BLOCK I5 bounce8
            PIN reset RESET
            PIN clk XLXN_36
            PIN Q7 P_Q7
            PIN Q5 P_Q6
            PIN Q2 P_Q5
            PIN Q0 P_Q4
            PIN Q1 P_Q3
            PIN Q3 P_Q2
            PIN Q6 P_Q1
            PIN Q4 P_Q0
        END BLOCK
        BEGIN BLOCK I1 inv
            PIN I HALFCLK
            PIN O XLXN_23
        END BLOCK
        BEGIN BLOCK I3 bufg
            PIN I HALFCLK
            PIN O XLXN_37
        END BLOCK
        BEGIN BLOCK I4 bufg
            PIN I clkin
            PIN O XLXN_36
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE I7 1200 1392 R0
        INSTANCE I1 1488 864 R180
        INSTANCE I3 1840 1168 R0
        INSTANCE I4 608 784 R0
        BEGIN BRANCH P_Q0
            WIRE 1824 720 2160 720
        END BRANCH
        BEGIN BRANCH P_Q1
            WIRE 1824 656 2160 656
        END BRANCH
        BEGIN BRANCH P_Q2
            WIRE 1824 592 2160 592
        END BRANCH
        BEGIN BRANCH P_Q3
            WIRE 1824 528 2160 528
        END BRANCH
        BEGIN BRANCH P_Q4
            WIRE 1824 464 2160 464
        END BRANCH
        BEGIN BRANCH P_Q5
            WIRE 1824 400 2160 400
        END BRANCH
        BEGIN BRANCH P_Q6
            WIRE 1824 336 2160 336
        END BRANCH
        BEGIN BRANCH P_Q7
            WIRE 1824 272 2160 272
        END BRANCH
        BEGIN BRANCH clkin
            WIRE 448 752 608 752
        END BRANCH
        IOMARKER 448 752 clkin R180 28
        BEGIN BRANCH HALFCLK
            WIRE 1488 896 1664 896
            WIRE 1664 896 1664 1136
            WIRE 1664 1136 1840 1136
            WIRE 1664 896 2896 896
            WIRE 1584 1136 1664 1136
        END BRANCH
        IOMARKER 2896 896 HALFCLK R0 28
        IOMARKER 448 1360 RESET R180 28
        BEGIN BRANCH LED(6:0)
            WIRE 2592 1136 2800 1136
        END BRANCH
        BEGIN BRANCH XLXN_23
            WIRE 1088 896 1088 1136
            WIRE 1088 1136 1200 1136
            WIRE 1088 896 1264 896
        END BRANCH
        BEGIN INSTANCE I5 1440 752 R0
        END INSTANCE
        BEGIN INSTANCE I6 2208 1232 R0
        END INSTANCE
        BEGIN BRANCH XLXN_37
            WIRE 2064 1136 2080 1136
            WIRE 2080 1136 2080 1200
            WIRE 2080 1200 2208 1200
        END BRANCH
        BEGIN BRANCH RESET
            WIRE 448 1360 1152 1360
            WIRE 1152 1360 1200 1360
            WIRE 1152 1360 1152 1424
            WIRE 1152 1424 2144 1424
            WIRE 2144 1136 2208 1136
            WIRE 2144 1136 2144 1424
        END BRANCH
        BEGIN BRANCH RESET
            WIRE 1280 272 1296 272
            WIRE 1296 272 1440 272
            BEGIN DISPLAY 1280 272 ATTR Name
                ALIGNMENT RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_36
            WIRE 832 752 864 752
            WIRE 864 752 992 752
            WIRE 992 752 992 1264
            WIRE 992 1264 1200 1264
            WIRE 992 528 992 752
            WIRE 992 528 1440 528
            BEGIN DISPLAY 864 752 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2160 272 P_Q7 R0 28
        IOMARKER 2160 336 P_Q6 R0 28
        IOMARKER 2160 400 P_Q5 R0 28
        IOMARKER 2160 464 P_Q4 R0 28
        IOMARKER 2160 528 P_Q3 R0 28
        IOMARKER 2160 592 P_Q2 R0 28
        IOMARKER 2160 656 P_Q1 R0 28
        IOMARKER 2160 720 P_Q0 R0 28
        IOMARKER 2800 1136 LED(6:0) R0 28
    END SHEET
END SCHEMATIC
