//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Final Project: Asteroid Game
// This is the main file for the Asteroid Game developed by John Smith
// and Victor Colton for their final project for CSCD461 Embedded Systems.
// 
// A command ship is placed in the middle of the screen and for this 
// project will be stationary other than it can rotate a full 360 degrees 
// in 8 steps (45 degree steps).  It can fire 8 ‘torpedoes’ at any point 
// in time and then must wait until those are off-screen before more 
// torpedoes will be available.  At the beginning of the game there will 
// be 5 asteroids placed on the screen very quickly and then they will be 
// placed on a random scheme that allows for a reasonable ‘game play’.  
// There are three extra ships which will be displayed in the upper left 
// corner of the screen, allowing four ships to be destroyed before the 
// game is over.  The score is in the upper right corner of the screen 
// and there are 6 digits, allowing up to 999,999 to be tallied.  For this 
// project the goal will be to place up to 16 asteroids on the screen at 
// any one point in time and they can be small, medium, or large.  A 
// different score will be assigned to the different size asteroids.  
// The backup plan will be to place 16 asteroids of a single size and 
// assign 25 points for each asteroid that is destroyed.  The larger 
// asteroids will not be split into smaller asteroids for this project.
//
//*********************************************************************
module Asteroids (
		// Following Altera's demonstrations, list all 
		// possible output and input ports and then 
		// set them up as required with unused ports
		// either tri-state etc
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_50,						//	50 MHz
		CLOCK_50_2,						//	50 MHz
		////////////////////	Push Button		////////////////////
		BUTTON,							//	Pushbutton[2:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[9:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0_D,							//	Seven Segment Digit 0
		HEX0_DP,						//	Seven Segment Digit DP 0
		HEX1_D,							//	Seven Segment Digit 1
		HEX1_DP,						//	Seven Segment Digit DP 1
		HEX2_D,							//	Seven Segment Digit 2
		HEX2_DP,						//	Seven Segment Digit DP 2
		HEX3_D,							//	Seven Segment Digit 3
		HEX3_DP,						//	Seven Segment Digit DP 3
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[9:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		UART_CTS,						//	UART Clear To Send
		UART_RTS,						//	UART Request To Send
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 13 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 1
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 15 Bits
		FL_DQ15_AM1,					//	FLASH Data bus Bit 15 or Address A-1
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		FL_WP_N,						//	FLASH Hardware Write Protect
		FL_BYTE_N,						//	FLASH Selects 8/16-bit mode
		FL_RY,							//	FLASH Ready/Busy
		////////////////////	LCD Module 16X2		////////////////
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT0,						//	SD Card Data 0
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		SD_WP_N,						//	SD Card Write Protect
		////////////////////	PS2		////////////////////////////
		PS2_KBDAT,						//	PS2 Keyboard Data
		PS2_KBCLK,						//	PS2 Keyboard Clock
		PS2_MSDAT,						//	PS2 Mouse Data
		PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_R,   						//	VGA Red[3:0]
		VGA_G,	 						//	VGA Green[3:0]
		VGA_B,  						//	VGA Blue[3:0]
		////////////////////	GPIO	////////////////////////////
		GPIO0_CLKIN,						//	GPIO Connection 0 Clock In Bus
		GPIO0_CLKOUT,					//	GPIO Connection 0 Clock Out Bus
		GPIO0_D,						//	GPIO Connection 0 Data Bus
		GPIO1_CLKIN,					//	GPIO Connection 1 Clock In Bus
		GPIO1_CLKOUT,					//	GPIO Connection 1 Clock Out Bus
		GPIO1_D							//	GPIO Connection 1 Data Bus
	);

////////////////////////	Clock Input	 	////////////////////////
input				CLOCK_50;				//	50 MHz
input				CLOCK_50_2;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	 [2:0]	BUTTON;					//	Pushbutton[2:0]
////////////////////////	DPDT Switch		////////////////////////
input	 [9:0]	SW;						//	Toggle Switch[9:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output [6:0]	HEX0_D;					//	Seven Segment Digit 0
output			HEX0_DP;				//	Seven Segment Digit DP 0
output [6:0]	HEX1_D;					//	Seven Segment Digit 1
output			HEX1_DP;				//	Seven Segment Digit DP 1
output [6:0]	HEX2_D;					//	Seven Segment Digit 2
output			HEX2_DP;				//	Seven Segment Digit DP 2
output [6:0]	HEX3_D;					//	Seven Segment Digit 3
output			HEX3_DP;				//	Seven Segment Digit DP 3
////////////////////////////	LED		////////////////////////////
output [9:0]	LEDG;					//	LED Green[9:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input		 		UART_RXD;				//	UART Receiver
output			UART_CTS;				//	UART Clear To Send
input				UART_RTS;				//	UART Request To Send
///////////////////////		SDRAM Interface	////////////////////////
inout	 [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output [12:0]	DRAM_ADDR;				//	SDRAM Address bus 13 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 1
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	 [14:0]	FL_DQ;					//	FLASH Data bus 15 Bits
inout				FL_DQ15_AM1;			//	FLASH Data bus Bit 15 or Address A-1
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
output			FL_WP_N;				//	FLASH Hardware Write Protect
output			FL_BYTE_N;				//	FLASH Selects 8/16-bit mode
input				FL_RY;					//	FLASH Ready/Busy
////////////////////	LCD Module 16X2	////////////////////////////
inout	 [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout				SD_DAT0;				//	SD Card Data 0
inout				SD_DAT3;				//	SD Card Data 3
inout				SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
input				SD_WP_N;				//	SD Card Write Protect
////////////////////////	PS2		////////////////////////////////
inout		 		PS2_KBDAT;				//	PS2 Keyboard Data
inout				PS2_KBCLK;				//	PS2 Keyboard Clock
inout			 	PS2_MSDAT;				//	PS2 Mouse Data
inout				PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output [3:0]	VGA_R;   				//	VGA Red[3:0]
output [3:0]	VGA_G;	 				//	VGA Green[3:0]
output [3:0]	VGA_B;   				//	VGA Blue[3:0]
////////////////////////	GPIO	////////////////////////////////
input	 [1:0]	GPIO0_CLKIN;			//	GPIO Connection 0 Clock In Bus
output [1:0]	GPIO0_CLKOUT;			//	GPIO Connection 0 Clock Out Bus
inout	 [31:0]	GPIO0_D;				//	GPIO Connection 0 Data Bus
input	 [1:0]	GPIO1_CLKIN;			//	GPIO Connection 1 Clock In Bus
output [1:0]	GPIO1_CLKOUT;			//	GPIO Connection 1 Clock Out Bus
inout	 [31:0]	GPIO1_D;				//	GPIO Connection 1 Data Bus

//=======================================================
//  REG/WIRE declarations
//=======================================================
//	All inout port turn to tri-state
assign			DRAM_DQ			=	16'hzzzz;
assign			FL_DQ				=	15'hzzzz;
assign			LCD_DATA			=	8'hzz;
assign			SD_DAT0			=	1'hz;
assign			SD_DAT3			=	1'hz;
assign			SD_CMD			=	1'hz;
assign			PS2_MSDAT		=	1'hz;
assign			PS2_MSCLK		=	1'hz;
assign			GPIO0_D			=	32'hzzzzzzzz;
assign			GPIO1_D			=	32'hzzzzzzzz;

assign			HEX0_D			=	7'h7F;
assign			HEX0_DP			=	1'h1;
assign			HEX1_D			=	7'h7F;
assign			HEX1_DP			=	1'h1;
assign			HEX2_D			=	7'h7F;
assign			HEX2_DP			=	1'h1;
assign			HEX3_D			=	7'h7F;
assign			HEX3_DP			=	1'h1;

//assign			LEDG[9:0]		=	7'h00;
////////////////////////	RESET			////////////////////////////
wire 				RST;

assign RST = BUTTON[0];

////////////////////////	VGA			////////////////////////////
wire 	 [3:0]	VGA_R;
wire   [3:0]	VGA_G;
wire   [3:0]	VGA_B;
wire 				VGA_HS;
wire 				VGA_VS;
// pixel clock, should take steps to insure variables (addresses
// and data) are changed on thr positive edge and read on the 
// negative edge.
wire 				pClk;

// holds the current direction of the ship and the direction
// a torpedo will be fired at a point in time.
reg [2:0] angle;

// initial block
initial
begin
	fireCnt = 0;
	rstcnt = 0;
end

//***********************************************************
// VGA Section, providing VGA drive signals and the current
// screen location (X and Y coordinate) to be utilized by
// the screen element modules to determine when to drive
// the drawPixel input

// MegaWizard Function setup as a ALTPLL with a 50 MHz clock
// input and a 25.175 MHz clock output.
vgaClk u2
	( 
		.inclk0(CLOCK_50), 
		.c0(pClk)
	);


wire	[10:0]		mVGA_X;
wire	[10:0]		mVGA_Y;
wire	[3:0]		mOSD_R;
wire	[3:0]		mOSD_G;
wire	[3:0]		mOSD_B;
wire	[3:0]		sVGA_R;
wire	[3:0]		sVGA_G;
wire	[3:0]		sVGA_B;

assign	VGA_R = sVGA_R;
assign	VGA_G = sVGA_G;
assign	VGA_B = sVGA_B;

// Modified Module from Altera Demonstration example
VGA_Ctrl	u3
(	//	Host Side
	.oCurrent_X(mVGA_X),
	.oCurrent_Y(mVGA_Y),
	.iRed(mOSD_R),
	.iGreen(mOSD_G),
	.iBlue(mOSD_B),
	//	VGA Side
	.oVGA_R(sVGA_R),
	.oVGA_G(sVGA_G),
	.oVGA_B(sVGA_B),
	.oVGA_HS(VGA_HS),
	.oVGA_VS(VGA_VS),
	//	Control Signal
	.iCLK(pClk),
	.iRST_N(RST)
);

// Modified Module from Altera Demonstration example
VGA_Drive	u4
(	//	Read Out Side
	.oRed(mOSD_R),
	.oGreen(mOSD_G),
	.oBlue(mOSD_B),
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	.iVGA_CLK(pClk),
	// Draw Pixel
	.iDrawPixel(drawPixel),
	//	CLUT
	.iON_R(15),
	.iON_G(15),
	.iON_B(15),
	.iOFF_R(0),
	.iOFF_G(0),
	.iOFF_B(8),
	//	Control Signals
	.iRST_n(RST)
);

//***********************************************************
// Consolidation of all signals from modules to drive drawPixel.

// consolidation of spare ships
wire spareShips;
wire spare1_PX, spare2_PX, spare3_PX;
assign spareShips = spare1_PX || spare2_PX || spare3_PX;

// current ship, must be separate for collision detection
wire drawShip;
wire ship_PX;
assign drawShip = ship_PX;

// consolidation of torpedos
wire drawTorpedo;
wire torp0_PX, torp1_PX, torp2_PX, torp3_PX, torp4_PX, torp5_PX, torp6_PX, torp7_PX;
assign drawTorpedo = torp0_PX || torp1_PX || torp2_PX || torp3_PX || torp4_PX || torp5_PX || torp6_PX || torp7_PX;

// consolidation of asteroids
wire drawAstroid, drawAstroidU, drawAstroidL;
wire asto0_PX, asto1_PX, asto2_PX, asto3_PX, asto4_PX, asto5_PX, asto6_PX, asto7_PX;
wire asto8_PX, asto9_PX, asto10_PX, asto11_PX, asto12_PX, asto13_PX, asto14_PX, asto15_PX;
assign drawAstroidL = asto0_PX || asto1_PX || asto2_PX || asto3_PX || asto4_PX || asto5_PX || asto6_PX || asto7_PX;
assign drawAstroidU = asto8_PX || asto9_PX || asto10_PX || asto11_PX || asto12_PX || asto13_PX || asto14_PX || asto15_PX;
assign drawAstroid = drawAstroidL || drawAstroidU;

// For this project there are only two colors on the screen.
// A blue background color and a white 'item' color for the
// ship, torpedo, and asteroids.  The following drawPixel is a
// OR'd signal from all the different items on the screen
// indicating the pixel should be the 'item' color.
wire	drawPixel;
assign drawPixel = drawShip || drawAstroid || drawTorpedo || spareShips || drawNum || endGame;


//***********************************************************
// Collision detection Section
// the signals shipAstCol and torpAstCol indicate when a 
// collision between ship and asteroid or torpedo and asteroid
// have taken place,  Each module will monitor these signals
// and determine when a collision took place and change their
// status as required.

wire shipAstCol;
wire torpAstCol;

assign shipAstCol = drawShip && drawAstroid;
assign torpAstCol = drawAstroid && drawTorpedo;



//***********************************************************
// Display Score Section, providing the signal to draw
// the score 

// drive signals for each digit
wire [3:0] digit1, digit2, digit3, digit4, digit5, digit6;

// First digit LSB
Digit d1 (
	.iClk(mClk),
	// position to draw
	.iPosX(600),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit1),
	// output to light pixel
	.oDrawNum(drawNum1),
	// blank digit
	.iBlank(1)

);

// Second digit
Digit d2 (
	.iClk(mClk),
	// position to draw
	.iPosX(584),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit2),
	// output to light pixel
	.oDrawNum(drawNum2),
	// blank digit
	.iBlank(1)

);

// Third digit
Digit d3 (
	.iClk(mClk),
	// position to draw
	.iPosX(568),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit3),
	// output to light pixel
	.oDrawNum(drawNum3),
	// blank digit
	.iBlank(1)

);

// Fourth digit
Digit d4 (
	.iClk(mClk),
	// position to draw
	.iPosX(552),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit4),
	// output to light pixel
	.oDrawNum(drawNum4),
	// blank digit
	.iBlank(1)

);

// fifth digit
Digit d5 (
	.iClk(mClk),
	// position to draw
	.iPosX(536),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit5),
	// output to light pixel
	.oDrawNum(drawNum5),
	// blank digit
	.iBlank(1)

);

// sixth digit
Digit d6 (
	.iClk(mClk),
	// position to draw
	.iPosX(520),
	.iPosY(10),
	// current VGA position
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	// digit
	.iDigit(digit6),
	// output to light pixel
	.oDrawNum(drawNum6),
	// blank digit
	.iBlank(1)

);

// wire declarations and OR'd outputs to drive drawPixel
wire drawNum1, drawNum2, drawNum3, drawNum4, drawNum5, drawNum6;
wire drawNum;
assign drawNum = drawNum1 || drawNum2 || drawNum3 || drawNum4 || drawNum5 || drawNum6;

wire points = addPoints0 || addPoints1 || addPoints2 || addPoints3 || addPoints4 || addPoints5 || addPoints6 || addPoints7 || addPoints8 || addPoints9 || addPoints10 || addPoints11 || addPoints12 || addPoints13 || addPoints14 || addPoints15;
wire addPoints0 , addPoints1 , addPoints2 , addPoints3 , addPoints4 , addPoints5 , addPoints6 , addPoints7 , addPoints8 , addPoints9 , addPoints10 , addPoints11 , addPoints12 , addPoints13 , addPoints14 , addPoints15;
reg [19:0]	PointCount;

// module that converts hex PointCount to drive for each
// digit in decimal
Hex2BCD h2d(
	.iClk(mClk),
	.iHexPoints(PointCount),
	.oDigit1(digit1),
	.oDigit2(digit2),
	.oDigit3(digit3),
	.oDigit4(digit4),
	.oDigit5(digit5),
	.oDigit6(digit6)
);
	
	// clears point count on RST
	always@ (posedge points or negedge RST)
	begin
		if(!RST)
		begin
			PointCount = 0;
		end
		else
		begin
			PointCount = PointCount + 25;
		end
	end


// MegaWizard Function setup as a ALTPLL with a 50 MHz clock
// input and a 50.000 MHz clock output.  If required this clock
// frequency could be increased, but several modules would need
// to be adjusted to compensate for speed of movement of asteroids
// and torpedos
memClk mk (
	.inclk0(CLOCK_50),
	.c0(mClk)
);

wire mClk;

//***********************************************************
// Show Game Over
GameOver go (
	.iRst(RST),
	.iClk(mClk),
	.iVGA_X(mVGA_X),
	.iVGA_Y(mVGA_Y),
	.iGameOver(gameOver),
	.oDrawGameOver(endGame)
);

wire endGame;

//***********************************************************
// keyboard control gets the scancode from a keyboard key
// press and provides torpedo fire and ship rotate commands
//
	wire VB;
	wire [7:0] scancode;
	// setup keyboard to provide scan code for 
	// keyboard key press
	keyboard kb(mClk, PS2_KBCLK, PS2_KBDAT, RST, scancode, VB);
	
	reg [7:0] keyBrdOut;
	reg fireUp, fireDn;
	
	assign fireBtn = fireUp ^ fireDn;
	
	always@(posedge VB)
	begin
		keyBrdOut = scancode;
		
		case(keyBrdOut)
			8'b01101011: angle = angle + 1'b1;
			8'b01110100: angle = angle - 1'b1;
			8'b00101001: fireUp = ~fireUp;
			default: ;
		endcase
		
	end
	
	always@(negedge VB)
	begin
		case(keyBrdOut)
			8'b00101001: fireDn = ~fireDn;
			default: ;
		endcase
	end
	

//***********************************************************
// Current Shipa and spare ship section 
//
CommandShip ship
	(
		// Ship
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iAngle(angle),
		.iRestart(newShip),
		// Draw Signal,
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(ship_PX),
		.iCollision(shipAstCol),
		.oActive(shipAlive)
	);

defparam spare1.POS_X = 10;
defparam spare1.POS_Y = 10;	

CommandShip spare1
	(
		// Ship
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iAngle(0),
		.iRestart(0),
		// Draw Signal,
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(spare1_PX),
		.iCollision(stopS1)
	);

defparam spare2.POS_X = 30;
defparam spare2.POS_Y = 10;
	
CommandShip spare2
	(
		// Ship
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iAngle(0),
		.iRestart(0),
		// Draw Signal,
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(spare2_PX),
		.iCollision(stopS2)
	);
	
defparam spare3.POS_X = 50;
defparam spare3.POS_Y = 10;
	
CommandShip spare3
	(
		// Ship
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iAngle(0),
		.iRestart(0),
		// Draw Signal,
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(spare3_PX),
		.iCollision(stopS3)
	);

wire stopS0;
wire stopS1;
wire stopS2;
wire stopS3;

// MegaWizard function to decode shipCnt
// and hide spare ships as they are used.
// I/O -- DECODE 2 bit input all 4 outputs
spareShipDecode ssd (
	shipCnt,
	stopS0,
	stopS1,
	stopS2,
	stopS3
);

wire 			shipAlive;
reg 			newShip;
reg [1:0]	shipCnt;
reg [31:0] 	rstcnt;
reg 			gameOver;

// always block to wait about 3 seconds
// after the current ship has been destroyed 
// before removing a spare ship and reactivating
// the command ship.  If there are no spare ships
// available, the command ship is not activated
// GAME OVER will be displayed
always@(posedge mClk or negedge RST)
begin
	if(!RST)
	begin
		shipCnt = 0;
		newShip = 1'b0;
		rstcnt = 0;
		gameOver = 1'b0;
	end
	else if(shipCnt != 2'b01)
	begin
		if(!shipAlive)
		begin
			rstcnt = rstcnt + 1'b1;
			if (rstcnt == 32'h09ffffff)
			begin
				newShip = 1'b1;
			end
			else
			begin
			end
		end
		else if (newShip ==1)
		begin
			newShip = 1'b0;
			rstcnt = 0;
			shipCnt = shipCnt - 1'b1;
		end
		else
		begin
		end
	end
	else
	begin
		if(!shipAlive)
		begin
			gameOver = 1'b1;
		end
		else
		begin
			//gameOver = 1'b0;
		end
	end
end


assign LEDG[1:0] = shipCnt;

//***********************************************************
// Torpedo section 
//

oneshot os(fireBtn, mClk, fire);
wire fireBtn;


reg [2:0] fireCnt;
always@(posedge fire)
begin
	if (shipAlive)
	begin
		fireCnt = fireCnt + 1'b1;
	end
	else
	begin
	end
end

wire fire, fire0, fire1, fire2, fire3, fire4, fire5, fire6, fire7;

// MegaWizard function DECODE -- 3 bit input 8 outputs
fireDecode fd (
	fireCnt, 
	fire0, 
	fire1, 
	fire2, 
	fire3, 
	fire4, 
	fire5, 
	fire6, 
	fire7
);
	
Torpedo t0
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire0),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp0_PX),
		.iCollision(torpAstCol)
	);

Torpedo t1
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire1),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp1_PX),
		.iCollision(torpAstCol)
	);

Torpedo t2
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire2),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp2_PX),
		.iCollision(torpAstCol)
	);

Torpedo t3
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire3),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp3_PX),
		.iCollision(torpAstCol)
	);

Torpedo t4
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire4),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp4_PX),
		.iCollision(torpAstCol)
	);

	Torpedo t5
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire5),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp5_PX),
		.iCollision(torpAstCol)
	);

	Torpedo t6
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire6),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp6_PX),
		.iCollision(torpAstCol)
	);

	Torpedo t7
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		// Fire Mech
		.iDir(angle),
		.iFireTorpedo(fire7),
		// draw signals
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(torp7_PX),
		.iCollision(torpAstCol)
	);
	
	
//***********************************************************
// Current Asteroid section
//

// Asteroid placer module determines when an asteroid should be
// created in a pseudo random pattern
	asteroid_placer ap (
		.iClk(mClk),
		.iRst(RST),
		.oDir(direction),
		.oPosX(astoridX),
		.oPosY(astoridY),
		.oSize(astSize)
	
	);
	
	wire [2:0] direction;
	wire [10:0] astoridX;
	wire [10:0] astoridY;
	wire [1:0]	astSize;
	

	
	reg [3:0] aID;
	wire launch;
	
// aseroid control module 
// generates launch signal at pseudo random rate
asteroid_controller cont (
	.clk(mClk),
	.rst(RST),
	.fire_out(launch)

);
	

always@(posedge launch)
begin
	aID = aID + 1'b1;
end

// MegaWizard function DECODE 4 bit input 16 outputs
asteroid_decode ast (
	aID, 
	aFire0, 
	aFire1, 
	aFire2, 
	aFire3, 
	aFire4, 
	aFire5, 
	aFire6, 
	aFire7, 
	aFire8, 
	aFire9, 
	aFire10, 
	aFire11, 
	aFire12, 
	aFire13, 
	aFire14, 
	aFire15
);



wire aFire0, aFire1, aFire2, aFire3, aFire4, aFire5, aFire6, aFire7, aFire8, aFire9;
wire aFire10, aFire11, aFire12, aFire13, aFire14, aFire15;

	
	asteroid_8x8 a0
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire0),
		.iTorpColl(torpAstCol),
		.iCollision(torpAstCol || shipAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto0_PX),
		.oCntPoints(addPoints0),
		.iSize(astSize)
	);
	
		asteroid_8x8 a1
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire1),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto1_PX),
		.oCntPoints(addPoints1),
		.iSize(astSize)
	);
	
	
		asteroid_8x8 a2
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire2),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto2_PX),
		.oCntPoints(addPoints2),
		.iSize(astSize)
	);
	
	
		asteroid_8x8 a3
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire3),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto3_PX),
		.oCntPoints(addPoints3),
		.iSize(astSize)
	);
	
			asteroid_8x8 a4
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire4),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto4_PX),
		.oCntPoints(addPoints4),
		.iSize(astSize)
	);
	
			asteroid_8x8 a5
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire5),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto5_PX),
		.oCntPoints(addPoints5),
		.iSize(astSize)
	);
	
			asteroid_8x8 a6
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire6),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto6_PX),
		.oCntPoints(addPoints6),
		.iSize(astSize)
	);
	
			asteroid_8x8 a7
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire7),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto7_PX),
		.oCntPoints(addPoints7),
		.iSize(astSize)
	);
	
		asteroid_8x8 a8
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire8),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto8_PX),
		.oCntPoints(addPoints8),
		.iSize(astSize)
	);
	
		asteroid_8x8 a9
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire9),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto9_PX),
		.oCntPoints(addPoints9),
		.iSize(astSize)
	);
	
	
		asteroid_8x8 a10
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire10),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto10_PX),
		.oCntPoints(addPoints10),
		.iSize(astSize)
	);
	
	
		asteroid_8x8 a11
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire11),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto11_PX),
		.oCntPoints(addPoints11),
		.iSize(astSize)
	);
	
			asteroid_8x8 a12
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire12),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto12_PX),
		.oCntPoints(addPoints12),
		.iSize(astSize)
	);
	
			asteroid_8x8 a13
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire13),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto13_PX),
		.oCntPoints(addPoints13),
		.iSize(astSize)
	);
	
			asteroid_8x8 a14
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire14),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto14_PX),
		.oCntPoints(addPoints14),
		.iSize(astSize)
	);
	
			asteroid_8x8 a15
	(
		.iRst(RST),
		.iMemClk(mClk),
		.iPClk(pClk),
		.iDir(direction),
		.iPosY(astoridY),
		.iPosX(astoridX),
		.iFireAsteroid(aFire15),
		.iCollision(torpAstCol || shipAstCol),
		.iTorpColl(torpAstCol),
		.iVGA_X(mVGA_X),
		.iVGA_Y(mVGA_Y),
		.oDrawPixel(asto15_PX),
		.oCntPoints(addPoints15),
		.iSize(astSize)
	);
	
endmodule