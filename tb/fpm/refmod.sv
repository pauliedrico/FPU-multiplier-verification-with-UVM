class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;

    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase
    
	// Convert operation
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


//Saturated product function
function real sat_product(real a, real b);
	real product;
	if(a==65506 || b==65506) begin
		return 65506;	
	end
	product=a*b;
	//$display("%f", product);
	if(a==65505 || b==65505 || a==-65505 || b==-65505) begin
		if(product>=0) begin
			return 65505;
		end
		else begin
			return -65505;
		end
	end 
	else if(product>65504) begin
		return 65505;
	end
    else if(product<-65504) begin 
		return -65505;
	end 
	else begin
		return product;
	end
endfunction: sat_product
  
function real abs_val(real a);
	if(a>=0) begin
		return a;	
	end
	else begin
		return -a;
	end
endfunction: abs_val


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            in.get(tr_in);
          tr_out.result = sat_product(convert_num(tr_in.A), convert_num(tr_in.B)); //??
          $display("refmod: input A = %f, input B = %f, input C = %f, output OUT = %f",convert_num(tr_in.A), convert_num(tr_in.B), convert_num(tr_in.C), tr_out.result);
			//$display("refmod: input A = %b, input B = %b, input C = %b, output OUT = %b",tr_in.A, tr_in.B, tr_in.C, tr_out.result);
          out.put(tr_out);
        end
    endtask: run_phase
endclass: refmod
