module hex2led (hex, led);
input [3:0] hex;
output [7:0] led;

reg [7:0] led;

always @(hex)
   begin
     case (hex)
       4'b0000 : led = 8'b10000001;
       4'b0001 : led = 8'b11100111;
       4'b0010 : led = 8'b10010010;
       4'b0011 : led = 8'b11000010;
       4'b0100 : led = 8'b11100100;
       4'b0101 : led = 8'b11001000;
       4'b0110 : led = 8'b10001100;
       4'b0111 : led = 8'b11100011;
       4'b1000 : led = 8'b10000000;
       4'b1001 : led = 8'b11100000;
       4'b1010 : led = 8'b11111111;
       4'b1011 : led = 8'b11111111;
       4'b1100 : led = 8'b11111111;
       4'b1101 : led = 8'b11111111;
       4'b1110 : led = 8'b11111111;
       4'b1111 : led = 8'b11111111;
       default : led = 8'b11111111;
     endcase
   end
   
endmodule
