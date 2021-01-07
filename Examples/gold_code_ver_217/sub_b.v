module sub_b (Clock, Enable, Fill_En_B, New_Fill_B, delayB0 );

parameter cycleB0=26;
parameter cycleB20=21;
parameter width=1;

input Clock;
input Enable;
input Fill_En_B;
input New_Fill_B;

output [0:width-1] delayB0;

wire [0:width-1] Data_In_B;
wire [0:width-1] delayB20;
wire [0:width-1] delayB0;

reg [0:width-1] shiftB0 [cycleB0-1:0];
reg [0:width-1] shiftB20 [cycleB20-1:0];

integer k,l;

assign Data_In_B = Fill_En_B ? New_Fill_B : (delayB20 ^ delayB0);

always @ (posedge Clock)begin  
	if (Enable == 1) begin    
		for (k=cycleB0-1; k>0; k=k-1)
	      	shiftB0[k] = shiftB0 [k-1];      
			shiftB0[0] = Data_In_B;	
		for (l=cycleB20-1; l>0; l=l-1)      
			shiftB20[l] = shiftB20 [l-1];  	   
			shiftB20[0] = Data_In_B;  
	end
end

assign delayB20 = shiftB20[cycleB20-1];
assign delayB0 = shiftB0[cycleB0-1];

endmodule