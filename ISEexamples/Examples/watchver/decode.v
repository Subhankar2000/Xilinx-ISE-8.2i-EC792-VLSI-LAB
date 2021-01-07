module decode (ONE_HOT, BINARY);
	input  [3:0] BINARY;
	output [9:0] ONE_HOT;

	reg [9:0] ONE_HOT;

always@(BINARY)
	case (BINARY)
				4'b0001 : ONE_HOT	= 10'b0000000001; 	// 1
				4'b0010 : ONE_HOT	= 10'b0000000010; 	// 2
				4'b0011 : ONE_HOT	= 10'b0000000100; 	// 3
				4'b0100 : ONE_HOT	= 10'b0000001000; 	// 4
				4'b0101 : ONE_HOT	= 10'b0000010000; 	// 5
				4'b0110 : ONE_HOT	= 10'b0000100000; 	// 6
				4'b0111 : ONE_HOT	= 10'b0001000000; 	// 7
				4'b1000 : ONE_HOT	= 10'b0010000000; 	// 8
				4'b1001 : ONE_HOT	= 10'b0100000000;    // 9
				4'b1010 : ONE_HOT	= 10'b1000000000; 	// 10
				default:	ONE_HOT = 10'b0000000001; 	// 1
	endcase
 
endmodule