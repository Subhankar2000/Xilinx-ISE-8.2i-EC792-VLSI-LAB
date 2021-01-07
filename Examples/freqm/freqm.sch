VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL LED_A(6:0)
        SIGNAL LED_B(6:0)
        SIGNAL LED_C(6:0)
        SIGNAL LED_D(6:0)
        SIGNAL START
        SIGNAL RESET
        SIGNAL F_PATTERN
        SIGNAL F_INPUT
        SIGNAL GATE
        SIGNAL END_RESET
        SIGNAL FULL
        SIGNAL BCD_U(3:0)
        SIGNAL BCD_D(3:0)
        SIGNAL BCD_H(3:0)
        SIGNAL BCD_T(3:0)
        PORT Output LED_A(6:0)
        PORT Output LED_B(6:0)
        PORT Output LED_C(6:0)
        PORT Output LED_D(6:0)
        PORT Input START
        PORT Input RESET
        PORT Input F_PATTERN
        PORT Input F_INPUT
        PORT Output FULL
        BEGIN BLOCKDEF hex2led
            TIMESTAMP 2003 3 13 21 7 26
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF cnt_bcd
            TIMESTAMP 2003 3 13 21 7 26
            LINE N 384 48 416 48 
            LINE N 384 80 416 80 
            LINE N 384 112 416 112 
            LINE N 384 144 416 144 
            LINE N 384 176 416 176 
            BEGIN RECTANGLE W 32 0 384 224 
            END RECTANGLE
            LINE N 0 144 32 144 
            LINE N 0 112 32 112 
            LINE N 0 80 32 80 
        END BLOCKDEF
        BEGIN BLOCKDEF control
            TIMESTAMP 2003 3 13 21 7 26
            LINE N 448 96 480 96 
            LINE N 448 64 480 64 
            LINE N 0 112 32 112 
            LINE N 0 80 32 80 
            LINE N 0 48 32 48 
            BEGIN RECTANGLE W 32 0 448 160 
            END RECTANGLE
        END BLOCKDEF
        BEGIN BLOCK I1 hex2led
            PIN HEX(3:0) BCD_T(3:0)
            PIN LED(6:0) LED_D(6:0)
        END BLOCK
        BEGIN BLOCK I2 hex2led
            PIN HEX(3:0) BCD_H(3:0)
            PIN LED(6:0) LED_C(6:0)
        END BLOCK
        BEGIN BLOCK I3 hex2led
            PIN HEX(3:0) BCD_D(3:0)
            PIN LED(6:0) LED_B(6:0)
        END BLOCK
        BEGIN BLOCK I4 hex2led
            PIN HEX(3:0) BCD_U(3:0)
            PIN LED(6:0) LED_A(6:0)
        END BLOCK
        BEGIN BLOCK I5 cnt_bcd
            PIN CLK F_INPUT
            PIN ENABLE GATE
            PIN RESET END_RESET
            PIN BCD_D(3:0) BCD_D(3:0)
            PIN BCD_H(3:0) BCD_H(3:0)
            PIN BCD_T(3:0) BCD_T(3:0)
            PIN BCD_U(3:0) BCD_U(3:0)
            PIN FULL FULL
        END BLOCK
        BEGIN BLOCK I6 control
            PIN CLK F_PATTERN
            PIN RESET RESET
            PIN START START
            PIN END_MEASURE END_RESET
            PIN GATE GATE
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE I5 1504 1088 R0
        END INSTANCE
        BEGIN INSTANCE I6 736 1136 R0
        END INSTANCE
        BEGIN BRANCH LED_A(6:0)
            WIRE 2800 848 2832 848
            WIRE 2832 848 3024 848
        END BRANCH
        IOMARKER 3024 848 LED_A(6:0) R0 28
        BEGIN BRANCH LED_B(6:0)
            WIRE 2800 1072 2848 1072
            WIRE 2848 1072 3024 1072
        END BRANCH
        IOMARKER 3024 1072 LED_B(6:0) R0 28
        BEGIN BRANCH LED_C(6:0)
            WIRE 2800 1264 2848 1264
            WIRE 2848 1264 3024 1264
        END BRANCH
        IOMARKER 3024 1264 LED_C(6:0) R0 28
        BEGIN BRANCH LED_D(6:0)
            WIRE 2784 1472 2864 1472
            WIRE 2864 1472 3024 1472
        END BRANCH
        IOMARKER 3024 1472 LED_D(6:0) R0 28
        BEGIN BRANCH START
            WIRE 464 1248 736 1248
        END BRANCH
        IOMARKER 464 1248 START R180 28
        BEGIN BRANCH RESET
            WIRE 464 1216 736 1216
        END BRANCH
        IOMARKER 464 1216 RESET R180 28
        BEGIN BRANCH F_PATTERN
            WIRE 464 1184 736 1184
        END BRANCH
        IOMARKER 464 1184 F_PATTERN R180 28
        BEGIN BRANCH F_INPUT
            WIRE 464 1040 1376 1040
            WIRE 1376 1040 1376 1168
            WIRE 1376 1168 1504 1168
        END BRANCH
        IOMARKER 464 1040 F_INPUT R180 28
        BEGIN BRANCH GATE
            WIRE 1216 1232 1344 1232
            WIRE 1344 1232 1504 1232
            BEGIN DISPLAY 1344 1232 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH END_RESET
            WIRE 1216 1200 1296 1200
            WIRE 1296 1200 1504 1200
            BEGIN DISPLAY 1296 1200 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH FULL
            WIRE 1920 1136 1968 1136
            WIRE 1968 688 1968 1136
            WIRE 1968 688 2880 688
        END BRANCH
        IOMARKER 2880 688 FULL R0 28
        BEGIN BRANCH BCD_U(3:0)
            WIRE 1920 1168 2080 1168
            WIRE 2080 848 2080 1168
            WIRE 2080 848 2208 848
            WIRE 2208 848 2368 848
            WIRE 2368 848 2416 848
            BEGIN DISPLAY 2208 848 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH BCD_D(3:0)
            WIRE 1920 1200 2160 1200
            WIRE 2160 1072 2160 1200
            WIRE 2160 1072 2240 1072
            WIRE 2240 1072 2368 1072
            WIRE 2368 1072 2416 1072
            BEGIN DISPLAY 2240 1072 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH BCD_H(3:0)
            WIRE 1920 1232 2080 1232
            WIRE 2080 1232 2080 1264
            WIRE 2080 1264 2240 1264
            WIRE 2240 1264 2368 1264
            WIRE 2368 1264 2416 1264
            BEGIN DISPLAY 2240 1264 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH BCD_T(3:0)
            WIRE 1920 1264 1968 1264
            WIRE 1968 1264 1968 1472
            WIRE 1968 1472 2128 1472
            WIRE 2128 1472 2368 1472
            WIRE 2368 1472 2400 1472
            BEGIN DISPLAY 2128 1472 ATTR Name
                ALIGNMENT BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE I1 2400 1504 R0
        END INSTANCE
        BEGIN INSTANCE I2 2416 1296 R0
        END INSTANCE
        BEGIN INSTANCE I3 2416 1104 R0
        END INSTANCE
        BEGIN INSTANCE I4 2416 880 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
