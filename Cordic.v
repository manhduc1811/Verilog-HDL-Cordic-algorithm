module Cordic #(parameter DW=16, AW=4)(
	input                  clk, rst, en,
	output                 done,
	input  signed [DW-1:0] z,
	output signed [DW-1:0] x,y);
	// Internals
	// State registers
	reg signed 	[19:0] 	 x_present, x_next;
	reg signed 	[19:0] 	 y_present, y_next;
	reg signed 	[19:0] 	 z_present, z_next;
	reg 		[1:0] 	 state, state_next; 
	reg 		[AW-1:0] n, n_next;
	reg                  done_int, done_delay;	
	// Two states declaration
	localparam IDLE 	 = 1'b0;
	localparam ITERATION = 1'b1;
	// ROM data
	wire        [DW-1:0] AtanValue;
	AtanROM #(.DW(DW),.AW(AW)) UUT (.address(n), .AtanValue(AtanValue));
	// Using FSM MOORE
	// 1) State registers:
	always @ (posedge clk, posedge rst) 
	begin
		if (rst)
		begin
			state 		<= 	IDLE;
			n 	  	    <= 	0;
			x_present 	<= 	0;
			y_present 	<= 	0;
			z_present 	<= 	0;
			done_delay 	<=	1;
		end
		else
		begin
			state 		<= 	state_next;
			n 	  	    <= 	n_next;
			x_present 	<= 	x_next;
			y_present 	<= 	y_next;
			z_present 	<= 	z_next;
			done_delay 	<= 	done_int;
		end	
	end
	// 2) Next state logic:
	always @ (*)
	begin
		// Default next state:
		n_next 			        = n;
		done_int 		        = 1'b0;
		case (state)
			IDLE:
			begin
				n_next 			= 0;
				done_int		= 1'b1;
				x_next 			= 16'h26dd;
				y_next 			= 0;
				z_next 			= z;	
				if (en) 
				begin
					state_next 	= ITERATION;
				end
				else 
				begin
					state_next 	= IDLE;
				end			
			end
			ITERATION:
			begin
				if (z_present[DW-1] == 1'b0)//check polarity 
				begin
					x_next 		= x_present - (y_present >>> n);
					y_next 		= y_present + (x_present >>> n);
					z_next 		= z_present - AtanValue;
				end
				else
				begin
					x_next 		= x_present + (y_present >>> n);
					y_next 		= y_present - (x_present >>> n);
					z_next 		= z_present + AtanValue;
				end
				if (n == (DW-2)) 
				begin
					state_next 	= IDLE;
				end
				else 
				begin
					n_next 		= n + 1'b1;
					state_next 	= ITERATION;
				end				
			end		
		endcase
	end
	// 3) Output logics:
	assign done 	           = done_int & (~done_delay);   
	assign x 	               = done ? x_present : 0;
	assign y 	               = done ? y_present : 0;
endmodule
