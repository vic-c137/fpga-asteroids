//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The Digit module draws the input digit as the location specified
// by iPosX and iPosY
//
//*********************************************************************
module Letter (
	iClk,
	// position to draw
	iPosX,
	iPosY,
	// current VGA position
	iVGA_X,
	iVGA_Y,
	// digit
	iLetter,
	// output to light pixel
	oDrawLet,
	// blank digit
	iBlank
);

// inputs
input iClk;
input [10:0]	iPosX;
input [10:0]	iPosY;
input [10:0]	iVGA_X;
input [10:0]	iVGA_Y;
input 			iBlank;
input [3:0]		iLetter;

// outputs
output oDrawLet;
wire oDrawLet;

// internal signals
wire [15:0] rowBits;
wire [3:0] col;
wire [3:0] row;
wire [6:0] dAddr;
wire inPosition;
wire drawNum;

// set the column
assign col = iVGA_X - iPosX;
// set the row
assign row = iVGA_Y - iPosY;

// calculate address into digit bitmap ROM
assign dAddr = (iLetter * 16) + row;

// determine if current location (iVGA_X and iVGA_Y) is
// in the range of the placement of this digit
assign inPosition = ((iVGA_X - iPosX)) < 16 && ((iVGA_Y - iPosY) < 16);

// determine if this digit should be draw 
assign drawNum = inPosition && iBlank;

// assign the output based on drawNum and col
assign oDrawLet = (drawNum) ? rowBits[15-col] : 0 ;


// MegaWizard function ROM 1-port
// 16 bits x 112 words
letter_bitmap map(
	.address(dAddr),
	.clock(iClk),
	.q(rowBits)
);



endmodule