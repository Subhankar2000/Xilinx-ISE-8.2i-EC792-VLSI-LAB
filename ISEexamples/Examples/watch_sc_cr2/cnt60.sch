VERSION 5
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "XBR"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    End ATTR
    BEGIN NETLIST
        SIGNAL ce
        SIGNAL lsbsec(0)
        SIGNAL lsbsec(1)
        SIGNAL lsbsec(2)
        SIGNAL lsbsec(3)
        SIGNAL lsbsec(3:0)
        SIGNAL clk
        SIGNAL msbsec(0)
        SIGNAL msbsec(1)
        SIGNAL msbsec(2)
        SIGNAL msbsec(3)
        SIGNAL msbsec(3:0)
        SIGNAL XLXN_13
        SIGNAL XLXN_14
        SIGNAL XLXN_15
        SIGNAL XLXN_16
        SIGNAL clr
        SIGNAL XLXN_18
        SIGNAL XLXN_19
        SIGNAL XLXN_20
        PORT Input ce
        PORT Output lsbsec(3:0)
        PORT Input clk
        PORT Output msbsec(3:0)
        PORT Input clr
        BEGIN BLOCKDEF inv
            TIMESTAMP 2002 1 7 13 27 48
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF or2
            TIMESTAMP 2002 1 7 13 27 48
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 28 -224 204 -48 112 -48 192 -96 
            ARC N -40 -152 72 -40 48 -48 48 -144 
            LINE N 112 -144 48 -144 
            ARC N 28 -144 204 32 192 -96 112 -144 
            LINE N 112 -48 48 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF and4
            TIMESTAMP 2002 1 7 13 27 48
            LINE N 144 -112 64 -112 
            ARC N 96 -208 192 -112 144 -112 144 -208 
            LINE N 64 -208 144 -208 
            LINE N 64 -64 64 -256 
            LINE N 256 -160 192 -160 
            LINE N 0 -256 64 -256 
            LINE N 0 -192 64 -192 
            LINE N 0 -128 64 -128 
            LINE N 0 -64 64 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2002 1 7 13 27 48
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCKDEF cbd4ce
            TIMESTAMP 2001 8 23 8 34 8
            RECTANGLE N 64 -512 320 -64 
            LINE N 0 -32 64 -32 
            LINE N 0 -128 64 -128 
            LINE N 384 -256 320 -256 
            LINE N 384 -320 320 -320 
            LINE N 384 -384 320 -384 
            LINE N 384 -448 320 -448 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 384 -128 320 -128 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 0 -192 64 -192 
            LINE N 384 -192 320 -192 
        END BLOCKDEF
        BEGIN BLOCKDEF cdd4ce
            TIMESTAMP 2001 8 23 8 47 21
            LINE N 384 -192 320 -192 
            RECTANGLE N 64 -512 320 -64 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 384 -128 320 -128 
            LINE N 384 -256 320 -256 
            LINE N 384 -320 320 -320 
            LINE N 384 -384 320 -384 
            LINE N 384 -448 320 -448 
            LINE N 0 -32 64 -32 
            LINE N 0 -192 64 -192 
            LINE N 0 -128 64 -128 
        END BLOCKDEF
        BEGIN BLOCK I1 inv
            PIN I msbsec(3)
            PIN O XLXN_14
        END BLOCK
        BEGIN BLOCK I2 inv
            PIN I msbsec(1)
            PIN O XLXN_13
        END BLOCK
        BEGIN BLOCK I3 or2
            PIN I0 XLXN_20
            PIN I1 clr
            PIN O XLXN_15
        END BLOCK
        BEGIN BLOCK I4 and4
            PIN I0 XLXN_14
            PIN I1 msbsec(2)
            PIN I2 XLXN_13
            PIN I3 msbsec(0)
            PIN O XLXN_16
        END BLOCK
        BEGIN BLOCK I7 and2
            PIN I0 XLXN_16
            PIN I1 XLXN_19
            PIN O XLXN_20
        END BLOCK
        BEGIN BLOCK I8 and2
            PIN I0 ce
            PIN I1 XLXN_18
            PIN O XLXN_19
        END BLOCK
        BEGIN BLOCK XLXI_9 cbd4ce
            PIN C clk
            PIN CE XLXN_19
            PIN CLR XLXN_15
            PIN CEO
            PIN Q0 msbsec(0)
            PIN Q1 msbsec(1)
            PIN Q2 msbsec(2)
            PIN Q3 msbsec(3)
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_10 cdd4ce
            PIN C clk
            PIN CE ce
            PIN CLR clr
            PIN CEO
            PIN Q0 lsbsec(0)
            PIN Q1 lsbsec(1)
            PIN Q2 lsbsec(2)
            PIN Q3 lsbsec(3)
            PIN TC XLXN_18
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 5440 3520
        INSTANCE I1 2848 1040 R0
        INSTANCE I2 2848 912 R0
        INSTANCE I3 1232 1936 R0
        INSTANCE I4 3216 1072 R0
        INSTANCE I7 496 2176 R0
        INSTANCE I8 736 1216 R0
        BEGIN BRANCH ce
            WIRE 320 576 416 576
            WIRE 416 576 416 1152
            WIRE 416 1152 736 1152
            WIRE 416 576 896 576
        END BRANCH
        IOMARKER 320 576 ce
        BEGIN BRANCH lsbsec(0)
            WIRE 1280 320 1472 320
            WIRE 1472 320 1760 320
            BEGIN DISPLAY 1472 320 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1776 320 1760 320
        BEGIN BRANCH lsbsec(1)
            WIRE 1280 384 1472 384
            WIRE 1472 384 1760 384
            BEGIN DISPLAY 1472 384 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1776 384 1760 384
        BEGIN BRANCH lsbsec(2)
            WIRE 1280 448 1472 448
            WIRE 1472 448 1760 448
            BEGIN DISPLAY 1472 448 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1776 448 1760 448
        BEGIN BRANCH lsbsec(3)
            WIRE 1280 512 1472 512
            WIRE 1472 512 1760 512
            BEGIN DISPLAY 1472 512 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1776 512 1760 512
        BEGIN BRANCH lsbsec(3:0)
            WIRE 1776 240 1776 320
            WIRE 1776 320 1776 384
            WIRE 1776 384 1776 448
            WIRE 1776 448 1776 512
            WIRE 1776 512 1776 624
            WIRE 1776 624 2096 624
        END BRANCH
        IOMARKER 2096 624 lsbsec(3:0)
        BEGIN BRANCH clk
            WIRE 320 640 384 640
            WIRE 384 640 384 1744
            WIRE 384 1744 1728 1744
            WIRE 384 640 896 640
        END BRANCH
        IOMARKER 320 640 clk
        BEGIN BRANCH msbsec(0)
            WIRE 2112 1424 2128 1424
            WIRE 2128 1424 2352 1424
            WIRE 2352 1424 2496 1424
            WIRE 2128 816 2128 1424
            WIRE 2128 816 3216 816
            BEGIN DISPLAY 2352 1424 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2512 1424 2496 1424
        BEGIN BRANCH msbsec(1)
            WIRE 2112 1488 2160 1488
            WIRE 2160 1488 2352 1488
            WIRE 2352 1488 2496 1488
            WIRE 2160 880 2160 1488
            WIRE 2160 880 2848 880
            BEGIN DISPLAY 2352 1488 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2512 1488 2496 1488
        BEGIN BRANCH msbsec(2)
            WIRE 2112 1552 2192 1552
            WIRE 2192 1552 2352 1552
            WIRE 2352 1552 2496 1552
            WIRE 2192 944 2192 1552
            WIRE 2192 944 3216 944
            BEGIN DISPLAY 2352 1552 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2512 1552 2496 1552
        BEGIN BRANCH msbsec(3)
            WIRE 2112 1616 2224 1616
            WIRE 2224 1616 2352 1616
            WIRE 2352 1616 2496 1616
            WIRE 2224 1008 2224 1616
            WIRE 2224 1008 2848 1008
            BEGIN DISPLAY 2352 1616 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 2512 1616 2496 1616
        BEGIN BRANCH msbsec(3:0)
            WIRE 2512 1392 2512 1424
            WIRE 2512 1424 2512 1488
            WIRE 2512 1488 2512 1552
            WIRE 2512 1552 2512 1616
            WIRE 2512 1616 2512 1856
            WIRE 2512 1856 2928 1856
        END BRANCH
        IOMARKER 2928 1856 msbsec(3:0)
        BEGIN BRANCH XLXN_13
            WIRE 3072 880 3216 880
        END BRANCH
        BEGIN BRANCH XLXN_14
            WIRE 3072 1008 3216 1008
        END BRANCH
        BEGIN BRANCH XLXN_15
            WIRE 1488 1840 1504 1840
            WIRE 1504 1840 1728 1840
        END BRANCH
        BEGIN BRANCH XLXN_16
            WIRE 320 2112 320 2400
            WIRE 320 2400 3632 2400
            WIRE 320 2112 496 2112
            WIRE 3472 912 3632 912
            WIRE 3632 912 3632 2400
        END BRANCH
        BEGIN BRANCH clr
            WIRE 208 1808 272 1808
            WIRE 272 1808 1232 1808
            WIRE 272 736 272 1808
            WIRE 272 736 896 736
        END BRANCH
        IOMARKER 208 1808 clr
        BEGIN BRANCH XLXN_18
            WIRE 480 960 1504 960
            WIRE 480 960 480 1088
            WIRE 480 1088 720 1088
            WIRE 720 1088 736 1088
            WIRE 1280 640 1504 640
            WIRE 1504 640 1504 960
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 320 1680 1152 1680
            WIRE 1152 1680 1728 1680
            WIRE 320 1680 320 2048
            WIRE 320 2048 496 2048
            WIRE 992 1120 1152 1120
            WIRE 1152 1120 1152 1680
        END BRANCH
        BEGIN BRANCH XLXN_20
            WIRE 752 2080 960 2080
            WIRE 960 1872 960 2080
            WIRE 960 1872 1232 1872
        END BRANCH
        INSTANCE XLXI_9 1728 1872 R0
        INSTANCE XLXI_10 896 768 R0
    END SHEET
END SCHEMATIC
