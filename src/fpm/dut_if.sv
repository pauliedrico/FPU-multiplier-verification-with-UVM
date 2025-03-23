interface dut_if(input clk, rst);
  logic [3-1:0][16-1:0] operands;
  logic [16-1:0] result;
  logic valid, ready;
    
  modport port_in (input clk, rst, operands, valid, output ready);
  modport port_out (input clk, rst, output valid, result, ready);
endinterface

