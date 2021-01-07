`timescale 1ns/1ps

module top_tb();

//Toplevel testbench for the Elevator Project.  It simulates riding up and down
//in the main elevator car, setting the express elevator car security code and
//riding up and down in the express elevator car  


// Inputs
    reg data_enable;
    reg write_enable;
    reg [8:0] main_external_requests;
    reg exp_request_up;
    reg exp_request_down;
    reg main_sensor_trip;
    reg [8:0] main_internal_requests;
    reg [7:0] main_temp;
    reg exp_update_enable;
    reg [13:0] exp_input_code;
    reg [7:0] exp_temp;
    reg reset;
    reg clk;


// Outputs
    wire maintenance_alarm;
    wire [13:0] exp_floor_disp;
    wire exp_move_up;
    wire exp_move_down;
    wire [13:0] main_floor_disp;
    wire main_move_up;
    wire main_move_down;


// Bidirs
    wire [7:0] maint_data;


// Instantiate the UUT
    top uut (
        .maintenance_alarm(maintenance_alarm), 
        .exp_floor_disp(exp_floor_disp), 
        .exp_move_up(exp_move_up), 
        .exp_move_down(exp_move_down), 
        .main_floor_disp(main_floor_disp), 
        .main_move_up(main_move_up), 
        .main_move_down(main_move_down), 
        .data_enable(data_enable), 
        .write_enable(write_enable), 
        .maint_data(maint_data), 
        .main_external_requests(main_external_requests), 
        .exp_request_up(exp_request_up), 
        .exp_request_down(exp_request_down), 
        .main_sensor_trip(main_sensor_trip), 
        .main_internal_requests(main_internal_requests), 
        .main_temp(main_temp), 
        .exp_update_enable(exp_update_enable), 
        .exp_input_code(exp_input_code), 
        .exp_temp(exp_temp), 
        .reset(reset), 
        .clk(clk)
        );


        initial begin     //clock generation
            clk=0;
            forever #5 clk <= ~clk; //10ns clk
        end

        initial begin      // initializes all signals to zero
            data_enable = 0;
            write_enable = 0;
            main_external_requests = 0;
            exp_request_up = 0;
            exp_request_down = 0;
            main_sensor_trip = 0;
            main_internal_requests = 0;
            main_temp = 0;
            exp_update_enable = 0;
            exp_input_code = 0;
            exp_temp = 0;
            reset = 0;

            #101            //wait for GSR to be released
            reset = 1;      //reset the design
            main_temp = 64; //set the main car temp to 64
            exp_temp = 64;  //set the express car temp to 64
            #40
            reset = 0;
            #100
            main_external_requests = 9'b000001000; //request main elevator from floor 4
            #50
            main_external_requests = 9'b000000000;
            main_internal_requests = 9'b001000000; //requests main elevator to go to floor 7
            #40
            main_internal_requests = 9'b000000000;
            main_external_requests = 9'b000000001; //requests main elevator from floor 1
            #70
            main_external_requests = 9'b000000000;
            main_internal_requests = 9'b100000000; //requests main elevator to go to floor 9
            #100
            main_internal_requests = 9'b000000000;
            #100
            exp_input_code = 14'b10101010101010;   //set the express car code 
            #10
            exp_update_enable = 1;
            #20
            exp_update_enable = 0;
            #10
            exp_input_code = 14'b00000000000000;
            #200
            exp_request_up = 1;                    //request to go up in express car
            #10
            exp_input_code = 14'b10101010101010;   //enter express security code to go up 
            #10
            exp_request_up = 0; 
            #10
            exp_input_code = 14'b00000000000000;
            #40
            exp_request_down = 1;                  //request to go down in the express car   
            #10
            exp_request_down = 0; 
            #1000
            main_external_requests = 9'b000000000;
        end




endmodule

