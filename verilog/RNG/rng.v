//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The 'rng' module generates three-bit pseudo-random numbers on each 
// rising edge of the input clock signal.
// It uses three linear feedback shift register modules with differing
// periods such that none of the periods shares a prime factor with 
// another. The LFSR modules have 4, 11, and 17 bits, respectively.
//
//*********************************************************************
module rng(random, clk, rst);
	// Output
	output [2:0] random;// 3-bit random number
	
	// Inputs
	input rst;		
	input clk;

	// Wires
	wire [3:0]  state0;
	wire [10:0] state1;
	wire [16:0] state2;
	wire			next_bit0, next_bit1, next_bit2;

	// Seed parameters
	parameter [3:0]  seed0 = 4'b1010;
	parameter [10:0] seed1 = 10'b1101001010;
	parameter [16:0] seed2 = 16'b1011010011010101;

	// Linear feedback shift registers
	lfsr_4  L0 (next_bit0, state0, seed0, clk, rst);
	lfsr_11 L1 (next_bit1, state1, seed1, clk, rst);
	lfsr_17  L2 (next_bit2, state2, seed2, clk, rst);

	// Random ouput bits
	assign random[0] = next_bit0;
	assign random[1] = next_bit1;
	assign random[2] = next_bit2;

endmodule
