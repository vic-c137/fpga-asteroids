//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// This module divides the incoming clock signal by 5 at the output.
//
//*********************************************************************
module divider(clk,rst,clk_out);
input clk,rst;

output reg clk_out;

reg [2:0] i;

always @(posedge clk or negedge rst) 
	begin
		if (rst == 1'b0) 
			begin
				i = 0;
				clk_out = 0;
			end
		else 
			begin
				i = i + 1;
				if (i >= 5) 
					begin
						clk_out = ~clk_out; //complement clk_out for another ½ period
						i = 0;
					end
			end 
	end

endmodule