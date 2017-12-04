//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The 'asteroid_timer' module uses a 'rng' module to randomly decide
// whether or not to fire an asteroid after a given delay.
//
//*********************************************************************
module asteroid_timer(clk, rst, delay, fire);
// Inputs
input clk, rst;
input [31:0] delay;

// Ouput
output reg fire;

// Registers
reg [31:0] i;

// Wires
wire [2:0] random;

// Random number generator
rng R1(random, clk, rst);

// After the specified delay, randomly decide to fire or not 
always @(posedge clk or negedge rst) 
	begin
		if (rst == 1'b0) 
		begin
			i = 0;
			fire = 0;
		end
		else 
		begin
			i = i + 1;
			fire = 0;
			if (i >= delay) 
			begin
				i = 0;
				if (random < 2)// 25% chance of firing at threshold of 2
				begin
					fire = 1;
				end
				else
				begin
					fire = 0;
				end
			end
			else
			begin
			
			end
		end 
	end

endmodule
