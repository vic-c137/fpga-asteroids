## Verilog FPGA Asteroids

A two-person embedded systems hobby project by John Smith and Vic Colton.

#Asteroids game on a DE0 FPGA board in Verilog

Built to run on a Terasic, Altera DE0 FPGA:

http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=364

The HDL pulls user input from the keyboard serial input and pushes data to 
the display via the VGA output using custom drivers.

The RNG module uses a set of three LFSRs, with periods of 4, 11 and 17, to
generate three random bits which are used to introduce pseudo-random 
timing and positioning of the asteroids.
