`include "fpnew_pkg.sv"
`include "fpnew_top.sv"
module fpu_wrapper(
    input logic clk,
    input logic rst_n,
  	input logic [3-1:0][16-1:0] operands,
  	output logic [16-1:0] result
);
    parameter type                            TagType        = logic;
  	logic 								in_valid;  
  	fpnew_pkg::roundmode_e              rnd_mode;
    fpnew_pkg::operation_e              op;
    logic                               op_mod;
    fpnew_pkg::fp_format_e              src_fmt;
    fpnew_pkg::fp_format_e              dst_fmt;
    fpnew_pkg::int_format_e             int_fmt;
    logic                               vectorial_op;
    TagType                             tag_i,tag_o;
    logic                               flush;
    logic                               out_valid;
  	logic 								in_ready, out_ready;
  	fpnew_pkg::status_t                	status_o;
  logic 								busy;

    assign rnd_mode = fpnew_pkg::RNE;
    assign op = fpnew_pkg::MUL;
    assign op_mod = 0;
    assign src_fmt = fpnew_pkg::FP16;
    assign dst_fmt = fpnew_pkg::FP16;
    assign int_fmt = fpnew_pkg::INT16;   
    assign vectorial_op = 0;
    assign tag_i = 0;
    assign flush = 0;
  	assign in_valid = 1;
    
    assign out_ready = out_valid;

    fpnew_top fpu_under_test(
      .clk_i(clk),
      .rst_ni(rst_n),
		  .operands_i(operands),
		  .rnd_mode_i(rnd_mode),
		  .op_i(op),
		  .op_mod_i(op_mod),
		  .src_fmt_i(src_fmt),
		  .dst_fmt_i(dst_fmt),
		.int_fmt_i(int_fmt),
		.vectorial_op_i(vectorial_op),
		.tag_i(tag_i),
		.in_valid_i(in_valid),
		.in_ready_o(in_ready),
		.flush_i(flush),
		.result_o(result),
		.status_o(status),
		.tag_o(tag_o),
		.out_valid_o(out_valid),
		.out_ready_i(out_ready),
		.busy_o(busy)
    );

endmodule


