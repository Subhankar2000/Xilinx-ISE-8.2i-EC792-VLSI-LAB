//  12/22/98  M. Gulotta           Modified to remove all (2 clk_8fc cycle) latency from SnapEn.
// If a non Virtex device was selected for implementation the following 
// Compiler directive must be uncommented for proper simulation.
// `define non_Virtex

`timescale  1ns / 100ps

module testbench;

parameter pn_lngth = 131071; //(2^^17 - 1)

`ifdef non_Virtex
reg  clk, RESET, DataIn_i, DataIn_q, FillSel, ShiftEn;

`else
reg  clk, DataIn_i, DataIn_q, FillSel, ShiftEn;

`endif

reg      actual_out_i, actual_out_q;
wire     pn_out_i, pn_out_q;
integer  pni_testout, pnq_testout;
integer  k;
reg      pni_gold [pn_lngth:1];
reg      pnq_gold [pn_lngth:1];

`ifdef non_Virtex  // compiler directive, if defined, will simulate asyn reset FF.
	initial begin
      pni_testout = $fopen("pni_testout.dat");  // output pn bit to file.
      $readmemb("pni_gold.dat", pni_gold);      // read golden pn bits from file.
      pnq_testout = $fopen("pnq_testout.dat");  // output pn bit to file.
      $readmemb("pnq_gold.dat", pnq_gold);      // read golden pn bits from file.
      k       = 1;
      RESET   <=  1'b0;
      clk     <=  1'b0;
      #10;
      RESET   <=  1'b0;
      #50;
      RESET   <=  1'b1;
	end

	// generate chip clock
	always @(posedge RESET) begin
   	forever
      	#10 clk = ~clk;
	end

`else // executed for Virtex devices
	initial begin
      pni_testout = $fopen("pni_testout.dat");  // output pn bit to file.
      $readmemb("pni_gold.dat", pni_gold);      // read golden pn bits from file.
      pnq_testout = $fopen("pnq_testout.dat");  // output pn bit to file.
      $readmemb("pnq_gold.dat", pnq_gold);      // read golden pn bits from file.
      k       = 1;
      clk     <=  1'b0;
      #60;
	 end

	  reg GTS;
assign glbl.GTS = GTS;
reg GSR;
assign glbl.GSR = GSR;

initial begin
	GSR = 1;
	GTS = 1;
	#60
	GSR = 0;
	GTS = 0;
end
	// generate chip clock
	always begin
   	forever
      	#10 clk = ~clk;
	end

`endif

initial begin  // shift in fill pattern (1 0000 0000 0000 0000)
   ShiftEn <= 1'b1;
   FillSel <= 1'b1;
   DataIn_i <= 1'b0;
   DataIn_q <= 1'b0;

   repeat(16) @(posedge clk);
	#5
      DataIn_i <= 1'b1;
      DataIn_q <= 1'b1;
   @(posedge clk);
	#5
      FillSel <= 1'b0;
      DataIn_i <= 1'b0;
      DataIn_q <= 1'b0;
end

always @(posedge clk) begin  // check results.
   if (FillSel == 1'b0) begin
      actual_out_i = pn_out_i;
      actual_out_q = pn_out_q;
      $fwrite(pni_testout,  "%b\n", actual_out_i);
      $fwrite(pnq_testout,  "%b\n", actual_out_q);
      if ( actual_out_i == pni_gold[k])
          $display("Testing at %0d ns.  PN I bit %0d good.  file = %0d; actual = %0d. \n", $time, k, pni_gold[k], actual_out_i );
      else begin
          $display("Testing at %0d ns.  PN I bit %0d BAD.  file = %0d; actual = %0d. \n", $time, k, pni_gold[k], actual_out_i );
          $stop;
      end
      if ( actual_out_q == pnq_gold[k])
          $display("Testing at %0d ns.  PN Q bit %0d good.  file = %0d; actual = %0d. \n", $time, k, pnq_gold[k], actual_out_q );
      else begin
          $display("Testing at %0d ns.  PN Q bit %0d BAD.  file = %0d; actual = %0d. \n", $time, k, pnq_gold[k], actual_out_q );
          $stop;
      end

      k = k + 1;
      if (k == pn_lngth+1)  begin
         k = 1;
         $display("TESTED COMPLETE PN SEQUENCE... rolling over to test again. \n\n");
      end                                                                                                                                                                                                end
end


`ifdef non_Virtex // compiler directive, if defined, will simulate asyn reset FF.
iq_pn_gen inst_pn_gen_iq__srl (.clk(clk), .pn_out_i(pn_out_i),
                                    .pn_out_q(pn_out_q), .RESET(RESET),
                                    .DataIn_i(DataIn_i), .DataIn_q(DataIn_q),
                                    .FillSel(FillSel), .ShiftEn(ShiftEn));

`else
iq_pn_gen inst_pn_gen_iq__srl (.clk(clk), .pn_out_i(pn_out_i),
                                    .pn_out_q(pn_out_q), 
                                    .DataIn_i(DataIn_i), .DataIn_q(DataIn_q),
                                    .FillSel(FillSel), .ShiftEn(ShiftEn));

`endif

endmodule




