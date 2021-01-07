module tenths(CLK_EN, CLOCK, ASYNC_CTRL, Q_OUT, TERM_CNT);
input CLK_EN;
input CLOCK;
input ASYNC_CTRL;
output [9:0] Q_OUT;
output TERM_CNT;

parameter [9:0] //synopsys enum STATE_TYPE
s0=10'b0000000001,
s1=10'b0000000010,
s2=10'b0000000100,
s3=10'b0000001000,
s4=10'b0000010000,
s5=10'b0000100000,
s6=10'b0001000000,
s7=10'b0010000000,
s8=10'b0100000000,
s9=10'b1000000000;

reg [9:0] current_state;
reg [9:0] next_state;
reg [9:0] Q_OUT;

always@(current_state)
begin
	case(current_state) //synopsys full_case parallel_case
	s0:begin
	next_state<=s1;
	Q_OUT<=10'b0000000001;
	end
	s1:begin
	next_state<=s2;
	Q_OUT<=10'b0000000010;
	end
	s2:begin
	next_state<=s3;
	Q_OUT<=10'b0000000100;
	end
	s3:begin
	next_state<=s4;
	Q_OUT<=10'b0000001000;
	end
	s4:begin
	next_state<=s5;
	Q_OUT<=10'b0000010000;
	end
	s5:begin
	next_state<=s6;
	Q_OUT<=10'b0000100000;
	end
	s6:begin
	next_state<=s7;
	Q_OUT<=10'b0001000000;
	end
	s7:begin
	next_state<=s8;
	Q_OUT<=10'b0010000000;
	end
	s8:begin
	next_state<=s9;
	Q_OUT<=10'b0100000000;
	end
	s9:begin
	next_state<=s0;
	Q_OUT<=10'b1000000000;
	end
	endcase
end

always@(posedge CLOCK or negedge CLOCK or posedge ASYNC_CTRL)
begin
	if(ASYNC_CTRL==1'b1)
	 current_state = s0;
	else
	if(CLK_EN==1'b1)
	 current_state = next_state;
end

assign TERM_CNT = (current_state == s9)?1'b1:1'b0;

endmodule






















