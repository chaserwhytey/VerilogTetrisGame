module finalproject (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50, 
	VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS,
	CLOCK2_50, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
 AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT, PS2_CLK, PS2_DAT, GPIO_0);
	output logic [35:0] GPIO_0;
	input CLOCK2_50;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	// Audio CODEC
	output AUD_XCK;
	inout PS2_CLK;
	inout PS2_DAT;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	//output logic [1:10] grid [1:20];
	input CLOCK_50;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
	
	assign HEX0 = '1;
	assign HEX1 = '1;
	assign HEX2 = '1;
	assign HEX3 = '1;
	assign HEX4 = '1;
	assign HEX5 = '1;
	
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	//wire reset = key3;
	
	assign writedata_left = readdata_left;
	assign writedata_right = readdata_right;
	assign read = read_ready&write_ready;
	assign write = write_ready&read_ready;
	
	logic [1:10] grid [1:20];
	logic start, move, drawingBoard, rotate, setShape, moveLeft, moveRight, setUp, rotateEnable, getXandY, clearLines, generateShape,
	doneSet, newLines, loser, genShape, color, color1, moveFast;
	assign start = SW[9];
	logic [10:0] x2, y2, x1, y1,x,y;
	logic [2:0] num;
	logic [1:10] line1, line2;
	logic [3:0] ixpos1, ixpos2, ixpos3, ixpos4, nxpos1, nxpos2, nxpos3, nxpos4, xpos1, xpos2, xpos3, xpos4, shapexLoc;
	logic [4:0] iypos1, iypos2, iypos3, iypos4, nypos1, nypos2, nypos3, nypos4, ypos1, ypos2, ypos3, ypos4, shapeyLoc;
	logic key, key1, key2, key3, key3meta;
	always_ff@(posedge CLOCK_50)begin
		key3meta <= ~KEY[3];
		key3 <= key3meta;
	end
	
	logic button_left, button_right, button_middle;
	logic [3:0] bin_x;
	logic [3:0] bin_y;
	 ps2 mouse(
		.start(~KEY[1]),         // transmit instrucions to device
		.reset(key3),         // FSM reset signal
		.CLOCK_50,      //clock source
		.PS2_CLK,       //ps2_clock signal inout
		.PS2_DAT,       //ps2_data  signal inout
		.button_left,   //left button press display
		.button_right,  //right button press display
		.button_middle, //middle button press display
		.bin_x,         //binned X position with hysteresis
		.bin_y          //binned Y position with hysteresis
);

	assign GPIO_0[0] = ~loser;
	assign GPIO_0[1] = loser;
	metaStableIn rotayte(.clk(CLOCK_50), .reset( key3), .KEY(~button_middle),.key);
	metaStableIn moveleft(.clk(CLOCK_50), .reset(key3),.KEY(~button_left),.key(key1));
	metaStableIn moveright(.clk(CLOCK_50), .reset(key3),.KEY(~button_right),.key(key2));
	
	VGA_framebuffer fb(.clk50(CLOCK_50), .reset(1'b0), .x, .y,
				.pixel_color(color), .pixel_write(1'b1),
				.VGA_R, .VGA_G, .VGA_B, .VGA_CLK, .VGA_HS, .VGA_VS,
				.VGA_BLANK_n(VGA_BLANK_N), .VGA_SYNC_n(VGA_SYNC_N));
	LSFR10bit randnum(.clk(CLOCK_50),.reset(key3),.move, .num);
	
	counter count(.clk(CLOCK_50), .reset(key3), .move, .moveFast);
	
	drawBoard yes(.reset(key3), .clk(CLOCK_50), .grid, .x(x1), .y(y1));
	
	readGrid fill(.clk(CLOCK_50), .reset(key3 || move || moveLeft || moveRight || rotate || drawingBoard || moveFast), 
	.grid, .x(x2), .y(y2), .color1);
	
	moveBlock data(.clk(CLOCK_50), .reset(key3), .grid, .rotate, .setShape, .move, .moveFast, .switch0(~KEY[0]),.moveLeft, .moveRight, 
	.setUp, .rotateEnable, .doneSet, .newLines, .clearLines, .start, .generateShape, .line1, .line2, .genShape, .loser, .ixpos1, .ixpos2, .ixpos3, 
	.ixpos4, .iypos1, .iypos2, .iypos3, .iypos4, .nxpos1, .nxpos2, .nxpos3, .nxpos4, .nypos1, .nypos2, .nypos3, .nypos4,
	.xpos1, .xpos2, .xpos3, .xpos4, .ypos1, .ypos2, .ypos3, .ypos4,.shapexLoc,.shapeyLoc
	);
	
	rotate rotation(.grid, .ypos1, .ypos2, .ypos3, .ypos4, .shapeyLoc, .xpos1, .xpos2, .xpos3, .xpos4, .shapexLoc, .setShape, .rotateEnable, 
	.nxpos1, .nxpos2, .nxpos3, .nxpos4, .nypos1, .nypos2, .nypos3, .nypos4);
	
	selXandY choos(.x1, .y1, .x2, .y2, .drawingBoard, .color1, .x, .y, .color);
	
	generateShape gen(.num, .line1, .line2);
	
	controlFSM controllerofStuff(.clk(CLOCK_50), .reset(key3), .start, .genShape, .key1, .key2, 
	.key, .move, .loser, .doneSet, .rotate, .setShape, .moveLeft, .moveRight, .setUp, .getXandY, 
	.drawingBoard, .newLines, .clearLines, .generateShape);
	
	getBlockPositions getter(.clk(CLOCK_50), .grid, .getXandY, .generateShape, 
	.iypos1, .iypos2, .iypos3, .iypos4, .ixpos1, .ixpos2, .ixpos3, .ixpos4, .doneSet);
	
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);
endmodule 

/*module finalproject_testbench();
	logic CLOCK_50; // 50MHz clock.
	//logic [1:10] grid[1:20];
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY; // True when not pressed, False when pressed
	logic [9:0] SW;
	logic [7:0] VGA_R;
	logic [7:0] VGA_G;
	logic [7:0] VGA_B;
	logic VGA_BLANK_N;
	logic VGA_CLK;
	logic VGA_HS;
	logic VGA_SYNC_N;
	logic VGA_VS;
	finalproject dut (.*);
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial CLOCK_50=0;
	initial KEY = 4'b0000;
	always begin
		#(CLOCK_PERIOD/2);
		CLOCK_50 = ~CLOCK_50;
	end
	int i;
	initial begin
		// Reset
		KEY[3]<=0;KEY[0]<=1'b1;KEY[1]<=1'b1;KEY[2]<=1'b1;
		@(posedge CLOCK_50);
		KEY[3]<=1;
		@(posedge CLOCK_50);
		@(posedge CLOCK_50);SW[9] <= 1'b1;
		for (i = 0; i <250; i++) @(posedge CLOCK_50);
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		for (i = 0; i <100; i++) @(posedge CLOCK_50);
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		for (i = 0; i <10; i++) @(posedge CLOCK_50);
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[1]<=1'b0;
		@(posedge CLOCK_50); KEY[1]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		for (i = 0; i <10; i++) @(posedge CLOCK_50);
		@(posedge CLOCK_50); KEY[2]<=1'b0;
		@(posedge CLOCK_50); KEY[2]<=1'b1;
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		@(posedge CLOCK_50); KEY[0]<=1'b0;
		@(posedge CLOCK_50); KEY[0]<=1'b1;
		$stop;
	end
endmodule */