//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// This module controls when asteroids are placed on the screen. After 
// reset, the controller fires 5 asteroids rapidly. It then waits for
// fixed ammount of time (on the order of seconds) before checking a 
// random number to determine whether or not to fire an asteroid. The
// module uses an asteroid timer to make this decision.
//
//*********************************************************************
module asteroid_controller(clk, rst, fire_out);
// Inputs
input clk;
input rst;

// Output
output fire_out;

// Registers
reg [2:0] i;
reg fire;

// Wires
wire d_out;
wire a_out;

// Assignments
assign fire_out = fire;

// Parameters
parameter delay = 32'h2FAF080;

// Asteroid timer
asteroid_timer at (clk, rst, delay, a_out);

// Clock divider
divider d (clk, rst, d_out);

// Count the first five asteroids fired by the module
always@(posedge fire or negedge rst)
begin
	if(rst == 1'b0)
	begin
		i = 0;
	end
	else
	begin
		if(i < 5)
		begin
			i = i + 1;
		end
		else
		begin
		
		end
	end
end

// On the positive clock edge, select the fire ouput from the correct timer
always@(posedge clk)
begin
	if(i >= 5)
	begin
		fire = a_out;
	end
	else
	begin 
		fire = d_out;
	end
end

endmodule
