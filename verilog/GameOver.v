//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// When the game is over, 'GAME OVER' is displayed on the screen
//
//*********************************************************************
module GameOver (
	iRst,
	iClk,
	iGameOver,
	oDrawGameOver,
	iVGA_X,
	iVGA_Y,
);

input iRst;
input iClk;
input [1:0] iGameOver;
input [10:0] iVGA_X;
input [10:0] iVGA_Y;

output oDrawGameOver;

wire gameOver;

assign gameOver = (iGameOver == 2'b01) ? 1 : 0 ;

assign oDrawGameOver = drawGO;

wire drawGO;

assign drawGO = drawC0 || drawC1 || drawC2 || drawC3 || drawC4 || drawC5 || drawC6 || drawC7;


Letter g (
	.iClk(iClk),
	// position to draw
	.iPosX(288),
	.iPosY(224),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(0),
	// output to light pixel
	.oDrawLet(drawC0),
	// blank digit
	.iBlank(gameOver)
);

Letter a (
	.iClk(iClk),
	// position to draw
	.iPosX(304),
	.iPosY(224),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(1),
	// output to light pixel
	.oDrawLet(drawC1),
	// blank digit
	.iBlank(gameOver)
);

Letter m (
	.iClk(iClk),
	// position to draw
	.iPosX(320),
	.iPosY(224),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(2),
	// output to light pixel
	.oDrawLet(drawC2),
	// blank digit
	.iBlank(gameOver)
);

Letter e (
		.iClk(iClk),
	// position to draw
	.iPosX(336),
	.iPosY(224),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(3),
	// output to light pixel
	.oDrawLet(drawC3),
	// blank digit
	.iBlank(gameOver)
);

Letter o (
	.iClk(iClk),
	// position to draw
	.iPosX(288),
	.iPosY(240),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(4),
	// output to light pixel
	.oDrawLet(drawC4),
	// blank digit
	.iBlank(gameOver)
);


Letter v (
	.iClk(iClk),
	// position to draw
	.iPosX(304),
	.iPosY(240),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(5),
	// output to light pixel
	.oDrawLet(drawC5),
	// blank digit
	.iBlank(gameOver)
);


Letter e2 (
	.iClk(iClk),
	// position to draw
	.iPosX(320),
	.iPosY(240),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(3),
	// output to light pixel
	.oDrawLet(drawC6),
	// blank digit
	.iBlank(gameOver)
);


Letter r (
	.iClk(iClk),
	// position to draw
	.iPosX(336),
	.iPosY(240),
	// current VGA position
	.iVGA_X(iVGA_X),
	.iVGA_Y(iVGA_Y),
	// digit
	.iLetter(6),
	// output to light pixel
	.oDrawLet(drawC7),
	// blank digit
	.iBlank(gameOver)
);


endmodule
