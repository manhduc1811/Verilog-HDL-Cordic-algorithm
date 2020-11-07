module AtanROM #(parameter DW = 16 , AW = 4)(
	// inputs, outputs
	input         [(AW-1):0] address,
	output signed [DW-1:0]   AtanValue);
	// ROM data
	reg           [DW-1:0]   romAtan[0:2**AW-1];
	initial begin
		romAtan[0]  	= 16'h3244;
		romAtan[1]  	= 16'h1dac;
		romAtan[2]  	= 16'h0fae;
		romAtan[3]  	= 16'h07f5;
		romAtan[4]  	= 16'h03ff;
		romAtan[5]  	= 16'h0200;
		romAtan[6]  	= 16'h0100;
		romAtan[7]  	= 16'h0080;
		romAtan[8]  	= 16'h0040;
		romAtan[9]  	= 16'h0020;
		romAtan[10] 	= 16'h0010;
		romAtan[11] 	= 16'h0008;
		romAtan[12] 	= 16'h0004;
		romAtan[13] 	= 16'h0002;
		romAtan[14] 	= 16'h0001;
		romAtan[15] 	= 16'h0001;
	end		
	// Assign ROM values
	assign AtanValue 	= romAtan[address];  
endmodule
