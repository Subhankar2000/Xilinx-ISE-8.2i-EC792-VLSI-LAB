module statmach (CLK, RESET, STRTSTOP, locked, CLKEN, RST);
input CLK, RESET, STRTSTOP, locked;
output CLKEN, RST;

reg CLKEN, RST;
   
parameter
      clear = 6'b000001,
       zero = 6'b000010,
      start = 6'b000100,
   counting = 6'b001000,
       stop = 6'b010000,
    stopped = 6'b100000;

reg [5:0] current_state /* synthesis state_machine */;
reg [5:0] next_state;

always@(current_state or STRTSTOP or locked)
  begin
    // Assign defaults, so as not set them in every state
    {CLKEN, RST} <= 2'b00;
    case (current_state)
      clear : begin
                next_state <= zero;
                RST <= 1'b1;
              end
      zero  : next_state <= (STRTSTOP & locked) ? start : zero;	    
      start : next_state <= (STRTSTOP & ~locked) ? start : counting;
     counting : begin
                  next_state <= (STRTSTOP & ~locked) ? stop : counting;
                  CLKEN <= 1'b1;
                end
        stop : next_state <= (STRTSTOP) ? stop : stopped;
     stopped : next_state <= (STRTSTOP & locked) ? start : stopped;
     default : next_state <= clear; 
    endcase
  end
   
always @ (posedge CLK or posedge RESET)
      begin
	 if (RESET == 1'b1)
	    current_state = clear;
	 else
	    current_state = next_state;
      end

endmodule
