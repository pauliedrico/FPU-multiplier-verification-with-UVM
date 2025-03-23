`include "booth_encoder_rad4.sv"
`include "dadda_tree.sv"

module mbe_rad4_mult (
  input logic [10:0] mantissa_a,
  input logic [10:0] mantissa_b,
  output logic [21:0] product
);

wire [11:0] pp1, pp2, pp3, pp4, pp5, pp6;
wire s1, s2, s3, s4, s5, s6;
wire [21:0]sum, carry;

booth_encoder_rad4 b1 (mantissa_b[1],mantissa_b[0],1'b0,mantissa_a,s1,pp1);
booth_encoder_rad4 b2 (mantissa_b[3],mantissa_b[2],mantissa_b[1],mantissa_a,s2,pp2);
booth_encoder_rad4 b3 (mantissa_b[5],mantissa_b[4],mantissa_b[3],mantissa_a,s3,pp3);
booth_encoder_rad4 b4 (mantissa_b[7],mantissa_b[6],mantissa_b[5],mantissa_a,s4,pp4);
booth_encoder_rad4 b5 (mantissa_b[9],mantissa_b[8],mantissa_b[7],mantissa_a,s5,pp5);
booth_encoder_rad4 b6 (1'b0,mantissa_b[10],mantissa_b[9],mantissa_a,s6,pp6);

dadda_tree d1 (pp1,pp2,pp3,pp4,pp5,pp6,s1,s2,s3,s4,s5,s6,carry,sum);
assign product=carry+sum;

endmodule
