//setup the definitions for the design

`define s0 4'd0		//reset (power on state)
`define s1 4'd1		//floor one
`define s2 4'd2		//floor two
`define s3 4'd3		//floor three
`define s4 4'd4		//floor four
`define s5 4'd5		//floor five
`define s6 4'd6		//floor six
`define s7 4'd7		//floor seven
`define s8 4'd8		//floor eight
`define s9 4'd9		//floor nine

`define exp_s0 2'd0		//express reset (power on state)
`define exp_s1 2'd1		//express floor one
`define exp_s2 2'd2		//security check
`define exp_s3 2'd3		//express floor two


module controller(main_car_destination,    //floor that main car is headed to 
                  express_car_destination, //floor that express car is headed to 
                  check_permission,        //asserted when the security code needs to be checked
                  maintenance_alarm,       //alarm indicating the elevator is stuck or too hot or cold
                  current_floor,           //current floor of the main elevator
                  express_floor,           //current floor of the express elevator
                  internal_requests,       //floor request by passenger in main elevator
                  main_maintenance,        //request for maintenance in main car, to hot or cold
                  express_maintenance,     //request for maintenance in express car, to hot or cold
                  secure,                  //correct security code was entered to access 10th floor in express car
                  reject,                  //incorrect security code was entered to access 10th floor in express car 
                  external_requests,       //floor request by passenger waiting for main elevator
                  express_up,              //request for the express elevator to go up
                  express_down,            //request for the express elevator to go down
                  stuck,                   //indicated that there is a person stuck in one of the elevators
                  reset,                   //reset returns the elevator to its power up state
                  clk);                    //system clock

output [3:0] main_car_destination, current_floor, express_floor;
output check_permission, maintenance_alarm, express_car_destination;

input [8:0] internal_requests, external_requests;
input main_maintenance, express_maintenance,  secure, reject, express_up, express_down, stuck, reset, clk;

reg [3:0] main_car_destination, current_floor, express_floor;
reg check_permission, maintenance_alarm, express_car_destination;

//internal signals for the design

wire [8:0] active_requests;
reg [8:0] adjusted_internal_requests, adjusted_external_requests;
reg [3:0] current_state, next_state, previous_state;
reg [1:0] exp_state, next_exp_state;
wire maintenance_request;

/*setup the main_car_destination - The main car destination is controlled by a 
simple state machine which cycles through the floors of the building based on 
the requests of the people inside and outside the elevator. This state machine 
also controls the current_floor output signal.*/

	//define the active requests

	always@(posedge clk) begin

	if (reset) begin
		adjusted_internal_requests = 0;
		adjusted_external_requests = 0;
		end

	else begin
		case (current_floor)
			4'b0001 : begin
				adjusted_internal_requests = internal_requests & 9'b111111110;
				adjusted_external_requests = external_requests & 9'b111111110;
				end
			4'b0010 : begin
				adjusted_internal_requests = internal_requests & 9'b111111101;
				adjusted_external_requests = external_requests & 9'b111111101;
				end
			4'b0011 : begin
				adjusted_internal_requests = internal_requests & 9'b111111011;
				adjusted_external_requests = external_requests & 9'b111111011;
				end
			4'b0100 : begin
				adjusted_internal_requests = internal_requests & 9'b111110111;
				adjusted_external_requests = external_requests & 9'b111110111;
				end
			4'b0101 : begin
				adjusted_internal_requests = internal_requests & 9'b111101111;
				adjusted_external_requests = external_requests & 9'b111101111;
				end
			4'b0110 : begin
				adjusted_internal_requests = internal_requests & 9'b111011111;
				adjusted_external_requests = external_requests & 9'b111011111;
				end
			4'b0111 : begin
				adjusted_internal_requests = internal_requests & 9'b110111111;
				adjusted_external_requests = external_requests & 9'b110111111;
				end
			4'b1000 : begin
				adjusted_internal_requests = internal_requests & 9'b101111111;
				adjusted_external_requests = external_requests & 9'b101111111;
				end
			4'b1001 : begin
				adjusted_internal_requests = internal_requests & 9'b011111111;
				adjusted_external_requests = external_requests & 9'b011111111;
				end

			endcase
		end

	end
	assign active_requests = adjusted_internal_requests | adjusted_external_requests;

	//define the state memory
	always @ (posedge clk) begin
		previous_state = current_state;
		current_state = next_state;
	end

	//define the next_state logic
	always @ (current_state or reset or active_requests or previous_state) begin

		if (reset) next_state = `s0;
		else begin
			case (current_state)
				`s0 : next_state = `s1;

				`s1 : begin
					if (|active_requests[8:1]) next_state = `s2;
					else next_state = `s1;
					end

				`s2 : begin
				
					if ((previous_state == `s1) && (|active_requests[8:2])) next_state = `s3;			
					else if ((previous_state == `s1) && (~|active_requests[8:2]) && (active_requests[0])) next_state = `s1;
					else if ((previous_state == `s3) && (active_requests[0])) next_state = `s1;
 				    else if ((previous_state == `s3) && (~active_requests[0]) && (|active_requests[8:2])) next_state = `s3;
					else if ((previous_state == `s2) && (|active_requests[8:2])) next_state = `s3;
					else if ((previous_state == `s2) && (active_requests[0])) next_state = `s1;
					else next_state = `s2;
					end

				`s3 : begin
					if ((previous_state == `s2) && (|active_requests[8:3])) next_state = `s4;
					else if ((previous_state == `s2) && (~|active_requests[8:3]) && (|active_requests[1:0])) next_state = `s2;
					else if ((previous_state == `s4) && (|active_requests[1:0])) next_state = `s2;
 				    else if ((previous_state == `s4) && (~|active_requests[1:0]) && (|active_requests[8:3])) next_state = `s4;
					else if ((previous_state == `s3) && (|active_requests[8:3])) next_state = `s4;
					else if ((previous_state == `s3) && (active_requests[1:0])) next_state = `s2;
					else next_state = `s3;
					end

				`s4 : begin
					if ((previous_state == `s3) && (|active_requests[8:4])) next_state = `s5;
					else if ((previous_state == `s3) && (~|active_requests[8:4]) && (|active_requests[2:0])) next_state = `s3;
					else if ((previous_state == `s5) && (|active_requests[2:0])) next_state = `s3;
 				    else if ((previous_state == `s5) && (~|active_requests[2:0]) && (|active_requests[8:4])) next_state = `s5;
					else if ((previous_state == `s4) && (|active_requests[8:4])) next_state = `s5;
					else if ((previous_state == `s4) && (active_requests[2:0])) next_state = `s3;
					else next_state = `s4;
					end

				`s5 : begin
					if ((previous_state == `s4) && (|active_requests[8:5])) next_state = `s6;
					else if ((previous_state == `s4) && (~|active_requests[8:5]) && (|active_requests[3:0])) next_state = `s4;
					else if ((previous_state == `s6) && (|active_requests[3:0])) next_state = `s4;
 				    else if ((previous_state == `s6) && (~|active_requests[3:0]) && (|active_requests[8:5])) next_state = `s6;
					else if ((previous_state == `s5) && (|active_requests[8:5])) next_state = `s6;
					else if ((previous_state == `s5) && (active_requests[3:0])) next_state = `s4;
					else next_state = `s5;
					end

				`s6 : begin
					if ((previous_state == `s5) && (|active_requests[8:6])) next_state = `s7;
					else if ((previous_state == `s5) && (~|active_requests[8:6]) && (|active_requests[4:0])) next_state = `s5;
					else if ((previous_state == `s7) && (|active_requests[4:0])) next_state = `s5;
 				    else if ((previous_state == `s7) && (~|active_requests[4:0]) && (|active_requests[8:6])) next_state = `s7;
					else if ((previous_state == `s6) && (|active_requests[8:6])) next_state = `s7;
					else if ((previous_state == `s6) && (active_requests[4:0])) next_state = `s5;
					else next_state = `s6;
					end

				`s7 : begin
					if ((previous_state == `s6) && (|active_requests[8:7])) next_state = `s8;
					else if ((previous_state == `s6) && (~|active_requests[8:7]) && (|active_requests[5:0])) next_state = `s6;
					else if ((previous_state == `s8) && (|active_requests[5:0])) next_state = `s6;
 				    else if ((previous_state == `s8) && (~|active_requests[5:0]) && (|active_requests[8:7])) next_state = `s8;
					else if ((previous_state == `s7) && (|active_requests[8:7])) next_state = `s8;
					else if ((previous_state == `s7) && (active_requests[5:0])) next_state = `s6;
					else next_state = `s7;
					end

				`s8 : begin
					if ((previous_state == `s7) && (active_requests[8])) next_state = `s9;
					else if ((previous_state == `s7) && (~active_requests[8]) && (|active_requests[6:0])) next_state = `s7;
					else if ((previous_state == `s9) && (|active_requests[6:0])) next_state = `s7;
 				    else if ((previous_state == `s9) && (~|active_requests[6:0]) && (active_requests[8])) next_state = `s9;
					else if ((previous_state == `s8) && (|active_requests[8])) next_state = `s9;
					else if ((previous_state == `s8) && (active_requests[6:0])) next_state = `s7;
					else next_state = `s8;
					end

				`s9 : begin
					if (|active_requests[7:0]) next_state = `s8;
					else next_state = `s9;
					end

				 default : next_state = `s0;

			endcase
		end
	end

	
	//define the output logic
	always @ (current_state or previous_state) begin

		main_car_destination = current_state;
		current_floor = previous_state;

	end

/*setup the express_car_destination - The express car destination is controlled 
with a simple state machine and is based on the requests of the people wanting 
to access the tenth floor and the security code for this floor.*/

	//define the state memory
	always @ (posedge clk) begin
		exp_state <= next_exp_state;
		end

	//define the next state logic
	always @ (exp_state or secure or reject or express_up or express_down or reset) begin

		if (reset) next_exp_state = `exp_s0;
		else begin

			case (exp_state)

				`exp_s0 : next_exp_state = `exp_s1;

				`exp_s1 : begin
					if (express_up) next_exp_state = `exp_s2;
					else if (express_down) next_exp_state = `exp_s3;
					else next_exp_state = `exp_s1;
					end

				`exp_s2 : begin
					if (secure) next_exp_state = `exp_s3;  //changed from exp_s1
               else if (reject) next_exp_state = `exp_s1;       //changed from exp_s3
					else next_exp_state = `exp_s2;
					end

				`exp_s3 : next_exp_state = `exp_s1;

			endcase
		end
	end

	//define the output logic
	always @ (exp_state or express_down or secure or reset) begin

		if (reset) begin
			express_car_destination = 0;
			check_permission = 0;
			express_floor = 4'b0000;
			end

		else begin
			
			case (exp_state)

				`exp_s0 : begin
					express_car_destination = 0;
					check_permission = 0;
					express_floor = 4'b0001;
					end

				`exp_s1 : begin
					check_permission = 0;
					express_floor = 4'b0001;
					if (express_down) express_car_destination = 1;
					else express_car_destination = 0;
					end

				`exp_s2 : begin
					check_permission = 1;
					express_floor = 4'b0001;
					if (secure) 
                  express_car_destination = 1;
					else express_car_destination = 0;
					end

				`exp_s3 : begin
					express_car_destination = 1;
					check_permission = 0;
					express_floor = 4'b1010;  //changed from 2 to 10
					end
			endcase
		end
	end
							

/*setup the maintenance alarm functionality - The maintenance alarm will be 
activated if the temperature of the car is too high or too low.  The maintenance 
alarm will also be activated if the elevator is stuck between floors)*/

assign maintenance_request = express_maintenance || main_maintenance;

always@(posedge clk) begin

	if (reset) begin
		maintenance_alarm = 0;
		end

	else if (maintenance_request || stuck) begin
		maintenance_alarm = 1;
		end

	else maintenance_alarm = 0;

	end


endmodule







