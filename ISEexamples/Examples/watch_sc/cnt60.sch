VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL clk
        SIGNAL ce
        SIGNAL clr
        SIGNAL msbsec(3:0)
        SIGNAL XLXN_11
        SIGNAL XLXN_12
        SIGNAL msbsec(0)
        SIGNAL msbsec(1)
        SIGNAL msbsec(2)
        SIGNAL msbsec(3)
        SIGNAL XLXN_21
        SIGNAL XLXN_22
        SIGNAL XLXN_23
        SIGNAL msb_en
        SIGNAL XLXN_27
        SIGNAL lsbsec(0)
        SIGNAL lsbsec(2)
        SIGNAL lsbsec(3)
        SIGNAL lsbsec(1)
        SIGNAL lsbsec(3:0)
        PORT Input clk
        PORT Input ce
        PORT Input clr
        PORT Output msbsec(3:0)
        PORT Output lsbsec(3:0)
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
        BEGIN BLOCKDEF cd4ce
            TIMESTAMP 2001 2 2 12 36 39
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
        BEGIN BLOCKDEF or2
            TIMESTAMP 2001 2 2 12 38 38
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
            TIMESTAMP 2001 2 2 12 38 38
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
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 2 2 12 38 38
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF cb4ce
            TIMESTAMP 2001 2 2 12 36 39
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
        BEGIN BLOCK XLXI_1 and2
            PIN I0 ce
            PIN I1 XLXN_27
            PIN O msb_en
        END BLOCK
        BEGIN BLOCK XLXI_2 and2
            PIN I0 XLXN_23
            PIN I1 msb_en
            PIN O XLXN_22
        END BLOCK
        BEGIN BLOCK XLXI_3 cd4ce
            PIN C clk
            PIN CE ce
            PIN CLR clr
            PIN CEO
            PIN Q0 lsbsec(0)
            PIN Q1 lsbsec(1)
            PIN Q2 lsbsec(2)
            PIN Q3 lsbsec(3)
            PIN TC XLXN_27
        END BLOCK
        BEGIN BLOCK XLXI_5 or2
            PIN I0 XLXN_22
            PIN I1 clr
            PIN O XLXN_21
        END BLOCK
        BEGIN BLOCK XLXI_6 and4
            PIN I0 XLXN_12
            PIN I1 msbsec(2)
            PIN I2 XLXN_11
            PIN I3 msbsec(0)
            PIN O XLXN_23
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I msbsec(1)
            PIN O XLXN_11
        END BLOCK
        BEGIN BLOCK XLXI_8 inv
            PIN I msbsec(3)
            PIN O XLXN_12
        END BLOCK
        BEGIN BLOCK XLXI_15 cb4ce
            PIN C clk
            PIN CE msb_en
            PIN CLR XLXN_21
            PIN CEO
            PIN Q0 msbsec(0)
            PIN Q1 msbsec(1)
            PIN Q2 msbsec(2)
            PIN Q3 msbsec(3)
            PIN TC
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH clk
            WIRE 544 1232 704 1232
            WIRE 704 1232 704 1664
            WIRE 704 1664 1776 1664
            WIRE 704 784 704 1232
            WIRE 704 784 928 784
        END BRANCH
        BEGIN BRANCH ce
            WIRE 528 720 768 720
            WIRE 768 720 928 720
            WIRE 768 720 768 1472
            WIRE 768 1472 1344 1472
        END BRANCH
        BEGIN BRANCH clr
            WIRE 544 1728 832 1728
            WIRE 832 1728 1360 1728
            WIRE 832 880 928 880
            WIRE 832 880 832 1120
            WIRE 832 1120 832 1728
        END BRANCH
        INSTANCE XLXI_6 2640 2128 R0
        INSTANCE XLXI_7 2384 1968 R0
        INSTANCE XLXI_8 2384 2096 R0
        BEGIN BRANCH XLXN_11
            WIRE 2608 1936 2640 1936
        END BRANCH
        BEGIN BRANCH XLXN_12
            WIRE 2608 2064 2640 2064
        END BRANCH
        BEGIN BRANCH msbsec(0)
            WIRE 2160 1344 2352 1344
            WIRE 2352 1344 2352 1872
            WIRE 2352 1872 2640 1872
            WIRE 2352 1344 2432 1344
            WIRE 2432 1344 2512 1344
            BEGIN DISPLAY 2432 1344 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH msbsec(1)
            WIRE 2160 1408 2320 1408
            WIRE 2320 1408 2320 1936
            WIRE 2320 1936 2384 1936
            WIRE 2320 1408 2432 1408
            WIRE 2432 1408 2512 1408
            BEGIN DISPLAY 2432 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_3 928 912 R0
        INSTANCE XLXI_1 1344 1536 R0
        BEGIN BRANCH XLXN_27
            WIRE 1312 784 1328 784
            WIRE 1328 784 1328 1408
            WIRE 1328 1408 1344 1408
        END BRANCH
        IOMARKER 528 720 ce R180 28
        IOMARKER 544 1232 clk R180 28
        INSTANCE XLXI_2 960 2032 R0
        BEGIN BRANCH msb_en
            WIRE 928 1600 928 1904
            WIRE 928 1904 960 1904
            WIRE 928 1600 1440 1600
            WIRE 1440 1600 1680 1600
            WIRE 1680 1600 1776 1600
            WIRE 1600 1440 1680 1440
            WIRE 1680 1440 1680 1600
            BEGIN DISPLAY 1440 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_23
            WIRE 928 1968 960 1968
            WIRE 928 1968 928 2176
            WIRE 928 2176 2992 2176
            WIRE 2896 1968 2992 1968
            WIRE 2992 1968 2992 2176
        END BRANCH
        BEGIN BRANCH msbsec(2)
            WIRE 2160 1472 2288 1472
            WIRE 2288 1472 2288 2000
            WIRE 2288 2000 2640 2000
            WIRE 2288 1472 2432 1472
            WIRE 2432 1472 2512 1472
            BEGIN DISPLAY 2432 1472 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH msbsec(3)
            WIRE 2160 1536 2256 1536
            WIRE 2256 1536 2256 2064
            WIRE 2256 2064 2384 2064
            WIRE 2256 1536 2432 1536
            WIRE 2432 1536 2512 1536
            BEGIN DISPLAY 2432 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_5 1360 1856 R0
        BEGIN BRANCH XLXN_22
            WIRE 1216 1936 1232 1936
            WIRE 1232 1792 1360 1792
            WIRE 1232 1792 1232 1936
        END BRANCH
        BEGIN BRANCH XLXN_21
            WIRE 1616 1760 1776 1760
        END BRANCH
        IOMARKER 544 1728 clr R180 28
        INSTANCE XLXI_15 1776 1792 R0
        IOMARKER 2752 1776 msbsec(3:0) R0 28
        BEGIN BRANCH msbsec(3:0)
            WIRE 2608 1296 2608 1344
            WIRE 2608 1344 2608 1408
            WIRE 2608 1408 2608 1472
            WIRE 2608 1472 2608 1536
            WIRE 2608 1536 2608 1776
            WIRE 2608 1776 2752 1776
        END BRANCH
        IOMARKER 2800 720 lsbsec(3:0) R0 28
        BEGIN BRANCH lsbsec(0)
            WIRE 1312 464 1360 464
            WIRE 1360 464 1520 464
            BEGIN DISPLAY 1360 464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH lsbsec(2)
            WIRE 1312 592 1360 592
            WIRE 1360 592 1520 592
            BEGIN DISPLAY 1360 592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH lsbsec(1)
            WIRE 1312 528 1360 528
            WIRE 1360 528 1488 528
            BEGIN DISPLAY 1360 528 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH lsbsec(3:0)
            WIRE 1616 384 1616 464
            WIRE 1616 464 1616 528
            WIRE 1616 528 1616 592
            WIRE 1616 592 1616 656
            WIRE 1616 656 1616 720
            WIRE 1616 720 2800 720
        END BRANCH
        BUSTAP 1616 464 1520 464
        BUSTAP 1616 656 1520 656
        BEGIN BRANCH lsbsec(3)
            WIRE 1312 656 1360 656
            WIRE 1360 656 1520 656
            BEGIN DISPLAY 1360 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BUSTAP 1616 592 1520 592
        BUSTAP 2608 1536 2512 1536
        BUSTAP 2608 1472 2512 1472
        BUSTAP 2608 1408 2512 1408
        BUSTAP 2608 1344 2512 1344
        BUSTAP 1616 528 1488 528
    END SHEET
END SCHEMATIC
