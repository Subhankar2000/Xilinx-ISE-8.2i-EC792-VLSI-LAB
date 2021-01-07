module stmchine (clk, reset, strtstop, clken, rst);
input clk, reset, strtstop;
output clken, rst;

reg clken, rst;
   
parameter
      clear = 3'b000,
       zero = 3'b001,
      start = 3'b010,
   counting = 3'b011,
       stop = 3'b100,
    stopped = 3'b101;

reg [2:0] current_state;
reg [2:0] next_state;

always@(current_state or strtstop)
  begin
    // Assign defaults, so as not set them in every state
    {clken, rst} <= 2'b00;
    case (current_state)
      clear : begin
                next_state <= zero;
                rst <= 1'b1;
              end
      zero  : next_state <= (strtstop) ? start : zero;	    
      start : next_state <= (strtstop) ? start : counting;
     counting : begin
                  next_state <= (strtstop) ? stop : counting;
                  clken <= 1'b1;
                end
        stop : next_state <= (strtstop) ? stop : stopped;
     stopped : next_state <= (strtstop) ? start : stopped;
     default : next_state <= 6'bx; 
    endcase
  end
   
always @ (posedge clk or negedge clk or posedge reset)
      begin
	 if (reset == 1'b1)
	    current_state = clear;
	 else
	    current_state = next_state;
      end

endmodule
