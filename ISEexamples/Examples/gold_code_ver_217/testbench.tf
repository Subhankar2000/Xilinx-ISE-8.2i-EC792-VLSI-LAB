`timescale 1ns/1ns

module testbench;

wire Gold_Code_T;
reg Clock_T;
reg Enable_T;
reg Fill_En_A_T;
reg Fill_En_B_T;
reg New_Fill_A_T;
reg New_Fill_B_T;

gold_code UUT (.Clock(Clock_T), .Fill_En_A(Fill_En_A_T),
                .Enable(Enable_T),
                .Fill_En_B(Fill_En_B_T), .New_Fill_A(New_Fill_A_T),
                .New_Fill_B(New_Fill_B_T), .Gold_Code(Gold_Code_T));

initial begin
Clock_T = 0;
forever #20 Clock_T = ~Clock_T;
end

initial begin
Fill_En_A_T = 1'b0;
Fill_En_B_T = 1'b0;
#800 Fill_En_A_T = 1'b1;
#800 Fill_En_B_T = 1'b1;
end

initial begin
Enable_T = 1;
New_Fill_A_T = 0;
New_Fill_A_T = 0;
#1000 New_Fill_A_T = 1;
#1000 New_Fill_B_T = 1;
#2000 New_Fill_A_T = 0;
      New_Fill_B_T = 0;
#3000 New_Fill_A_T = 1;
      New_Fill_B_T = 1;
end  


endmodule 

