module tracking(maint_data_out,   //reads out stored maintenance data 
                maint_data_in,    //write in maintenance data
                data_enable,      //enables reading of data
                write_enable,     //enables writing of data
                clk,              //system clock
                reset);           //starts the memory log over

output [7:0] maint_data_out;

input [7:0] maint_data_in;
input data_enable, write_enable, clk, reset;

//declare the internal signals
reg [10:0] address;

always @ (posedge clk or posedge reset) begin

	if (reset)
		address = 9'd0;
	else begin
		if (data_enable == 1) begin
			if (write_enable == 1)
				address = address + 1;
		end
	end
end


//instantiate the  RAM
RAMB16_S9 maint_tracking  (
	.ADDR(address),
	.CLK(clk),
	.DI(maint_data_in),
	.DIP(1'b0),
	.WE(write_enable),
	.EN(data_enable),
	.SSR(reset),
	.DO(maint_data_out),
   .DOP());

endmodule

