class packet_out extends uvm_sequence_item;
  	real result;

    `uvm_object_utils_begin(packet_out)
  `uvm_field_real(result, UVM_ALL_ON|UVM_HEX)
    `uvm_object_utils_end

    function new(string name="packet_out");
        super.new(name);
    endfunction: new
endclass: packet_out
