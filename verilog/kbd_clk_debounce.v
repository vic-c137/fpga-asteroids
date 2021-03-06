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
// This is a modified version of the debounce circuit from the
// course website (Blackboard)
//
// reused for Lab 5 and final project: Asteroid Game
//
//  John Smith
//  Victor Colton
//
//*********************************************************************
module kbd_clk_debounce	(
							clk,
							rst_n,
							data_in,
							data_out			
						);
					
input		clk;
input		rst_n;
input		data_in;
output	data_out;
									

//=======================================================
//  REG/WIRE declarations
//=======================================================
parameter	preset_val 	= 0;
parameter 	counter_max = 5; 


reg				data_out;									
reg				data_in_0;	
reg				data_in_1;
reg				data_in_2;
reg				data_in_3;
reg	[20:0]	counter;
	
//=======================================================
//  Structural coding
//=======================================================

always	@(posedge clk or negedge rst_n)
begin
	if	(!rst_n)
	begin
		data_out		<=	preset_val;
		counter			<=	counter_max;
		data_in_0		<=	0;
		data_in_1		<=	0;
		data_in_2		<=	0;
		data_in_3		<=	0;			
	end 
	else 
	begin
		if	(counter == 0) 
		begin
			data_out	<=	data_in_3;
			counter		<=	counter_max;
		end 
		else 
		begin
			counter		<=	counter - 1;
		end
		data_in_0	<=	data_in;	
		data_in_1	<=	data_in_0;
		data_in_2	<=	data_in_1;
		data_in_3	<=	data_in_2;
	end
end
			
				

endmodule
