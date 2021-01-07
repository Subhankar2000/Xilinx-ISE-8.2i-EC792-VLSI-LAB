module gold_code (Clock, Enable, Fill_En_A, Fill_En_B, New_Fill_A, New_Fill_B, Gold_Code);

input Clock;
input Enable;
input Fill_En_A;
input New_Fill_A;
input New_Fill_B;
input Fill_En_B;

output Gold_Code;

wire tapA0;
wire tapB0;

sub_a first_lfsr (.Clock(Clock), .Enable(Enable), .Fill_En_A(Fill_En_A), .New_Fill_A(New_Fill_A),
		.delayA0(tapA0));

sub_b second_lfsr (.Clock(Clock), .Enable(Enable), .Fill_En_B(Fill_En_B), .New_Fill_B(New_Fill_B),
		.delayB0(tapB0));

assign Gold_Code = tapA0 ^ tapB0;

endmodule
