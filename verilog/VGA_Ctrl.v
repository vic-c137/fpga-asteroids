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
// for the DE0 board.  Change are mostly removal of unused variables
// and changes to variable sizes 
//
//*********************************************************************
module	VGA_Ctrl	(
	//	Host Side
	iRed,
	iGreen,
	iBlue,
	oCurrent_X,
	oCurrent_Y,
	//	VGA Side
	oVGA_R,
	oVGA_G,
	oVGA_B,
	oVGA_HS,
	oVGA_VS,
	//	Control Signal
	iCLK,
	iRST_N
);
//	Host Side
input		[3:0]		iRed;
input		[3:0]		iGreen;
input		[3:0]		iBlue;
output	[10:0]	oCurrent_X;
output	[10:0]	oCurrent_Y;
//	VGA Side
output	[3:0]		oVGA_R;
output	[3:0]		oVGA_G;
output	[3:0]		oVGA_B;
output	reg		oVGA_HS;
output	reg		oVGA_VS;
//	Control Signal
input				iCLK;
input				iRST_N;	
//	Internal Registers
reg			[10:0]	H_Cont;
reg			[10:0]	V_Cont;
////////////////////////////////////////////////////////////
//	Horizontal	Parameter
parameter	H_FRONT	=	16;
parameter	H_SYNC	=	96;
parameter	H_BACK	=	48;
parameter	H_ACT	=	640;
parameter	H_BLANK	=	H_FRONT+H_SYNC+H_BACK;
parameter	H_TOTAL	=	H_FRONT+H_SYNC+H_BACK+H_ACT;
////////////////////////////////////////////////////////////
//	Vertical Parameter
parameter	V_FRONT	=	10;
parameter	V_SYNC	=	2;
parameter	V_BACK	=	33;
parameter	V_ACT	=	480;
parameter	V_BLANK	=	V_FRONT+V_SYNC+V_BACK;
parameter	V_TOTAL	=	V_FRONT+V_SYNC+V_BACK+V_ACT;
////////////////////////////////////////////////////////////
assign	oVGA_R		=	(oCurrent_X > 0) ?	iRed : 0 ;
assign	oVGA_G		=	(oCurrent_X > 0) ?	iGreen : 0 ;
assign	oVGA_B		=	(oCurrent_X > 0) ?	iBlue : 0 ;
assign	oCurrent_X	=	(H_Cont>=H_BLANK)	?	H_Cont-H_BLANK	:	11'h0	;
assign	oCurrent_Y	=	(V_Cont>=V_BLANK)	?	V_Cont-V_BLANK	:	11'h0	;

//	Horizontal Generator: Refer to the pixel clock
always@(posedge iCLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		H_Cont		<=	0;
		oVGA_HS		<=	1;
	end
	else
	begin
		if(H_Cont<H_TOTAL-1)
		H_Cont	<=	H_Cont+1'b1;
		else
		H_Cont	<=	0;
		//	Horizontal Sync
		if(H_Cont==H_FRONT-1)			//	Front porch end
		oVGA_HS	<=	1'b0;
		if(H_Cont==H_FRONT+H_SYNC-1)	//	Sync pulse end
		oVGA_HS	<=	1'b1;
	end
end

//	Vertical Generator: Refer to the horizontal sync
always@(posedge oVGA_HS or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		V_Cont		<=	0;
		oVGA_VS		<=	1;
	end
	else
	begin
		if(V_Cont<V_TOTAL-1)
		V_Cont	<=	V_Cont+1'b1;
		else
		V_Cont	<=	0;
		//	Vertical Sync
		if(V_Cont==V_FRONT-1)			//	Front porch end
		oVGA_VS	<=	1'b0;
		if(V_Cont==V_FRONT+V_SYNC-1)	//	Sync pulse end
		oVGA_VS	<=	1'b1;
	end
end

endmodule
