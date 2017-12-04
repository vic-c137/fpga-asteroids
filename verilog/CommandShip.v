//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The module CommandShip draws the ships (current and spare) in the
// indicated position and direction.  It also detects when an asteroid
// has hit the ship.  The oActive signals is sent to the main module
// to indicate that the ship has been distroyed 
//
//*********************************************************************
module CommandShip (
		iRst,
		iPClk,
		iMemClk,
		iAngle,
		iRestart,
		// Draw Signal
		iVGA_X,
		iVGA_Y,
		oDrawPixel,
		iCollision,
		oActive
		);

// input signals
input [2:0]		iAngle;
input 			iMemClk;
input				iPClk;
input 			iRst;
input				iRestart;
input	[10:0]		iVGA_X;
input	[10:0]		iVGA_Y;
input				iCollision;

// output signals
output			oDrawPixel;
wire				oDrawPixel;
output			oActive;
wire oActive;

//internal signals
wire [4:0] col;
wire [4:0] row;
wire inPosition;
wire drawShip;
wire	[7:0]  rAddr;
wire  [19:0] current;
wire	[2:0]		angle;
reg intack;
reg collision;


// parameters
parameter [10:0] POS_X = 311;
parameter [10:0] POS_Y = 231;


// constant assignments
assign oActive = intack;

// calculate col and row of ship ROM position
assign col = iVGA_X - POS_X;
assign row = iVGA_Y - POS_Y;

// determine if in postion to draw ship
assign inPosition = ((iVGA_X - POS_X)) < 20 && ((iVGA_Y - POS_Y) < 20);
// determine if ship should be drawn
assign drawShip = inPosition && intack;
// assign output DrawPixel
assign oDrawPixel = (drawShip) ? current[col] : 0 ;

// calculate offset into shipBitMaps
assign rAddr =  20 * angle + row;

// set angle of ship
assign angle = iAngle;

// MegaWizard funtion ROM 1-port
// 20 bits wide, 512 words deep
// uses ship_sprites.mif
shipSprite shipBitMaps(
	rAddr, 
	iMemClk, 
	current
);

// check for collision on negative edge of pixel clock
always@( negedge iPClk)
begin
	if(iCollision == 1 && oDrawPixel == 1)
	begin
		collision = 1;
	end
	else
	begin
		collision = 0;
	end
end


// set intack as required 
always@(posedge collision or posedge iRestart or negedge iRst)
begin
	if(iRestart || !iRst)
	begin
		intack = 1'b1;
	end
	else if (collision)
	begin
		intack = 1'b0;
	end
	else
	begin
	end
end


// initial block
initial
begin
	intack = 1;
end


endmodule


 
