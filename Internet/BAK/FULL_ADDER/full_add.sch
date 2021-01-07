VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL Ain
        SIGNAL Bin
        SIGNAL XLXN_6
        SIGNAL XLXN_7
        SIGNAL Cin
        SIGNAL XLXN_9
        SIGNAL XLXN_12
        SIGNAL XLXN_13
        SIGNAL XLXN_14
        SIGNAL XLXN_15
        SIGNAL XLXN_16
        SIGNAL SUM
        SIGNAL CARRY
        PORT Input Ain
        PORT Input Bin
        PORT Input Cin
        PORT Output SUM
        PORT Output CARRY
        BEGIN BLOCKDEF xor2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 60 -128 
            LINE N 256 -96 208 -96 
            ARC N -40 -152 72 -40 48 -48 44 -144 
            ARC N -24 -152 88 -40 64 -48 64 -144 
            LINE N 128 -144 64 -144 
            LINE N 128 -48 64 -48 
            ARC N 44 -144 220 32 208 -96 128 -144 
            ARC N 44 -224 220 -48 128 -48 208 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
        END BLOCKDEF
        BEGIN BLOCKDEF or2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 28 -224 204 -48 112 -48 192 -96 
            ARC N -40 -152 72 -40 48 -48 48 -144 
            LINE N 112 -144 48 -144 
            ARC N 28 -144 204 32 192 -96 112 -144 
            LINE N 112 -48 48 -48 
        END BLOCKDEF
        BEGIN BLOCK XLXI_8 xor2
            PIN I0 Bin
            PIN I1 Ain
            PIN O XLXN_7
        END BLOCK
        BEGIN BLOCK XLXI_11 xor2
            PIN I0 XLXN_7
            PIN I1 Cin
            PIN O SUM
        END BLOCK
        BEGIN BLOCK XLXI_12 and2
            PIN I0 XLXN_7
            PIN I1 Cin
            PIN O XLXN_13
        END BLOCK
        BEGIN BLOCK XLXI_13 and2
            PIN I0 Bin
            PIN I1 Ain
            PIN O XLXN_14
        END BLOCK
        BEGIN BLOCK XLXI_14 or2
            PIN I0 XLXN_14
            PIN I1 XLXN_13
            PIN O CARRY
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_8 1328 1376 R0
        BEGIN BRANCH Ain
            WIRE 944 1248 1264 1248
            WIRE 1264 1248 1312 1248
            WIRE 1312 1248 1328 1248
            WIRE 1312 1248 1312 1472
            WIRE 1312 1472 1744 1472
        END BRANCH
        BEGIN BRANCH Bin
            WIRE 1088 1312 1264 1312
            WIRE 1264 1312 1328 1312
            WIRE 1264 1312 1264 1536
            WIRE 1264 1536 1744 1536
        END BRANCH
        IOMARKER 944 1248 Ain R180 28
        IOMARKER 1088 1312 Bin R180 28
        INSTANCE XLXI_11 1728 1152 R0
        INSTANCE XLXI_12 1744 1408 R0
        INSTANCE XLXI_13 1744 1600 R0
        INSTANCE XLXI_14 2128 1504 R0
        BEGIN BRANCH XLXN_7
            WIRE 1584 1280 1664 1280
            WIRE 1664 1280 1664 1344
            WIRE 1664 1344 1744 1344
            WIRE 1664 1088 1728 1088
            WIRE 1664 1088 1664 1200
            WIRE 1664 1200 1664 1216
            WIRE 1664 1216 1664 1280
        END BRANCH
        IOMARKER 1216 1024 Cin R180 28
        BEGIN BRANCH Cin
            WIRE 1216 1024 1712 1024
            WIRE 1712 1024 1728 1024
            WIRE 1712 1024 1712 1280
            WIRE 1712 1280 1744 1280
        END BRANCH
        BEGIN BRANCH XLXN_13
            WIRE 2000 1312 2096 1312
            WIRE 2096 1312 2096 1376
            WIRE 2096 1376 2128 1376
        END BRANCH
        BEGIN BRANCH XLXN_14
            WIRE 2000 1504 2096 1504
            WIRE 2096 1440 2096 1504
            WIRE 2096 1440 2128 1440
        END BRANCH
        BEGIN BRANCH SUM
            WIRE 1984 1056 2016 1056
        END BRANCH
        IOMARKER 2016 1056 SUM R0 28
        BEGIN BRANCH CARRY
            WIRE 2384 1408 2416 1408
        END BRANCH
        IOMARKER 2416 1408 CARRY R0 28
    END SHEET
END SCHEMATIC
