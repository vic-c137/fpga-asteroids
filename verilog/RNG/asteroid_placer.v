//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The 'asteroid_placer' module provides randomized starting positions
// and directions for asteroid modules.
// The outputs include pseudo-random direction, x and y position, and
// asteroid size.
// Three 'rng' modules are used to obtain the number of random bits needed.
//
//*********************************************************************
module asteroid_placer(
		iClk,
		iRst,
		oDir,
		oPosX,
		oPosY,
		oSize
);

// Random number generators
rng R1(random1, iClk, iRst);
rng R2(random2, iClk, iRst);
rng R3(random3, iClk, iRst);

// Inputs
input iClk;
input iRst;

// Outputs
output [2:0] 	oDir;
output [10:0] 	oPosX;
output [10:0] 	oPosY;
output [1:0]	oSize;

// Registers
reg [10:0] oPosX;
reg [10:0] oPosY;

// Wires
wire 	[2:0] random1;
wire 	[2:0] random2;
wire	[2:0]	random3;
wire	[1:0]	oSize;

// Direction select bits
wire [2:0] dir_sel;
assign dir_sel[2] = random1[2];
assign dir_sel[1] = random1[1];
assign dir_sel[0] = random2[0];

// Size select bits
assign oSize = random3[1:0];

// Position select bits
wire [2:0] position;
assign position[2] = random2[2];
assign position[1] = random2[1];
assign position[0] = random2[0];

// Position offset select bits
wire [1:0] offset_sel;
assign offset_sel[1] = random2[2];
assign offset_sel[0] = random2[1];

// Direction select bits
reg [2:0] direction;
assign oDir = direction;

// Position registers
reg [10:0] pos_X;
reg [10:0] pos_Y;

reg [10:0] offset_X;
reg [10:0] offset_Y;

reg [10:0] total_X;
reg [10:0] total_Y;

// Set the position outputs on the falling clock edge
always@(negedge iClk)
begin
	oPosX = total_X;
	oPosY = total_Y;
end

// Update the outputs on the falling clock edge
always @(negedge iClk or negedge iRst)
begin
	// Select the direction
	case (dir_sel)
					3'b000 :  direction = 3'h5;
					3'b001 :  direction = 3'h3;
					3'b010 :  direction = 3'h3;
					3'b011 :  direction = 3'h1;
					3'b100 :  direction = 3'h1;
					3'b101 :  direction = 3'h7;
					3'b110 :  direction = 3'h7;
					3'b111 :  direction = 3'h5;				
				endcase
				
	// Select the x position
	case (position)
					3'b000 :  pos_X = 175;
					3'b001 :  pos_X = 515;
					3'b010 :  pos_X = 640;
					3'b011 :  pos_X = 640;
					3'b100 :  pos_X = 475;
					3'b101 :  pos_X = 195;
					3'b110 :  pos_X = 0;
					3'b111 :  pos_X = 0;				
				endcase			
				
	// Select the y position
	case (position)
					3'b000 :  pos_Y = 0;
					3'b001 :  pos_Y = 0;
					3'b010 :  pos_Y = 115;
					3'b011 :  pos_Y = 375;
					3'b100 :  pos_Y = 480;
					3'b101 :  pos_Y = 480;
					3'b110 :  pos_Y = 355;
					3'b111 :  pos_Y = 125;				
				endcase	
	
	// Select the x offset
	case (offset_sel[0])
					0 :	offset_X = 40;
					1 :	offset_X = 80;
				endcase
			
	// Select the y offset	
	case (offset_sel[0])
					0 :	offset_Y = 30;
					1 :	offset_Y = 60;
				endcase

	// Modify the x position by the x offset if on the horizontal borders
	case (position)
					3'b000 : total_X <= (offset_sel[1] == 0)?pos_X - offset_X:pos_X + offset_X;// modify x
					3'b001 : total_X <= (offset_sel[1] == 0)?pos_X - offset_X:pos_X + offset_X;// modify x
					3'b010 : total_X <= pos_X;// don't mod x
					3'b011 : total_X <= pos_X;// don't mod x
					3'b100 : total_X <= (offset_sel[1] == 0)?pos_X - offset_X:pos_X + offset_X;// modify x
					3'b101 : total_X <= (offset_sel[1] == 0)?pos_X - offset_X:pos_X + offset_X;// modify x
					3'b110 : total_X <= pos_X;// don't mod x
					3'b111 : total_X <= pos_X;// don't mod x
				endcase
				
	// Modify the y position by the y offset if on the vertical borders			
	case (position)
					3'b000 : total_Y <= pos_Y;// don't mod y
					3'b001 : total_Y <= pos_Y;// don't mod y
					3'b010 : total_Y <= (offset_sel[1] == 0)?pos_Y - offset_Y:pos_Y + offset_Y;// modify y
					3'b011 : total_Y <= (offset_sel[1] == 0)?pos_Y - offset_Y:pos_Y + offset_Y;// modify y
					3'b100 : total_Y <= pos_Y;// don't mod y
					3'b101 : total_Y <= pos_Y;// don't mod y
					3'b110 : total_Y <= (offset_sel[1] == 0)?pos_Y - offset_Y:pos_Y + offset_Y;// modify y
					3'b111 : total_Y <= (offset_sel[1] == 0)?pos_Y - offset_Y:pos_Y + offset_Y;// modify y
				endcase
end

endmodule
