VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "xbr"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL ones(3:0)
        SIGNAL onesout(6:0)
        SIGNAL tens(3:0)
        SIGNAL tensout(6:0)
        SIGNAL XLXN_24
        SIGNAL XLXN_25
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL RST
        SIGNAL CDRST
        SIGNAL CLKIN
        SIGNAL TENTHSOUT(9:0)
        SIGNAL XLXN_36
        SIGNAL XLXN_37
        SIGNAL STRTSTOP
        SIGNAL XLXN_40
        SIGNAL XLXN_41
        PORT Output onesout(6:0)
        PORT Output tensout(6:0)
        PORT Input RST
        PORT Input CDRST
        PORT Input CLKIN
        PORT Output TENTHSOUT(9:0)
        PORT Input STRTSTOP
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 4 20 11 49 1
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF tenths
            TIMESTAMP 2002 5 29 1 43 58
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            LINE N 320 -64 384 -64 
            RECTANGLE N 320 -76 384 -52 
        END BLOCKDEF
        BEGIN BLOCKDEF hex2led
            TIMESTAMP 2002 5 29 1 43 56
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ibuf
            TIMESTAMP 2001 4 20 11 49 1
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF cnt60
            TIMESTAMP 2002 5 29 1 43 56
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            RECTANGLE N 320 -172 384 -148 
            LINE N 320 -64 384 -64 
            RECTANGLE N 320 -76 384 -52 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2001 5 11 10 41 37
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCKDEF clk_div16r
            TIMESTAMP 2001 10 5 9 0 8
            RECTANGLE N 64 -320 320 -64 
            LINE N 64 -112 80 -128 
            LINE N 80 -128 64 -144 
            LINE N 384 -192 320 -192 
            LINE N 0 -128 64 -128 
            LINE N 64 -256 0 -256 
        END BLOCKDEF
        BEGIN BLOCKDEF stmchine
            TIMESTAMP 2002 5 29 1 43 56
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            LINE N 320 -64 384 -64 
        END BLOCKDEF
        BEGIN BLOCK I13 inv
            PIN I XLXN_30
            PIN O XLXN_25
        END BLOCK
        BEGIN BLOCK I12 tenths
            PIN CLK_EN XLXN_40
            PIN CLOCK XLXN_29
            PIN ASYNC_CTRL XLXN_36
            PIN TERM_CNT XLXN_41
            PIN Q_OUT(9:0) TENTHSOUT(9:0)
        END BLOCK
        BEGIN BLOCK I7 hex2led
            PIN HEX(3:0) tens(3:0)
            PIN LED(6:0) tensout(6:0)
        END BLOCK
        BEGIN BLOCK I8 hex2led
            PIN HEX(3:0) ones(3:0)
            PIN LED(6:0) onesout(6:0)
        END BLOCK
        BEGIN BLOCK I3 ibuf
            PIN I STRTSTOP
            PIN O XLXN_30
        END BLOCK
        BEGIN BLOCK I5 ibuf
            PIN I RST
            PIN O XLXN_24
        END BLOCK
        BEGIN BLOCK I10 cnt60
            PIN ce XLXN_37
            PIN clk XLXN_29
            PIN clr XLXN_36
            PIN lsbsec(3:0) ones(3:0)
            PIN msbsec(3:0) tens(3:0)
        END BLOCK
        BEGIN BLOCK I11 and2
            PIN I0 XLXN_41
            PIN I1 XLXN_40
            PIN O XLXN_37
        END BLOCK
        BEGIN BLOCK XLXI_2 clk_div16r
            PIN CLKIN CLKIN
            PIN CDRST CDRST
            PIN CLKDV XLXN_29
        END BLOCK
        BEGIN BLOCK XLXI_3 stmchine
            PIN CLK XLXN_29
            PIN RESET XLXN_24
            PIN STRTSTOP XLXN_25
            PIN CLKEN XLXN_40
            PIN RST XLXN_36
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE I11 288 1424 R0
        BEGIN BRANCH ones(3:0)
            WIRE 1152 1328 1200 1328
            WIRE 1200 1328 1264 1328
            WIRE 1264 1264 1264 1328
            WIRE 1264 1264 1312 1264
            WIRE 1312 1264 1408 1264
            BEGIN DISPLAY 1312 1264 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH onesout(6:0)
            WIRE 1792 1264 1856 1264
            WIRE 1856 1264 1984 1264
        END BRANCH
        IOMARKER 1984 1264 onesout(6:0) R0 28
        BEGIN BRANCH tens(3:0)
            WIRE 1152 1424 1200 1424
            WIRE 1200 1424 1264 1424
            WIRE 1264 1424 1264 1488
            WIRE 1264 1488 1328 1488
            WIRE 1328 1488 1408 1488
            BEGIN DISPLAY 1328 1488 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH tensout(6:0)
            WIRE 1792 1488 1856 1488
            WIRE 1856 1488 1984 1488
        END BRANCH
        IOMARKER 1984 1488 tensout(6:0) R0 28
        BEGIN BRANCH XLXN_24
            WIRE 624 432 640 432
            WIRE 640 432 1296 432
            WIRE 1296 432 1312 432
        END BRANCH
        BEGIN INSTANCE I10 768 1488 R0
        END INSTANCE
        BEGIN INSTANCE I8 1408 1296 R0
        END INSTANCE
        BEGIN INSTANCE I7 1408 1520 R0
        END INSTANCE
        BEGIN INSTANCE I12 1040 2032 R0
        END INSTANCE
        INSTANCE XLXI_2 560 1040 R0
        BEGIN BRANCH XLXN_25
            WIRE 976 528 1296 528
            WIRE 1296 496 1312 496
            WIRE 1296 496 1296 528
        END BRANCH
        INSTANCE I5 400 464 R0
        INSTANCE I3 400 560 R0
        BEGIN BRANCH XLXN_29
            WIRE 704 1040 1024 1040
            WIRE 704 1040 704 1392
            WIRE 704 1392 704 1936
            WIRE 704 1936 1040 1936
            WIRE 704 1392 768 1392
            WIRE 944 848 1024 848
            WIRE 1024 848 1120 848
            WIRE 1024 848 1024 1040
            WIRE 1120 368 1120 848
            WIRE 1120 368 1312 368
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 624 528 752 528
        END BRANCH
        BEGIN BRANCH RST
            WIRE 240 432 400 432
        END BRANCH
        BEGIN BRANCH STRTSTOP
            WIRE 240 528 400 528
        END BRANCH
        BEGIN BRANCH CDRST
            WIRE 240 784 560 784
        END BRANCH
        BEGIN BRANCH CLKIN
            WIRE 240 912 560 912
        END BRANCH
        BEGIN BRANCH TENTHSOUT(9:0)
            WIRE 1424 1968 1440 1968
            WIRE 1440 1968 1600 1968
        END BRANCH
        BEGIN BRANCH XLXN_36
            WIRE 656 1088 1760 1088
            WIRE 656 1088 656 1456
            WIRE 656 1456 656 2000
            WIRE 656 2000 1040 2000
            WIRE 656 1456 768 1456
            WIRE 1696 464 1760 464
            WIRE 1760 464 1760 1088
        END BRANCH
        IOMARKER 240 432 RST R180 28
        IOMARKER 240 528 STRTSTOP R180 28
        IOMARKER 240 784 CDRST R180 28
        IOMARKER 240 912 CLKIN R180 28
        IOMARKER 1600 1968 TENTHSOUT(9:0) R0 28
        BEGIN INSTANCE XLXI_3 1312 528 R0
        END INSTANCE
        BEGIN BRANCH XLXN_37
            WIRE 544 1328 608 1328
            WIRE 608 1328 720 1328
            WIRE 720 1328 768 1328
        END BRANCH
        BEGIN BRANCH XLXN_40
            WIRE 240 1024 240 1296
            WIRE 240 1296 288 1296
            WIRE 240 1024 560 1024
            WIRE 560 1024 1792 1024
            WIRE 560 1024 560 1872
            WIRE 560 1872 1040 1872
            WIRE 1696 368 1792 368
            WIRE 1792 368 1792 1024
        END BRANCH
        BEGIN BRANCH XLXN_41
            WIRE 224 1360 224 1664
            WIRE 224 1664 1520 1664
            WIRE 1520 1664 1520 1872
            WIRE 224 1360 288 1360
            WIRE 1424 1872 1520 1872
        END BRANCH
        INSTANCE I13 752 560 R0
    END SHEET
END SCHEMATIC
