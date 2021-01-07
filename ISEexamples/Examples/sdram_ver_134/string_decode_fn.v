reg [8*25 :1] string_proc_cmd, string_ctrl_state, string_ctrl_next_state, string_sdrm_cmd, string_next_sdrm_cmd;

//Processor commands
`define P_ADDR_WR   2'b01
`define P_DATA_WR   2'b11
`define P_ADDR_RD   2'b00
`define P_DATA_RD   2'b10
`define P_NOP       2'b10

wire [1:0] proc_cmd = {data_addr_n, we_rn};

always @(proc_cmd) begin
   case (proc_cmd)
     `P_ADDR_WR           : string_proc_cmd = "ADDR_WR";
     `P_DATA_WR            : string_proc_cmd = "DATA_WR";
     `P_ADDR_RD           : string_proc_cmd = "ADDR_RD";
     `P_DATA_RD            : string_proc_cmd = "DATA_RD";
     `P_NOP                : string_proc_cmd = "NOP";
     default               : string_proc_cmd = "UNKNOWN";
   endcase
end
   
   
//SDRAM commands
`define SDRM_LOAD_MR            3'b000
`define SDRM_AUTO_REFRESH       3'b001
`define SDRM_PRECHARGE          3'b010
`define SDRM_ACT_ROW            3'b011
`define SDRM_WRITEA             3'b100
`define SDRM_READA              3'b101
`define SDRM_BURST_STOP         3'b110
`define SDRM_NOP                3'b111
   
   wire [2:0] sdrm_cmd = {ras_n, cas_n, we_n};
   always @(sdrm_cmd) begin
      case (sdrm_cmd)
	`SDRM_LOAD_MR           : string_sdrm_cmd = "LOAD_MR";
	`SDRM_AUTO_REFRESH      : string_sdrm_cmd = "AUTO_REFRESH";
	`SDRM_PRECHARGE         : string_sdrm_cmd = "PRECHARGE";
	`SDRM_ACT_ROW           : string_sdrm_cmd = "ACT_ROW";
	`SDRM_WRITEA            : string_sdrm_cmd = "WRITEA";
	`SDRM_READA             : string_sdrm_cmd = "READA";
	`SDRM_BURST_STOP        : string_sdrm_cmd = "BURST_STOP";
	`SDRM_NOP               : string_sdrm_cmd = "NOP";
	default                 : string_sdrm_cmd = "UNKOWN";
      endcase // case(sdrm_cmd)
   end // always @ (sdrm_cmd)
   
   //CONTROLLER CURRENT STATE

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
   
   wire state13 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[13];
   wire state12 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[12];
   wire state11 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[11];
   wire state10 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[10];
   wire state9 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[9];
   wire state8 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[8];
   wire state7 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[7];
   wire state6 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[6];
   wire state5 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[5];
   wire state4 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[4];
   wire state3 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[3];
   wire state2 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[2];
   wire state1 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.state[1];
   wire [13:1] state = {state13,state12,state11, state10, state9, state8, state7, state6, state5, state4, state3, state2, state1};
   always @(state) begin
      case (1'b1)		
	state1  : string_ctrl_state = "IDLE"; 
	state2  : string_ctrl_state = "PRECH";
	state3  : string_ctrl_state = "LOAD_MR";
	state4  : string_ctrl_state = "PRE_AR";
	state5  : string_ctrl_state = "AR";
	state6  : string_ctrl_state = "ACT";
	state7  : string_ctrl_state = "READ_W";
	state8  : string_ctrl_state = "READ_CS";
	state9  : string_ctrl_state = "READ_C";
	state10 : string_ctrl_state = "READ";
	state11 : string_ctrl_state = "WRITE_W";
	state12 : string_ctrl_state = "WRITE_C";
	state13 : string_ctrl_state = "WRITE"; 
	default   : string_ctrl_state = "UNKOWN";
      endcase // case(state)
   end // always @ (state)
   
   wire next_state13 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[13];
   wire next_state12 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[12];
   wire next_state11 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[11];
   wire next_state10 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[10];
   wire next_state9 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[9];
   wire next_state8 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[8];
   wire next_state7 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[7];
   wire next_state6 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[6];
   wire next_state5 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[5];
   wire next_state4 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[4];
   wire next_state3 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[3];
   wire next_state2 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[2];
   wire next_state1 = 	f_sdrm.sdrmc.sdrm_t.sdrm_st.next_state[1];
   wire [13:1] next_state = {next_state13,next_state12,next_state11, next_state10, next_state9, next_state8, next_state7, next_state6, next_state5, next_state4, next_state3, next_state2, next_state1};
   always @(next_state) begin
      case (1'b1)		
	next_state1  : string_ctrl_next_state = "IDLE"; 
	next_state2  : string_ctrl_next_state = "PRECH";
	next_state3  : string_ctrl_next_state = "LOAD_MR";
	next_state4  : string_ctrl_next_state = "PRE_AR";
	next_state5  : string_ctrl_next_state = "AR";
	next_state6  : string_ctrl_next_state = "ACT";
	next_state7  : string_ctrl_next_state = "READ_W";
	next_state8  : string_ctrl_next_state = "READ_CS";
	next_state9  : string_ctrl_next_state = "READ_C";
	next_state10 : string_ctrl_next_state = "READ";
	next_state11 : string_ctrl_next_state = "WRITE_W";
	next_state12 : string_ctrl_next_state = "WRITE_C";
	next_state13 : string_ctrl_next_state = "WRITE"; 
	default   : string_ctrl_next_state = "UNKOWN";
      endcase // case(next_state)
   end
