module express_car(maintenance_request, //request for maintenance car is to hot or cold
                   secure,              //the security code as been excepted 
                   reject,              //the security code has been rejected
                   floor,               //current floor of the elevator car
                   move_up,             //asserted when the elevator is moving up
                   move_down,           //asserted when the elevator is moving down
                   floor_display,       //current floor of that the elevator is on in code for 2 7-seg displays
                   destination,         //destination floor of the elevator car
                   temperature,         //temperature inside the elevator car
                   input_code,          //security code for accessing 10th floor 
                   update_enable,       //enables updating or changing the security code 
                   check_permission,    //asserted when the security code needs to be checked
                   reset,               //sets the elevator car to a know position/status representing the power-on state of the Elevator.
                   clk);                //elevator system clock

output [13:0] floor_display;
output maintenance_request, secure, reject;
output move_up, move_down;

input [13:0] input_code;
input [7:0] temperature;
input [3:0] floor;
input destination, update_enable, check_permission, reset, clk;

reg maintenance_request, secure, reject;
reg [13:0] floor_display;
reg move_up, move_down;

//internal signal

reg [13:0] master_code;

// synthesis attribute keep of floor_display is true; 

//setup the maintenance_request function

always@(posedge clk) begin

	if (reset) begin
		maintenance_request = 0;
		end

	else if (temperature >= 85 || temperature <= 55) begin
		maintenance_request = 1;
		end

	else begin
		maintenance_request = 0;
		end
	
    end

//setup the security functions

always@(posedge clk) begin

	if (reset) begin
		secure = 0;
		reject = 0;
		master_code = 0;
		end

	else if (update_enable) begin
		master_code = input_code;
		end

	else if (check_permission) begin
		
		if(input_code == master_code) begin
			secure = 1;
			reject = 0;
			end
		else begin
			secure = 0;
			reject = 1;
			end
		end

	else begin
		secure = 0;
		reject = 0;
		end

	end

//setup the car movement functions

always@(posedge clk) begin
	
	if (reset) begin
		move_up = 0;
		move_down = 0;
		end

   else if ((destination ==1'b1) && (floor[0] == 1'b0)) begin
		move_up = 0;
		move_down = 1;
		end

	else if   ((destination == 1'b1)&&( floor[0] == 1'b1)) begin
		move_up = 1;
		move_down = 0;
		end

	else begin
		move_up = 0;
		move_down = 0;
		end

	end

//setup the floor information

always@(posedge clk) begin
	
	if (reset) begin
		floor_display = 14'b00000000000000;
		end

	else begin
		
		case (floor)
			4'b0001 : begin
				floor_display = 14'b01111111011011;
				end
			4'b1010 : begin
				floor_display = 14'b00001100111111;
				end
			default : begin
				floor_display = 14'b00000000000000;
				end
			endcase
			
		end

     end
endmodule



