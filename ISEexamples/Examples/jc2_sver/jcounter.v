module jcounter (LEFT, CE, CLK, Q) ;

//Inputs
input CE ;	//Clock Enable
input LEFT ;	//Direction Control
input CLK ;	//Clock Input

//Outputs
output [3:0] Q;

reg [3:0] Q;

initial
 begin
    Q[3:0] = 4'b0000;
 end

always @ ( posedge CLK ) begin		//CLK rising edge
      
   if(CE) begin
      if(LEFT) begin
         Q[3:1] = Q[2:0];	//Shift lower bits (Left Shift)
         Q[0]=!Q[3];		//Circulate inverted MSB to LSB
      end
      else begin
         Q[2:0] = Q[3:1];	//Shift upper bits (Right Shift)
         Q[3] = !Q[0];		//Circulate inverted LSB to MSB
      end
   end
   
end

endmodule 
