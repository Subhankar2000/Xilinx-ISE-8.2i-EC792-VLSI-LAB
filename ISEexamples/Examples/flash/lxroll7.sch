VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL reset
        SIGNAL LED(6:0)
        SIGNAL XLXN_3
        SIGNAL hex(0)
        SIGNAL hex(1)
        SIGNAL hex(2)
        SIGNAL hex(3)
        SIGNAL hex(3:0)
        SIGNAL clk
        PORT Input reset
        PORT Output LED(6:0)
        PORT Input clk
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2001 5 4 14 38 41
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF cd4ce
            TIMESTAMP 2001 5 4 14 38 41
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
        BEGIN BLOCKDEF hex2led
            TIMESTAMP 2004 3 9 23 41 16
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCK I3 vcc
            PIN P XLXN_3
        END BLOCK
        BEGIN BLOCK I5 cd4ce
            PIN C clk
            PIN CE XLXN_3
            PIN CLR reset
            PIN CEO
            PIN Q0 hex(0)
            PIN Q1 hex(1)
            PIN Q2 hex(2)
            PIN Q3 hex(3)
            PIN TC
        END BLOCK
        BEGIN BLOCK I2 hex2led
            PIN HEX(3:0) hex(3:0)
            PIN LED(6:0) LED(6:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE I3 896 768 R0
        INSTANCE I5 1072 1008 R0
        BEGIN BRANCH reset
            WIRE 800 976 1072 976
        END BRANCH
        IOMARKER 800 976 reset R180 28
        IOMARKER 2448 384 LED(6:0) R0 28
        BEGIN BRANCH XLXN_3
            WIRE 960 768 960 816
            WIRE 960 816 1072 816
        END BRANCH
        BEGIN BRANCH hex(0)
            WIRE 1456 560 1552 560
            WIRE 1552 560 1664 560
            BEGIN DISPLAY 1552 560 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1680 560 1664 560
        BEGIN BRANCH hex(1)
            WIRE 1456 624 1552 624
            WIRE 1552 624 1664 624
            BEGIN DISPLAY 1552 624 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1680 624 1664 624
        BEGIN BRANCH hex(2)
            WIRE 1456 688 1552 688
            WIRE 1552 688 1664 688
            BEGIN DISPLAY 1552 688 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1680 688 1664 688
        BEGIN BRANCH hex(3)
            WIRE 1456 752 1552 752
            WIRE 1552 752 1664 752
            BEGIN DISPLAY 1552 752 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1680 752 1664 752
        BEGIN BRANCH hex(3:0)
            WIRE 1680 384 1872 384
            WIRE 1872 384 1904 384
            WIRE 1680 384 1680 560
            WIRE 1680 560 1680 624
            WIRE 1680 624 1680 688
            WIRE 1680 688 1680 752
            WIRE 1680 752 1680 816
            BEGIN DISPLAY 1872 384 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 816 880 1072 880
        END BRANCH
        IOMARKER 816 880 clk R180 28
        BEGIN BRANCH LED(6:0)
            WIRE 2288 384 2432 384
            WIRE 2432 384 2448 384
        END BRANCH
        BEGIN INSTANCE I2 1904 416 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
