//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// In order to a video memory buffer, and speed up development, we
// have utilized the VGA_Ctrl design in the Altera Demonstrations
// for the DE0 board.  This module is now very simple as we only
// need to provide the RGB drive signals based in iDrawPixel
//
//*********************************************************************
module	VGA_Drive	(	
	//	Read Out Side
	oRed,
	oGreen,
	oBlue,
	iVGA_X,
	iVGA_Y,
	iVGA_CLK,
	// Draw Pixel
	iDrawPixel,
	//	CLUT
	iON_R,
	iON_G,
	iON_B,
	iOFF_R,
	iOFF_G,
	iOFF_B,
	//	Control Signals
	iRST_n
);

//	Read Out Side
output	reg	[3:0]	oRed;
output	reg	[3:0]	oGreen;
output	reg	[3:0]	oBlue;
input	[3:0]		iVGA_X;
input	[3:0]		iVGA_Y;
input				iVGA_CLK;
// Draw Pixel
input			iDrawPixel;
//	CLUT
input	[3:0]	iON_R;
input	[3:0]	iON_G;
input	[3:0]	iON_B;
input	[3:0]	iOFF_R;
input	[3:0]	iOFF_G;
input	[3:0]	iOFF_B;
//	Control Signals
input				iRST_n;

always@(posedge iVGA_CLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else
	begin
		oRed		<=	iDrawPixel ?	iON_R : iOFF_R;
		oGreen	<=	iDrawPixel ?	iON_G : iOFF_G;
		oBlue		<=	iDrawPixel ?	iON_B : iOFF_B;
	end
end

endmodule
