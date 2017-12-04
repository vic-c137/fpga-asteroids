//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// Simple module to convert hex value into a 6 digit decimal nummer
//
//*********************************************************************
module Hex2BCD(
	iClk,
	iHexPoints,
	oDigit1,
	oDigit2,
	oDigit3,
	oDigit4,
	oDigit5,
	oDigit6
);

input iClk;
input [19:0] iHexPoints;

output [3:0] oDigit1;
output [3:0] oDigit2;
output [3:0] oDigit3;
output [3:0] oDigit4;
output [3:0] oDigit5;
output [3:0] oDigit6;

wire [3:0] oDigit1;
wire [3:0] oDigit2;
wire [3:0] oDigit3;
wire [3:0] oDigit4;
wire [3:0] oDigit5;
wire [3:0] oDigit6;

assign oDigit6 = iHexPoints / 100000;
assign oDigit5 = (iHexPoints % 100000) / 10000;
assign oDigit4 = (iHexPoints % 10000) / 1000;
assign oDigit3 = (iHexPoints % 1000) / 100;
assign oDigit2 = (iHexPoints % 100) / 10;
assign oDigit1 = (iHexPoints % 10);


endmodule