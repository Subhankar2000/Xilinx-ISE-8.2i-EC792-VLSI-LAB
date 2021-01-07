
module top(maintenance_alarm,  //Signal indicating that the maintenance alarm has been triggered.     
           exp_floor_disp,     //14 bit signal use to indicate the current floor of the express elevator on two 7-seg LED displays.
           exp_move_up,        //Signal asserted when Express Car is moving up
           exp_move_down,      //Signal asserted when Express Car is moving down 
           main_floor_disp,    //14 bit signal use to indicate the current floor of the main elevator on two 7-seg LED displays.
           main_move_up,       //Signal asserted when main Car is moving up
	        main_move_down,     //Signal asserted when main Car is moving down 
           data_enable,        //Controls reading of Maintenance log by elevator maintenance worker
           write_enable,       //Controls writing to Maintenance log by elevator maintenance worker
           maint_data,         //9 bit signal indicating a request from one of the nine floors to have the elevator come to that floor to pick up a passenger
           main_external_requests, //8 bit signal for data input and extraction from maintenance log. 
	        exp_request_up,      //Outside request to go up in the Express car
           exp_request_down,    //Outside request to go down in the Express car.
           main_sensor_trip,    //Trip signal indicating that the Elevator is "stuck", issued by passenger inside main car
           main_internal_requests,  //9 bit signal indicating requested floor from inside the main elevator car
           main_temp,           //8 bit signal representing the temperature in the main car
           exp_update_enable,   //enables updating or changing the security code for the express car
	        exp_input_code,      //14 bit signal this is the security code that must be entered in the express car to access the 10th floor
           exp_temp,            //8 bit signal representing the temperature in the express car
           reset,               //Sets the Elevator cars to a know position/status representing the power-on state of the Elevator.
           clk);                // System clock for the Elevator design.

//define the ports of the top level design
output maintenance_alarm;                       
output [13:0] exp_floor_disp;
output exp_move_up, exp_move_down;
output [13:0] main_floor_disp;
output main_move_up, main_move_down;

input data_enable, write_enable;
input [8:0] main_external_requests;
input exp_request_up, exp_request_down;
input main_sensor_trip;
input [8:0] main_internal_requests;
input [7:0] main_temp;
input exp_update_enable;
input [13:0] exp_input_code;
input [7:0] exp_temp;
input reset, clk;


inout [7:0] maint_data;

//setup the master clock on a global buffer

wire gclk;
BUFG globalbuffer(.O(gclk), .I(clk));

//declare the signals going from the controller to the main car

wire [3:0] c2m_main_car_destination, c2m_main_current_floor;

//declare the signals going from the controller to the express car

wire [3:0] c2e_exp_current_floor;
wire c2e_exp_car_destination, c2e_check_permission;

//declare the signals going from the main car to the controller

wire [8:0] m2c_main_internal_requests;
wire m2c_main_stuck, m2c_main_maintenance;

//declare the signals going from the express car to the controller

wire e2c_exp_maintenance, e2c_secure, e2c_reject;

//setup the bidirectional port
wire [7:0] maint_data_out;
reg [7:0] maint_data_in;

// Code for bidirectional port
// Input IOB FF
always @ (posedge gclk) begin
	if (reset)
		maint_data_in = 8'd0;
	else
		maint_data_in = maint_data;
end 

// IOB Tri-state
assign maint_data = data_enable ? 8'bz : maint_data_out;

//instantiate the modules

controller Control_Module(	.main_car_destination(c2m_main_car_destination),
				.express_car_destination(c2e_exp_car_destination),
				.check_permission(c2e_check_permission),
				.maintenance_alarm(maintenance_alarm),
				.current_floor(c2m_main_current_floor),
				.express_floor(c2e_exp_current_floor),
				.internal_requests(m2c_main_internal_requests),
				.main_maintenance(m2c_main_maintenance),
				.express_maintenance(e2c_exp_maintenance),
				.secure(e2c_secure),
				.reject(e2c_reject),
				.external_requests(main_external_requests),
				.express_up(exp_request_up),
				.express_down(exp_request_down),
				.stuck(m2c_main_stuck),
				.reset(reset),
				.clk(gclk));

elevator_car Main_Car(	.stuck(m2c_main_stuck),
			.main_requests(m2c_main_internal_requests),
			.maintenance_request(m2c_main_maintenance),
			.floor_display(main_floor_disp),
			.move_up(main_move_up),
			.move_down(main_move_down),
			.floor(c2m_main_current_floor),
			.sensor_trip(main_sensor_trip),
			.internal_requests(main_internal_requests),
			.destination(c2m_main_car_destination),
			.temperature(main_temp),
			.reset(reset),
			.clk(gclk));

express_car Express_Car(	.maintenance_request(e2c_exp_maintenance),
				.secure(e2c_secure),
				.reject(e2c_reject),
				.floor(c2e_exp_current_floor),
				.move_up(exp_move_up),
				.move_down(exp_move_down),
				.floor_display(exp_floor_disp),
				.destination(c2e_exp_car_destination),
				.temperature(exp_temp),
				.input_code(exp_input_code),
				.update_enable(exp_update_enable),
				.check_permission(c2e_check_permission),
				.reset(reset),
				.clk(gclk));
							
tracking Tracking_Module(	.maint_data_out(maint_data_out),
				.maint_data_in(maint_data_in),
				.data_enable(data_enable),
				.write_enable(write_enable),
				.reset(reset),
				.clk(gclk));

endmodule


