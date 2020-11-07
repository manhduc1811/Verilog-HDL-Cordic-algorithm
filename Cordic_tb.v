module Cordic_tb;
	reg                clk,rst,en;
	reg signed  [15:0] z;
	wire signed [15:0] x,y;
	wire               done;
	Cordic UUT(.clk(clk),.rst(rst),.en(en),
			 .done(done),.x(x),.y(y),.z(z));
	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	initial begin
		rst = 1; #5 rst = 0;
	end
	initial begin
		en= 0; z = 0;
		#5   z = 16'h0000; en= 1;
		#100 en=0;
		#500 z = 16'h1922; en= 1;
		#20 en=0;
		#400 z = 16'h2183; en=1;
		#20 en=0;
		#400 z = 16'h3244; en=1;
		#20 en=0;
		#400 z = 16'h6488; en=1;
		#20 en=0;		
		#500 z = -16'h1922; en= 1;
		#20 en=0;
		#400 z = -16'h2183; en=1;
		#20 en=0;
		#400 z = -16'h3244; en=1;
		#20 en=0;
		#400 z = -16'h6488; en=1;
		#20 en=0;		
		#500 $stop ;
	end
endmodule
