`include "fpu_wrapper.sv"


function real convert_num(logic[15:0] num);
	real result;	
	real mantissa_r;
	real partial_result;
	real exponent_part;
	int exponent;
	if(num[14:10] == 5'b00000) begin
		mantissa_r=0.0;
		exponent=-14;
	end
	else if(num[14:10] == 5'b11111) begin
		if(num[9:0]==10'b0000000000) begin
			if(num[15]==1) begin
			return -65505;
			end 
			else begin
			return 65505;
			end
	    end
		else begin
			return 65506;
		end
	end	
	else begin
	exponent= $unsigned(num[14:10]) - 15;
	mantissa_r=1.0;
	end

	for(int i=9; i>=0; i--) begin
		partial_result = (num[i] == 1) ? (1.0 /(2**(10 - i))) : 0;
		mantissa_r += partial_result;
	end 
	if(exponent<0) begin
	exponent_part=1.0/(2**(-exponent));
	end
	else begin
	exponent_part=2**exponent;
	end 
	result=(num[15] == 1) ? -mantissa_r*exponent_part : mantissa_r*exponent_part;
    return result;
endfunction: convert_num

module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [1:0] {INITIAL,WAIT,SEND} state);
   
  
  
	parameter fpnew_pkg::fpu_features_t       Features       = fpnew_pkg::RV16F;		   
	parameter fpnew_pkg::fpu_implementation_t Implementation = fpnew_pkg::ISA_PIPE;
	parameter type                            TagType        = logic;
  	

  fpu_wrapper fpu_mult_under_test(.clk(in_inter.clk),.rst_n(!in_inter.rst),.operands(in_inter.operands),.result(out_inter.result));
	logic [3-1:0][16-1:0] op;

    always_ff @(posedge in_inter.clk)
    begin
      if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.result <= 'x;
            out_inter.valid <= 0;
        op[0] <= '0;
        op[1] <= '0;
        op[2] <= '0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
                    state <= WAIT;
                end
                
                WAIT: begin
                    if(in_inter.valid) begin
                        in_inter.ready <= 0;
                      
                        out_inter.valid <= 1;
                        state <= SEND;
                    end
                end
                
                SEND: begin
                    if(out_inter.ready) begin
                      $display("fpu_mult: input A = %f, input B = %f, input C = %f, output OUT = %f",convert_num(in_inter.operands[0]),convert_num(in_inter.operands[1]),convert_num(in_inter.operands[2]),convert_num(out_inter.result));
                      $display("fpu_mult: input A = %b, input B = %b, input C = %b, output OUT = %b",in_inter.operands[0],in_inter.operands[1],in_inter.operands[2],out_inter.result);
                      op[0] <= in_inter.operands[0];
                      op[1] <= in_inter.operands[1];
                      op[2] <= in_inter.operands[2];
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;
                        state <= WAIT;
                    end
                end
        endcase
    end

endmodule: DUT
