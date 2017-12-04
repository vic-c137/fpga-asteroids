//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The module Torpedo draws the torpedos that start from the center
// (under the ship).  The direction is determined by the orientation
// of the ship at the time the torpedo is fired.  If it does not
// hit an asteroid it will travel until it goes off the screen.
// For this project the torpedo will not wrap around the screen.
// If the ship could move, we would want it to wrap around the screen.
//
//*********************************************************************
module Torpedo (
		iRst,
		iMemClk,
		iPClk,
		// Fire Mech
		iDir,
		iFireTorpedo,
		// draw signals
		iVGA_X,
		iVGA_Y,
		oDrawPixel,
		iCollision
);

// MegaWizard ROM 1-Port
// 5 bit by 5 word
// torpedoSprite.mif
torpedoSprite ts
(  
	tAddr,
	iMemClk,
	current
);

// inputs
input [2:0]		iDir;
input 			iMemClk;
input				iPClk;
input 			iRst;
input [10:0]	iVGA_X;
input [10:0]	iVGA_Y;
input				iFireTorpedo;
input				iCollision;

//outputs
output			oDrawPixel;
wire				oDrawPixel;

// internal
reg collided;
reg rstCollided;
reg collision;
wire didCollide;
reg fired;
wire firing;
reg done;
reg [2:0]	direction;
reg [10:0] pos_X;
reg [10:0] pos_Y;
wire [2:0] col;
wire [2:0] row;
wire inPosition;
wire drawTorpedo;
wire	[2:0]  tAddr;
wire  [4:0] current;
reg [19:0] cnt;
wire [19:0] maxCount;

// parameters
parameter [10:0] INIT_X = 320;
parameter [10:0] INIT_Y = 240;


// collision detection
assign didCollide = collided ^ rstCollided;

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


always@(posedge collision)
begin
	collided = ~collided;
end

// Torpedo state control
assign firing = fired ^ done;

always@(posedge iFireTorpedo)
begin
	if(!firing)
	begin
		direction = iDir;
		fired = ~fired;
	end
	else
	begin
	end
end

// draw control
assign col = iVGA_X - pos_X;
assign row = iVGA_Y - pos_Y;

assign inPosition = ((iVGA_X - pos_X)) < 5 && ((iVGA_Y - pos_Y) < 5);
assign drawTorpedo = inPosition && firing;
assign oDrawPixel = (drawTorpedo) ? current[col] : 0 ;

initial
begin
	fired = 0;
	done = 0;
	pos_X = 10'b1111111111;
	pos_Y = 10'b1111111111;
end



assign maxCount = ((direction%2) == 1) ? 20'h7FFFF : 20'h5A826 ;
assign tAddr =  row;


always@(posedge iMemClk or negedge iRst)
begin
	if(!iRst)
	begin
		if (didCollide)
		begin
			rstCollided = ~rstCollided;
		end
		else
		begin
		end
		if(firing)
		begin
			done = ~done;
		end
		else
		begin
		end
		pos_X = 10'b1111111111;
		pos_Y = 10'b1111111111;
	end
	else if(didCollide)
	begin
		rstCollided = ~rstCollided;
		done = ~done;
		pos_X = 10'b1111111111;
		pos_Y = 10'b1111111111;
	end
	else if(firing)
	begin
		if(pos_X == 10'b1111111111)
		begin
			pos_X = INIT_X;
			pos_Y = INIT_Y;
			cnt = 0;
		end
		else
		begin
			if(cnt < maxCount)
				cnt = cnt + 1'b1;
			else
				cnt = 0;
				
			if (cnt == 0)
			begin
				case (direction)
					3'b000 :  pos_Y = pos_Y - 1'b1;
					3'b001 :  pos_Y = pos_Y - 1'b1;
					3'b010 :  pos_Y = pos_Y;
					3'b011 :  pos_Y = pos_Y + 1'b1;
					3'b100 :  pos_Y = pos_Y + 1'b1;
					3'b101 :  pos_Y = pos_Y + 1'b1;
					3'b110 :  pos_Y = pos_Y;
					3'b111 :  pos_Y = pos_Y - 1'b1;
				default: begin end
				endcase
				
				case (direction)
					3'b000 :  pos_X = pos_X;
					3'b001 :  pos_X = pos_X - 1'b1;
					3'b010 :  pos_X = pos_X - 1'b1;
					3'b011 :  pos_X = pos_X - 1'b1;
					3'b100 :  pos_X = pos_X;
					3'b101 :  pos_X = pos_X + 1'b1;
					3'b110 :  pos_X = pos_X + 1'b1;
					3'b111 :  pos_X = pos_X + 1'b1;	
				default: begin end
				endcase

				if(pos_Y > 480 || pos_X > 640)
				begin
					// off screen clear location for next torpedo
					done = ~done;
					pos_X = 10'b1111111111;
					pos_Y = 10'b1111111111;
				end
				else
				begin
				end
			end
			else
			begin
			end
		end
	end
	else
	begin
		// make sure location has been reset
		pos_X = 10'b1111111111;
		pos_Y = 10'b1111111111;
	end
end
endmodule
