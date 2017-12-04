//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The linear feedback shift register is used in generating 
// pseudo-random numbers within the 'rng' module.
// This LFSR module uses 4 bits, with bits 4 and 3 used
// for feedback to the input. This provides a maximal length
// repition peroid for a LFSR with 4 bits.
//
//*********************************************************************
module lfsr_4(next_bit, state, seed, clk, rst);
	output next_bit; 
	output [3:0] state;
	reg [3:0] state;
	input [3:0] seed;
	input clk, rst;
	
	wire linear_feedback;

	// The next bit is the xor of bits 4 and 3
	assign linear_feedback =  state[3] ^ state[2];
	assign next_bit = linear_feedback;
	
	always @(posedge clk or negedge rst)
	if (!rst) 
	begin // active low reset
	  state <= seed ;
	end 
	else
	begin
	 state <= {state[2],
				state[1],
				state[0],
				linear_feedback};
	 end 
 
 endmodule 
