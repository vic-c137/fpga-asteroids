//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// The module asteroid_8x8 draws the torpedos that start at a pesudo
// random position on the screen (edge 2 on each and a random direction
// at a 45 degree angle).
//
//*********************************************************************
module asteroid_8x8 (
	iRst,
	iMemClk,
	iPClk,
	// Motion controls
	iDir,
	iPosX,
	iPosY,
	iFireAsteroid,
	iCollision,
	iTorpColl,
	// Draw signals
	iSize,
	iVGA_X,
	iVGA_Y,
	oDrawPixel,
	oFiring,
	oCntPoints
);


// MegaWizard ROM 1-Port
// 20x20  three size asteroids
// asteroid_sprites.mif
asteroidSprites as
(  
	tAddr,
	iMemClk,
	current
);

input [2:0]		iDir;
input [10:0]	iPosX;
input [10:0]	iPosY;
input 			iMemClk;
input				iPClk;
input 			iRst;
input [10:0]	iVGA_X;
input [10:0]	iVGA_Y;
input				iFireAsteroid;
input 			iCollision;
input				iTorpColl;
input	[1:0]		iSize;

output			oDrawPixel;
output			oFiring;
output			oCntPoints;
reg oCntPoints;

reg fired;
wire firing;
reg done;
reg [2:0]	direction;
reg [10:0]	init_pos_X;
reg [10:0]	init_pos_Y;
reg [10:0]	pos_X;
reg [10:0]	pos_Y;
reg [1:0]	size;


reg collided;
reg rstCollided;

wire didCollide;
reg collision;

assign didCollide = collided ^ rstCollided;

always@( negedge iPClk)
begin
	if(iCollision == 1 && oDrawPixel == 1)
	begin
		collision = 1;
		if(iTorpColl == 1)
		begin
			oCntPoints = 1'b1;
		end
		else
		begin
		end
	end
	else
	begin
		collision = 0;
		oCntPoints = 1'b0;
	end
end


always@(posedge collision)
begin
	collided = ~collided;
end


assign firing = fired ^ done;
assign oFiring = firing;

always@(posedge iFireAsteroid)
begin
	if(!firing)
	begin
		direction = iDir;
		init_pos_X = iPosX;
		init_pos_Y = iPosY;
		fired = ~fired;
		size = iSize%3;
	end
	else
	begin
	end
end

wire				oDrawPixel;

wire [4:0] col;
assign col = iVGA_X - pos_X;

wire [4:0] row;
assign row = iVGA_Y - pos_Y;

wire inPosition;
assign inPosition = ((iVGA_X - pos_X)) < 20 && ((iVGA_Y - pos_Y) < 20);

wire drawAsteroid;
assign drawAsteroid = inPosition && firing;

assign oDrawPixel = (drawAsteroid) ? current[col] : 0 ;

initial
begin
	fired = 0;
	done = 0;
	pos_X = 10'b1111111111;
	pos_Y = 10'b1111111111;
end

wire	[5:0]  tAddr;
wire  [19:0] current;
reg [18:0] cnt;

assign tAddr =  (size * 20) + row;

always@(posedge iMemClk or negedge iRst)
begin
	if(!iRst)
	begin
		if(didCollide)
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
			pos_X = init_pos_X;
			pos_Y = init_pos_Y;
			cnt = 0;
		end
		else
		begin
			cnt = cnt + 1'b1;
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
				endcase

				if(pos_Y > 480)
				begin
					pos_X = pos_X + 3'b101;
					if(direction == 1 || direction == 7)
					begin
						pos_Y = 479;
					end
					else
					begin
						pos_Y = 1;
					end
				end
				else
				begin
				end
				
				if(pos_X > 640)
				begin
					pos_Y = pos_Y + 3'b101;
					if(direction == 1 || direction == 3)
					begin
						pos_X = 639;
					end
					else
					begin
						pos_X = 1;
					end
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
		pos_X = 10'b1111111111;
		pos_Y = 10'b1111111111;
	end
end

endmodule
