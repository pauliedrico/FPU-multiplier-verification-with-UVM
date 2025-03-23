module booth_encoder_rad4 (
  input logic b_next,
  input logic b_n,
  input logic b_prev,
  input logic [10:0] A,
  output logic neg,
  output logic [11:0] A_out
);

  logic [2:0] b_temp;

  always_comb begin
  
    b_temp = {b_next, b_n, b_prev};
	
    case (b_temp)
      3'b000: begin
        A_out = 12'b000000000000;
        neg = 1'b0;
      end
      3'b001, 3'b010: begin
        A_out = {1'b0, A};
        neg = 1'b0;
      end
      3'b011: begin
        A_out = {A, 1'b0};
        neg = 1'b0;
      end
      3'b100: begin
		A_out = ~{A, 1'b0};
        neg = 1'b1;
      end
      3'b101, 3'b110: begin
        A_out = ~{1'b0, A};
        neg = 1'b1;
      end
      3'b111: begin
        A_out = 12'b000000000000;
        neg = 1'b0;
      end
    endcase
  end

endmodule
