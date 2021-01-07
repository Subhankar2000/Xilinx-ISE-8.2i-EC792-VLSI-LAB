module sub_a (Clock, Enable, Fill_En_A, New_Fill_A, delayA0);

parameter cycleA0=26;
parameter cycleA3=4;
parameter width=1;

input Clock;
input Enable;
input Fill_En_A;
input New_Fill_A;

output [0:width-1] delayA0;

wire [0:width-1] Data_In_A;
wire [0:width-1] delayA3;
reg [0:width-1] shiftA0 [cycleA0-1:0];
reg [0:width-1] shiftA3 [cycleA3-1:0];
integer i,j;

assign Data_In_A = Fill_En_A ? New_Fill_A : (delayA3 ^ delayA0);
assign delayA0 = shiftA0[cycleA0-1];
assign delayA3 = shiftA3[cycleA3-1];

always @ (posedge Clock)begin  
	if (Enable == 1) begin    
		for (i=cycleA0-1; i>0; i=i-1)      
			shiftA0[i] = shiftA0 [i-1];      
			shiftA0[0] = Data_In_A;    
		for (j=cycleA3-1; j>0; j=j-1)      
			shiftA3[j] = shiftA3 [j-1];  	   
			shiftA3[0] = Data_In_A;  
	end
end

endmodule