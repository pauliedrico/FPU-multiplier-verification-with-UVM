import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../../src/add/adder.sv"
`include "../../src/add/dut_if.sv"
`include "../../src/add/DUT.sv"
`include "dd/packet_in.sv"
`include "add/packet_out.sv"
`include "add/sequence_in.sv"
`include "../common/sequencer.sv"
`include "driver.sv"
`include "driver_out.sv"
`include "monitor.sv"
`include "monitor_out.sv"
`include "../common/agent.sv"
`include "../common/agent_out.sv"
`include "refmod.sv"
`include "comparator.sv"
`include "../common/env.sv"
`include "../common/simple_test.sv"

//Top
module top;
  logic clk;
  logic rst;
  
  initial begin
    clk = 0;
    rst = 1;
    #22 rst = 0;
    
  end
  
  always #5 clk = !clk;
  
  logic [1:0] state;
  
  dut_if in(clk, rst);
  dut_if out(clk, rst);
  
  DUT sum(in, out, state);

  initial begin
    `ifdef INCA
      $recordvars();
    `endif
    `ifdef VCS
      $vcdpluson;
    `endif
    `ifdef QUESTA
      $wlfdumpvars();
      set_config_int("*", "recording_detail", 1);
    `endif
    
    uvm_config_db#(input_vif)::set(uvm_root::get(), "*.env_h.mst.*", "vif", in);
    uvm_config_db#(output_vif)::set(uvm_root::get(), "*.env_h.slv.*",  "vif", out);
    
    run_test("simple_test");
  end
endmodule
