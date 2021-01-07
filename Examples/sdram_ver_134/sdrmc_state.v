/******************************************************************************
*
*    File Name:  sdrmc_state.v
*      Version:  1.14
*         Date:  Sept 9, 1999
*  Description:  SDRAM Controller State Machine
*
*      Company:  Xilinx
*
*          Log:  06/12/99  JT
*                . change state machine to one hot
* 
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 1998 Xilinx, Inc.
*                All rights reserved
*
******************************************************************************/
`define  C_IDLE     1 //  synchronous reset active
`define  C_PRECH    2 //  Precharge 
`define  C_LOAD_MR  3 //  Load Mode Register
`define  C_PRE_AR   4 //  Pre-Auto_refresh
`define  C_AR       5 //  Auto_refresh
`define  C_ACT      6 //  Activate row
`define  C_READ_W   7 //  Read Wait for Ras-to-Cas delay
`define  C_READ_CS  8 //  Read command
`define  C_READ_C   9 //  Read command, wait for Cas latency
`define  C_READ    10 //  Read data
`define  C_WRITE_W 11 //  Write Wait for Ras-to-Cas delay
`define  C_WRITE_C 12 //  Write command
`define  C_WRITE   13 //  Write data

module sdrmc_state (/*AUTOARG*/
   // Outputs
   pre_sd_ras_p, pre_sd_cas_p, pre_sd_we_p, pre_ld_brst, pre_ld_rcd, 
   pre_ld_cslt, pre_clr_ref, pre_sd_doe_n, pre_sd_doe2_n, 
   pre_sd_ready, pre_sd_add_mx, pre_ad_tri,
   // Inputs
   Reset, Clk, brst_end, cslt_end, rcd_end, auto_ref, ki_end, 
   clr_ref, Act_st, write_st
   );

   output 		pre_sd_ras_p, pre_sd_cas_p, pre_sd_we_p, pre_ld_brst;
   output 		pre_ld_rcd, pre_ld_cslt, pre_clr_ref, pre_ad_tri;
   output 		pre_sd_doe_n, pre_sd_doe2_n, pre_sd_ready, pre_sd_add_mx; 
   
   input 		Reset, Clk, brst_end, cslt_end, rcd_end;
   input 		auto_ref, ki_end, clr_ref;
   input [2:0] 		Act_st;
   input 		write_st;
   
   wire			pre_clr_ref, pre_sd_doe_n, pre_sd_doe2_n;
   wire			pre_sd_ras_p, pre_sd_cas_p, pre_sd_ready, pre_sd_we_p;
   wire			pre_ld_cslt, pre_ld_brst, pre_ld_rcd, pre_sd_add_mx ; 
   reg [13:1] 		state, next_state;
   
   wire 		ki_end, cslt_end;
   wire 		clr_ref, Reset, Clk, auto_ref;
   wire 		brst_end, rcd_end, write_st;
   wire [2:0] 		Act_st;

   wire 		c_idle = state[`C_IDLE];
   wire 		c_prech = state[`C_PRECH];
   wire 		c_load_mr = state[`C_LOAD_MR];
   wire 		c_pre_ar = state[`C_PRE_AR];
   wire 		c_ar = state[`C_AR];
   wire 		c_act = state[`C_ACT];
   wire 		c_read_w = state[`C_READ_W];
   wire 		c_read_cs = state[`C_READ_CS];
   wire 		c_read_c = state[`C_READ_C];
   wire 		c_read = state[`C_READ];
   wire 		c_write_w = state[`C_WRITE_W];
   wire 		c_write_c = state[`C_WRITE_C];
   wire 		c_write = state[`C_WRITE];
   
   assign pre_sd_ras_p =  ~(c_act || c_prech || c_load_mr || c_ar); //Vec[0];	
   assign pre_sd_cas_p = ~(c_read_cs || c_write_c || c_load_mr || c_ar); //  Vec[1];	
   assign pre_sd_we_p = ~(c_write_c || c_prech || c_load_mr); //  Vec[2];	
   assign pre_clr_ref = (c_pre_ar || c_ar); //  Vec[3];
   
   assign  pre_sd_doe_n =  ~(c_write || c_write_c); //Vec[4]
   assign  pre_sd_add_mx = (c_idle || c_act || c_prech || c_load_mr || c_ar || c_pre_ar); // Vec[5];
   assign  pre_ld_cslt =  ~(c_read_cs || c_read_c || c_read );// Vec[6];
   assign  pre_ld_brst =  ~(c_read_c || c_read || c_write || c_write_c); // Vec[7]; 
   assign  pre_ld_rcd =    ~(c_act || c_read_cs || c_read_w || c_write_c || c_write_w); //Vec[8];
   assign  pre_sd_doe2_n = ~(c_act || c_write_w); // Vec[9];
   assign  pre_sd_ready =  c_read; //Vec[10];
   assign  pre_ad_tri = ~(c_read_c || c_read);
   
   // state_intialization
   always @ (posedge Clk or negedge Reset)
     if (~Reset)  state <= 13'b0000000000001;
     else         state <= next_state;
   

   always @ (ki_end or state or Reset or auto_ref or cslt_end or brst_end or 
	     rcd_end or Act_st or write_st or clr_ref) 
   begin
      //has default values for outputs so synthesis tool don't infer latches
      next_state = 13'b0000000000000;
      
      casex (1'b1) //synopsys parallel_case full_case
	state[`C_IDLE]:   begin
	   casex ({ki_end, Act_st}) //synopsys parallel_case full_case
	     4'b1100:  			 next_state[`C_ACT] = 1;
	     4'b1111:  			 next_state[`C_PRE_AR] = 1;
	     4'b1110:  			 next_state[`C_PRECH] = 1;
	     4'b1101:  			 next_state[`C_LOAD_MR] = 1;
	     4'b1000, 4'b1001, 4'b1010, 4'b1011: 
	       if (auto_ref & ~clr_ref ) next_state[`C_PRE_AR] = 1;
	       else                      next_state[`C_IDLE] = 1;
	     default:	                 next_state[`C_IDLE] = 1;
	   endcase
	end // case: state[`IDLE]
	
	state[`C_PRECH]:    	 	 next_state[`C_IDLE] = 1;
	state[`C_LOAD_MR]:    	 	 next_state[`C_IDLE] = 1;
	state[`C_PRE_AR]:    	 	 next_state[`C_AR] = 1;
	state[`C_AR]:    	 	 next_state[`C_IDLE] = 1;
	
	state[`C_ACT]:     
	  if (write_st)	 
	    if (rcd_end)	 	 next_state[`C_WRITE_C] = 1;
	    else      	         	 next_state[`C_WRITE_W] = 1;
	  else				 
	    if (rcd_end)	         next_state[`C_READ_CS] = 1;
	    else	                 next_state[`C_READ_W] = 1;
	
	//Write
	state[`C_WRITE_W]: 
	  if (rcd_end)	                 next_state[`C_WRITE_C] = 1;
	  else	 	                 next_state[`C_WRITE_W] = 1;
	
	state[`C_WRITE_C]:
	  if (brst_end )       	         next_state[`C_IDLE] = 1;
	  else	                         next_state[`C_WRITE] = 1;
	
	
	state[`C_WRITE]:    
	  if (brst_end )	         next_state[`C_IDLE] = 1;
	  else                  	 next_state[`C_WRITE] = 1;
	
	
	//Read
	state[`C_READ_W]: 
	  if (rcd_end)	     		 next_state[`C_READ_CS] = 1;
	  else	 	     		 next_state[`C_READ_W] = 1;
	
	state[`C_READ_CS]:       	 next_state[`C_READ_C] = 1;
	
	state[`C_READ_C]: 
	  if (cslt_end == 1 )	     	 next_state[`C_READ] = 1;
	  else	            	     	 next_state[`C_READ_C] = 1;
	
	state[`C_READ]: 
	   if (brst_end )	         next_state[`C_IDLE] = 1;
	   else	 	                 next_state[`C_READ] = 1;
	
	default:    next_state[`C_IDLE] = 1;
      endcase
   end
endmodule
