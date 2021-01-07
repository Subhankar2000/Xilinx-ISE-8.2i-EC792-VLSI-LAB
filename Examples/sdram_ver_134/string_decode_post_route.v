reg [8*25 :1] string_proc_cmd, string_ctrl_state, string_ctrl_next_state, string_sdrm_cmd, string_next_sdrm_cmd;

//Processor commands
`define P_ADDR_WR  2'b01
`define P_DATA_WR  2'b11
`define P_ADDR_RD  2'b00
`define P_DATA_RD  2'b10
`define P_NOP      2'b10

wire [2:0] proc_cmd = {data_addr_n, we_rn};

always @(proc_cmd) begin
   case (proc_cmd)
     `P_ADDR_WR           : string_proc_cmd = "ADDR_WR";
     `P_DATA_WR           : string_proc_cmd = "DATA_WR";
     `P_ADDR_RD           : string_proc_cmd = "ADDR_RD";
     `P_DATA_RD           : string_proc_cmd = "DATA_RD";
     `P_NOP               : string_proc_cmd = "NOP";
     default              : string_proc_cmd = "UNKNOWN";
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
