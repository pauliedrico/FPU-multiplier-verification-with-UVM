`include "full_adder.sv"
`include "half_adder.sv"

module dadda_tree (
    input logic [11:0] pp1,
    input logic [11:0] pp2,
    input logic [11:0] pp3,
    input logic [11:0] pp4,
    input logic [11:0] pp5,
    input logic [11:0] pp6,
    input logic s1,
    input logic s2,
    input logic s3,
    input logic s4,
    input logic s5,
    input logic s6,

    output logic [21:0] carry,
    output logic [21:0] sum
  );

  wire h1_c, h1_s;
  wire h2_c, h2_s;
  wire h3_c, h3_s;
  wire h4_c, h4_s;
  wire h5_c, h5_s;
  wire h6_c, h6_s;
  wire h7_c, h7_s;
  wire h8_c, h8_s;
  wire h9_c, h9_s;
  wire h10_c, h10_s;
  wire h11_c, h11_s;

  wire a1_c, a1_s;
  wire a2_c, a2_s;
  wire a3_c, a3_s;
  wire a4_c, a4_s;
  wire a5_c, a5_s;
  wire a6_c, a6_s;
  wire a7_c, a7_s;
  wire a8_c, a8_s;
  wire a9_c, a9_s;
  wire a10_c, a10_s;
  wire a11_c, a11_s;
  wire a12_c, a12_s;
  wire a13_c, a13_s;
  wire a14_c, a14_s;
  wire a15_c, a15_s;
  wire a16_c, a16_s;
  wire a17_c, a17_s;
  wire a18_c, a18_s;
  wire a19_c, a19_s;
  wire a20_c, a20_s;
  wire a21_c, a21_s;
  wire a22_c, a22_s;
  wire a23_c, a23_s;
  wire a24_c, a24_s;
  wire a25_c, a25_s;
  wire a26_c, a26_s;
  wire a27_c, a27_s;
  wire a28_c, a28_s;
  wire a29_c, a29_s;
  wire a30_c, a30_s;
  wire a31_c, a31_s;
  wire a32_c, a32_s;
  wire a33_c, a33_s;
  wire a34_c, a34_s;
  wire a35_c, a35_s;
  wire a36_c, a36_s;
  wire a37_c, a37_s;
  wire a38_c, a38_s;
  wire a39_c, a39_s;
  wire a40_c, a40_s;
  wire a41_c, a41_s;
  wire a42_c, a42_s;
  wire a43_c, a43_s;
  wire a44_c, a44_s;

  //layer1
  half_adder h1 (pp1[6],pp2[4],h1_s,h1_c);
  half_adder h2 (pp1[7],pp2[5],h2_s,h2_c);
  half_adder h3 (pp1[8],pp2[6],h3_s,h3_c);
  half_adder h4 (pp1[9],pp2[7],h4_s,h4_c);
  half_adder h5 (1'b1,pp3[11],h5_s,h5_c);
  half_adder h6 (1'b1,pp4[11],h6_s,h6_c);
  full_adder f1 (pp3[4],pp4[2],pp5[0],a1_s,a1_c);
  full_adder f2 (pp3[5],pp4[3],pp5[1],a2_s,a2_c);
  full_adder f3 (pp1[10],pp2[8],pp3[6],a3_s,a3_c);
  full_adder f4 (pp4[4],pp5[2],pp6[0],a4_s,a4_c);
  full_adder f5 (pp1[11],pp2[9],pp3[7],a5_s,a5_c);
  full_adder f6 (pp4[5],pp5[3],pp6[1],a6_s,a6_c);
  full_adder f7 (s1,pp2[10],pp3[8],a7_s,a7_c);
  full_adder f8 (pp4[6],pp5[4],pp6[2],a8_s,a8_c);
  full_adder f9 (s1,pp2[11],pp3[9],a9_s,a9_c);
  full_adder f10 (pp4[7],pp5[5],pp6[3],a10_s,a10_c);
  full_adder f11 (~s1,~s2,pp3[10],a11_s,a11_c);
  full_adder f12 (pp4[8],pp5[6],pp6[4],a12_s,a12_c);
  full_adder f13 (pp4[9],pp5[7],pp6[5],a13_s,a13_c);
  full_adder f14 (~s3,pp4[10],pp5[8],a14_s,a14_c);

  //layer2
  half_adder h7 (pp1[4],pp2[2],h7_s,h7_c);
  half_adder h8 (pp1[5],pp2[3],h8_s,h8_c);
  half_adder h9 (1'b1,pp5[11],h9_s,h9_c);
  full_adder f15 (h1_s,pp3[2],pp4[0],a15_s,a15_c);
  full_adder f16 (h1_c,h2_s,pp3[3],a16_s,a16_c);
  full_adder f17 (h2_c,h3_s,a1_s,a17_s,a17_c);
  full_adder f18 (h3_c,h4_s,a2_s,a18_s,a18_c);
  full_adder f19 (h4_c,a3_s,a4_s,a19_s,a19_c);
  full_adder f20 (a3_c,a5_s,a6_s,a20_s,a20_c);
  full_adder f21 (a5_c,a7_s,a8_s,a21_s,a21_c);
  full_adder f22 (a7_c,a9_s,a10_s,a22_s,a22_c);
  full_adder f23 (a9_c,a11_s,a12_s,a23_s,a23_c);
  full_adder f24 (a11_c,h5_s,a13_s,a24_s,a24_c);
  full_adder f25 (h5_c,a14_s,pp6[6],a25_s,a25_c);
  full_adder f26 (a14_c,h6_s,pp5[9],a26_s,a26_c);
  full_adder f27 (h6_c,pp5[10],~s4,a27_s,a27_c);

  //layer3
  half_adder h10 (pp1[2],pp2[0],h10_s,h10_c);
  half_adder h11 (pp1[3],pp2[1],h11_s,h11_c);
  half_adder h12 (pp6[11],1'b1,h12_s,h12_c);
  full_adder f28 (h7_s,pp3[0],s3,a28_s,a28_c);
  full_adder f29 (h7_c,h8_s,pp3[1],a29_s,a29_c);
  full_adder f30 (h8_c,a15_s,s4,a30_s,a30_c);
  full_adder f31 (a15_c,a16_s,pp4[1],a31_s,a31_c);
  full_adder f32 (a16_c,a17_s,s5,a32_s,a32_c);
  full_adder f33 (a17_c,a1_c,a18_s,a33_s,a33_c);
  full_adder f34 (a18_c,a2_c,a19_s,a34_s,a34_c);
  full_adder f35 (a19_c,a4_c,a20_s,a35_s,a35_c);
  full_adder f36 (a20_c,a6_c,a21_s,a36_s,a36_c);
  full_adder f37 (a21_c,a8_c,a22_s,a37_s,a37_c);
  full_adder f38 (a22_c,a10_c,a23_s,a38_s,a38_c);
  full_adder f39 (a23_c,a12_c,a24_s,a39_s,a39_c);
  full_adder f40 (a24_c,a13_c,a25_s,a40_s,a40_c);
  full_adder f41 (a25_c,a26_s,pp6[7],a41_s,a41_c);
  full_adder f42 (a26_c,a27_s,pp6[8],a42_s,a42_c);
  full_adder f43 (a27_c,h9_s,pp6[9],a43_s,a43_c);
  full_adder f44 (h9_c,pp6[10],~s5,a44_s,a44_c);
  
  assign sum = {h12_s,a44_s,a43_s,a42_s,a41_s,a40_s,a39_s,a38_s,a37_s,a36_s,a35_s,a34_s,a33_s,a32_s,a31_s,a30_s,a29_s,a28_s,h11_s,h10_s,pp1[1],pp1[0]};
  assign carry = {a44_c,a43_c,a42_c,a41_c,a40_c,a39_c,a38_c,a37_c,a36_c,a35_c,a34_c,a33_c,a32_c,a31_c,a30_c,a29_c,a28_c,h11_c,h10_c,s2,1'b0,s1};

endmodule

