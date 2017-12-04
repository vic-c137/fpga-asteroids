//*********************************************************************
// John R. Smith
// Victor Colton
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Astroid Game; final project
// Oneshot used to control signal to counters etc
//
// derived from code found here
// http://www.oldcrows.net/~patchell/IpArchive/HdlArchive.html#Digital_oneshot.
//
//*********************************************************************
module oneshot (
	iTrig,
	iClk,
	oPulse
);

// inputs
input iTrig;
input iClk;

// outputs
output oPulse;

// internal registers
reg oPulse;
reg qState;


always@(posedge iTrig or posedge oPulse)
begin
	if(oPulse)
		qState <= 0;
	else
		qState <= 1;
end

always@(posedge iClk)
begin
	oPulse <= qState;
end


endmodule