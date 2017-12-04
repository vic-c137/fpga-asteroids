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
// This LFSR module uses 17 bits, with bits 17 and 14 used
// for feedback to the input. This provides a maximal length
// repition peroid for a LFSR with 17 bits.
//
//*********************************************************************
module lfsr_17(next_bit, state, seed, clk, rst);
	output next_bit; 
	output [16:0] state;
	reg [16:0] state;
	input [16:0] seed;
	input clk, rst;
	
	wire linear_feedback;

	// The next bit is the xor of bits 17 and 14
	assign linear_feedback =  state[16] ^ state[13];
	assign next_bit = linear_feedback;
	
	always @(posedge clk or negedge rst)
	if (!rst) 
	begin // active low reset
	  state <= seed ;// The initial state is the seed value
	end 
	else
	begin
	 state <= {
				state[16],
				state[15],
				state[14],
				state[13],
				state[12],
				state[11],
				state[10],
				state[9],
				state[8],
				state[7],
				state[6],
				state[5],
				state[4],
				state[3],
				state[2],
				state[1],
				state[0],
				linear_feedback};
	 end 
 
 endmodule 
