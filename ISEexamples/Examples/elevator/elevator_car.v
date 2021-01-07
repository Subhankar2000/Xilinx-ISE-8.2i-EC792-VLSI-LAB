module elevator_car(stuck,         //passenger has hit button indicating they are stuck
                    main_requests, //floor request by passenger in elevator
                    maintenance_request, //request for maintenance car is to hot or cold
                    floor_display, //signal for the current floor of the main elevator to be displayed on two 7-seg LED displays.
                    move_up,       //asserted when car is moving up
                    move_down,     //asserted when car is moving down
                    floor,         //current floor that the elevator is on
                    sensor_trip,   //passenger has hit button indicating they are stuck
                    internal_requests,  //requested floor from passenger inside elevator
                    destination,    //destination floor of the elevator car
                    temperature,   //temperature inside elevator car
                    reset,         //sets the elevator car to a know position/status representing the power-on state of the Elevator.
                    clk);          //elevator system clock

output [8:0] main_requests;
output maintenance_request;
output [13:0] floor_display;
output move_up, move_down, stuck;

input [8:0] internal_requests;
input [3:0] destination, floor;
input [7:0] temperature;
input sensor_trip, reset, clk;

wire [8:0] main_requests;
reg maintenance_request;
reg [13:0] floor_display;
reg move_up, move_down;
wire stuck;

//pass the internal_requests to the main requests port
assign main_requests = internal_requests;

//pass the "stuck" information out
assign stuck = sensor_trip;

//setup the maintenance_request and emergency functions
always@(posedge clk) begin

	if(reset)begin
		maintenance_request = 0;
		end

	else if (temperature >= 85 || temperature <= 55) begin
		maintenance_request = 1;
		end

	else begin
		maintenance_request = 0;
		end
	
    end

//setup the car movement functions

always@(posedge clk) begin
	
	if (reset) begin
		move_up = 0;
		move_down = 0;
		end

	else if (destination == floor) begin
		move_up = 0;
		move_down = 0;
		end

	else if (destination > floor) begin
		move_up = 1;
		move_down = 0;
		end

	else begin
		move_up = 0;
		move_down = 1;
		end

	end

//setup the floor information

always@(posedge clk) begin
	
	if (reset) begin
		floor_display = 0;
		end

	else begin
		
		case (floor)
			4'b0001 : begin
				floor_display = 14'b01111110000110;
				end
			4'b0010 : begin
				floor_display = 14'b01111111011011;
				end
			4'b0011 : begin
				floor_display = 14'b01111111001111;
				end
			4'b0100 : begin
				floor_display = 14'b01111111100110;
				end
			4'b0101 : begin
				floor_display = 14'b01111111100110;
				end
			4'b0110 : begin
				floor_display = 14'b01111111111101;
				end
			4'b0111 : begin
				floor_display = 14'b01111110000111;
				end
			4'b1000 : begin
				floor_display = 14'b01111111111111;
				end
			4'b1001 : begin
				floor_display = 14'b01111111101111;
				end
			4'b1010 : begin
				floor_display = 14'b00001100111111;
				end

			endcase
			
		end

	end

endmodule

