//*********************************************************************
// John R. Smith
// Eastern Washingtion University
// CSCD 461 EMBEDDED SYSTEMS
// Dr Kosuke Imamura
//
// Lab4: keyboard
// This is a program to read the scan codes from the key board 
// and convert them to a form that can be displayed on the seven 
// segment displays.
// reused in Lab 5
//
// Used for final project: Asteroid Game
//  John Smith
//  Victor Colton
//
//  For the final project it was modified to provide the scancode
//  for any keypress (33 or 55 bit sequences) no validation was done
//
//*********************************************************************
module keyboard
(
	CLK,				// 50 MHz clock
	KB_CLK,			// Keyboard clock
	KB_DATA,			// Keyboard data
	RST,				// button SW0
	ScanCode,		// ScanCode
	valid_bit
);

// inputs
input KB_CLK;
input KB_DATA;
input RST;
input CLK;
//outputs
output [7:0] ScanCode;
output valid_bit;
// registers/wires
reg [15:0] count;
reg [7:0] character;
reg valid_bit;
wire KBCLK_C;

reg [7:0] c1, c2, c3, c4, c5;

assign ScanCode = character;

// debounce keyboard clock signal
kbd_clk_debounce debounce(CLK, RST, KB_CLK, KBCLK_C);
reg short;

always @ (negedge KBCLK_C, negedge RST)
begin
if (RST == 0)
	count = 0;
else
begin
	if (count > 0 && count < 9)
	begin
		// put KB_data into character
		// assume first bit pattern 
		// and don't handle 'special keys'
		// like shift, alt, control etc
		c1[count - 1] = KB_DATA;
	end
	else if(count > 11 && count < 20)
	begin
		c2[count - 12] = KB_DATA;
	end
	else if(count > 23 && count < 31)
	begin
		c3[count - 24] = KB_DATA;
	end
	else if(count > 34 && count < 42)
	begin
		c4[count - 35] = KB_DATA;
	end
	else if(count > 45 && count < 53)
	begin
		c5[count - 46] = KB_DATA;
	end
	else
	begin
	end
	
	if(count == 21)
	begin
		if(c2 == 8'b11110000)
		begin
			character = c1;
			short = 1'b1;
		end
		else if (c1 == 8'b11100000)
		begin
			character = c2;
			short = 1'b0;
		end
	end
	else
	begin
	end
	
	
	
	if(count == 25)
	begin
		valid_bit = 1;
	end
	else
	begin
	end
	
	
	if(count == 30)
	begin
		valid_bit = 0;
	end
	else
	begin
	end

	
	count = count + 1;
	
	if (count == 33 && short == 1)
	begin
		count = 0;
		valid_bit = 0;
		short = 0;
	end
	else
	begin
	end
	
	if (count == 55 && short == 0)
	begin
		count = 0;
		valid_bit = 0;
		short = 0;
	end
	else
	begin
	end
	
end
end

endmodule
