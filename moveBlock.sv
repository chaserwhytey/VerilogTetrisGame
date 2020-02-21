module moveBlock (clk, reset, grid, rotate, setShape, move, moveFast, switch0, moveLeft, moveRight, setUp, rotateEnable, doneSet, newLines, clearLines,
 start, generateShape, line1, line2, genShape, loser, ixpos1, ixpos2, ixpos3, ixpos4, iypos1, iypos2, iypos3, iypos4,
nxpos1, nxpos2, nxpos3, nxpos4, nypos1, nypos2, nypos3, nypos4, xpos1, xpos2, xpos3, xpos4, ypos1, ypos2, ypos3, ypos4,
shapexLoc, shapeyLoc
);

	input logic clk, reset, rotate, setShape, moveLeft, moveRight, move, setUp, rotateEnable, doneSet, newLines, clearLines, moveFast,
	switch0;
	input logic [1:10] line1, line2;
	input logic [4:0] iypos1, iypos2, iypos3, iypos4, nypos1, nypos2, nypos3, nypos4;
	input logic [3:0] ixpos1, ixpos2, ixpos3, ixpos4, nxpos1, nxpos2, nxpos3, nxpos4;
	input logic start, generateShape;
	output logic [1:10] grid [1:20];
	output logic [3:0] xpos1, xpos2,xpos3, xpos4, shapexLoc;
	output logic [4:0] ypos1, ypos2, ypos3, ypos4, shapeyLoc;
	output logic genShape, loser;

	logic [2:0] numberClearLines;
	logic [1:10] nextLine, nextNextLine;
	
	always @(posedge clk) begin
		if (reset) begin
			ypos1 <= 5'd0; 
			ypos2 <= 5'd0;
			ypos3 <= 5'd0; 
			ypos4 <= 5'd0;
			xpos1 <= 5'd0; 
			xpos2 <= 5'd0; 
			xpos3 <= 4'd0;
			xpos4 <= 4'd0;
			grid[1] <= 10'd0;
			grid[2] <= 10'd0;
			grid[3] <= 10'd0;
			grid[4] <= 10'd0;
			grid[5] <= 10'd0;
			grid[6] <= 10'd0;
			grid[7] <= 10'd0;
			grid[8] <= 10'd0;
			grid[9] <= 10'd0;
			grid[10] <= 10'd0;
			grid[11] <= 10'd0;
			grid[12] <= 10'd0;
			grid[13] <= 10'd0;
			grid[14] <= 10'd0;
			grid[15] <= 10'd0;
			grid[16] <= 10'd0;
			grid[17] <= 10'd0;
			grid[18] <= 10'd0;
			grid[19] <= 10'd0;
			grid[20] <= 10'd0;
			loser <= 1'b0;
			genShape <= 1'b0;
			numberClearLines <= 3'd0;
		end
			
		if(genShape) begin
			ypos1 <= 5'd0; 
			ypos2 <= 5'd0;
			ypos3 <= 5'd0; 
			ypos4 <= 5'd0;
			xpos1 <= 5'd0; 
			xpos2 <= 5'd0; 
			xpos3 <= 4'd0;
			xpos4 <= 4'd0;
		if(grid[1]==10'b1111111111) begin
			grid[1] <= 10'd0;		
		end
		if(grid[2]==10'b1111111111) begin
		numberClearLines <= numberClearLines + 3'd1;

			grid[2] <= 10'd0;
		end
		if(grid[3]==10'b1111111111)begin
			grid[3] <= 10'd0;
		end
		if(grid[4]==10'b1111111111)begin
			grid[4] <= 10'd0;
		end
		if(grid[5]==10'b1111111111)begin
			grid[5] <= 10'd0;
		end
		if(grid[6]==10'b1111111111)begin
			grid[6] <= 10'd0;
		end
		if(grid[7]==10'b1111111111)begin
			grid[7] <= 10'd0;
		end
		if(grid[8]==10'b1111111111)begin
			grid[8] <= 10'd0;
		end
		if(grid[9]==10'b1111111111)begin
			grid[9] <= 10'd0;
		end
		if(grid[10]==10'b1111111111)begin
			grid[10] <= 10'd0;
		end
		if(grid[11]==10'b1111111111) begin
			grid[11] <= 10'd0;	
		end
		if(grid[12]==10'b1111111111) begin
			grid[12] <= 10'd0;
		end
		if(grid[13]==10'b1111111111)begin
			grid[13] <= 10'd0;
		end
		if(grid[14]==10'b1111111111)begin
			grid[14] <= 10'd0;
		end
		if(grid[15]==10'b1111111111)begin
			grid[15] <= 10'd0;
		end
		if(grid[16]==10'b1111111111)begin
			grid[16] <= 10'd0;
		end
		if(grid[17]==10'b1111111111)begin
			grid[17] <= 10'd0;
		end
		if(grid[18]==10'b1111111111)begin
			grid[18] <= 10'd0;
		end
		if(grid[19]==10'b1111111111)begin
			grid[19] <= 10'd0;
		end
		if(grid[20]==10'b1111111111)begin
			grid[20] <= 10'd0;
		end
		end
		
		if(doneSet) begin
			xpos1 <= ixpos1;
			xpos2 <= ixpos2;
			xpos3 <= ixpos3;
			xpos4 <= ixpos4;
			ypos1 <= iypos1;
			ypos2 <= iypos2;
			ypos3 <= iypos3;
			ypos4 <= iypos4;
		end
		
		if(generateShape) begin
			if(grid[1][4:7] == 4'd0 && grid[2][4:7] == 4'd0) begin
			nextLine <= line1;
			nextNextLine <= line2;
			end
			else loser<= 1'b1;
		end
		
		if(setShape) begin
			shapexLoc <= 4'd4;
			shapeyLoc <= 5'd1;
		end
		else if(generateShape)begin
			shapexLoc <= 4'd0;
			shapeyLoc <= 4'd0;
			genShape <= 1'b0;
		end
			
		
		if(newLines && move)begin
			nextNextLine <= 10'd0;
			nextLine<=nextNextLine;
			grid[1][4:7] <= nextLine[4:7];
			grid[2][4:7] <= grid[1][4:7];
		end
		else if(move || (switch0 && moveFast)) begin 
		if((grid[ypos1+5'd1][xpos1] == 1'b1 && !(xpos1 == xpos2 && ypos1 + 5'd1 == ypos2) && !(xpos1 == xpos3 && ypos1 + 5'd1 == ypos3) 
		&& !(xpos1 == xpos4 && ypos1 + 5'd1 == ypos4)) || ypos1 + 5'd1 == 5'd21 || 
		(grid[ypos2+5'd1][xpos2] == 1'b1 && !(xpos2 == xpos1 && ypos2 + 5'd1 == ypos1) && !(xpos2 == xpos3 && ypos2 + 5'd1 == ypos3) 
		&& !(xpos2 == xpos4 && ypos2 + 5'd1 == ypos4)) || ypos2 + 5'd1 == 5'd21 ||
		(grid[ypos3+5'd1][xpos3] == 1'b1 && !(xpos3 == xpos1 && ypos3 + 5'd1 == ypos1) && !(xpos3 == xpos2 && ypos3 + 5'd1 == ypos2) 
		&& !(xpos3 == xpos4 && ypos3 + 5'd1 == ypos4)) || ypos3 + 5'd1 == 5'd21 ||
		(grid[ypos4+5'd1][xpos4] == 1'b1 && !(xpos4 == xpos1 && ypos4 + 5'd1 == ypos1) && !(xpos4 == xpos2 && ypos4 + 5'd1 == ypos2) 
		&& !(xpos4 == xpos3 && ypos4 + 5'd1 == ypos3)) || ypos4 + 5'd1 == 5'd21) 
		begin
			genShape <= 1'b1;
		end
		else begin
			grid[ypos1][xpos1] <= 1'b0;
			grid[ypos2][xpos2] <= 1'b0;
			grid[ypos3][xpos3] <= 1'b0;
			grid[ypos4][xpos4] <= 1'b0;
			grid[ypos1+5'd1][xpos1] <= 1'b1;
			grid[ypos2+5'd1][xpos2] <= 1'b1;
			grid[ypos3+5'd1][xpos3] <= 1'b1;
			grid[ypos4+5'd1][xpos4] <= 1'b1;
			shapeyLoc <= shapeyLoc + 5'd1;
			ypos1 <= ypos1 + 5'd1;
			ypos2 <= ypos2 +5'd1;
			ypos3 <= ypos3 +5'd1;
			ypos4 <= ypos4 +5'd1;
		end
		end
		
		if(clearLines) begin
			if(grid[2] == 10'd0) begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
			end
			if(grid[3] == 10'd0)begin
				grid[2] <= grid[1];
				grid[1] <= 10'd0;
				grid[3] <= grid[2];
			end
			if(grid[4] == 10'd0)begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
			end
			if(grid[5] == 10'd0)begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
			end
			if(grid[6] == 10'd0) begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
			end
			if(grid[7] == 10'd0) begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[7] <= grid[6];
			end
			if(grid[8] == 10'd0) begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
			end
			if(grid[9] == 10'd0) begin
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[10] == 10'd0)begin
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[11] == 10'd0) begin
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[12] == 10'd0) begin
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[13] == 10'd0) begin
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[14] == 10'd0) begin
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[15] == 10'd0) begin
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[16] == 10'd0) begin
				grid[16] <= grid[15];
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[17] == 10'd0) begin
				grid[17] <= grid[16];
				grid[16] <= grid[15];
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[18] == 10'd0)begin
				grid[18] <= grid[17];
				grid[17] <= grid[16];
				grid[16] <= grid[15];
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[19] == 10'd0) begin
				grid[19] <= grid[18];
				grid[18] <= grid[17];
				grid[17] <= grid[16];
				grid[16] <= grid[15];
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
			if(grid[20] == 10'd0)begin
				grid[20] <= grid[19];
				grid[19] <= grid[18];
				grid[18] <= grid[17];
				grid[17] <= grid[16];
				grid[16] <= grid[15];
				grid[15] <= grid[14];
				grid[14] <= grid[13];
				grid[13] <= grid[12];
				grid[12] <= grid[11];
				grid[11] <= grid[10];
				grid[10] <= grid[9];
				grid[1] <= 10'd0;
				grid[2] <= grid[1];
				grid[3] <= grid[2];
				grid[4] <= grid[3];
				grid[5] <= grid[4];
				grid[6] <= grid[5];
				grid[8] <= grid[7];
				grid[9] <= grid[8];
			end
		end
		
		
		if(~move && moveRight && ~moveLeft && (!(grid[ypos1][xpos1+4'd1] == 1'b1 && !(xpos1+4'd1 == xpos2 && ypos1 == ypos2) && !(xpos1 + 4'd1 == xpos3 && ypos1 == ypos3) 
		&& !(xpos1 + 4'd1 == xpos4 && ypos1 == ypos4)) && 
		!(grid[ypos2][xpos2+4'd1] == 1'b1 && !(xpos2 + 4'd1 == xpos1 && ypos1 == ypos1) && !(xpos2 + 4'd1 == xpos3 && ypos1 == ypos3) 
		&& !(xpos2 + 4'd1 == xpos4 && ypos2 == ypos4)) &&
		!(grid[ypos3][xpos3+4'd1] == 1'b1 && !(xpos3 + 4'd1 == xpos1 && ypos3 == ypos1) && !(xpos3 + 4'd1 == xpos2 && ypos3 == ypos2) 
		&& !(xpos3 + 4'd1 == xpos4 && ypos3 == ypos4)) &&
		!(grid[ypos4][xpos4+4'd1] == 1'b1 && !(xpos4 + 4'd1 == xpos1 && ypos4 == ypos1) && !(xpos4 + 4'd1 == xpos2 && ypos4 == ypos2) 
		&& !(xpos4 + 4'd1 == xpos3 && ypos4 == ypos3))) && !(xpos3 + 4'd1 == 4'd11) && !(xpos2 + 4'd1 == 4'd11) && !(xpos1 + 4'd1 == 4'd11)
		&& !(xpos4 + 4'd1 == 4'd11))
		begin
			grid[ypos1][xpos1] <= 1'b0;
			grid[ypos2][xpos2] <= 1'b0;
			grid[ypos3][xpos3] <= 1'b0;
			grid[ypos4][xpos4] <= 1'b0;
			grid[ypos1][xpos1+4'd1] <= 1'b1;
			grid[ypos2][xpos2+4'd1] <= 1'b1;
			grid[ypos3][xpos3+4'd1] <= 1'b1;
			grid[ypos4][xpos4+4'd1] <= 1'b1;
			shapexLoc <= shapexLoc + 4'd1;
			xpos1 <= xpos1 + 4'd1;
			xpos2 <= xpos2 + 4'd1;
			xpos3 <= xpos3 + 4'd1;
			xpos4 <= xpos4 + 4'd1;
		end
		
		if(~move && moveLeft && ~moveRight && (!(grid[ypos1][xpos1-4'd1] == 1'b1 && !(xpos1 - 4'd1 == xpos2 && ypos1 == ypos2) && !(xpos1 - 4'd1 == xpos3 && ypos1 == ypos3) 
		&& !(xpos1 - 4'd1 == xpos4 && ypos1 == ypos4)) &&
		!(grid[ypos2][xpos2-4'd1] == 1'b1 && !(xpos2 - 4'd1 == xpos1 && ypos2 == ypos1) && !(xpos2 - 4'd1 == xpos3 && ypos2 == ypos3) 
		&& !(xpos2 - 4'd1 == xpos4 && ypos2 == ypos4)) &&
		!(grid[ypos3][xpos3-4'd1] == 1'b1 && !(xpos3 - 4'd1 == xpos1 && ypos3 == ypos1) && !(xpos3 - 4'd1 == xpos2 && ypos3 == ypos2) 
		&& !(xpos3 - 4'd1 == xpos4 && ypos3 == ypos4)) &&
		!(grid[ypos4][xpos4-4'd1] == 1'b1 && !(xpos4 - 4'd1 == xpos1 && ypos4 == ypos1) && !(xpos4 - 4'd1 == xpos2 && ypos4 == ypos2) 
		&& !(xpos4 - 4'd1 == xpos3 && ypos4 == ypos3))) && !(xpos1 - 4'd1 == 4'd0) && !(xpos2 - 4'd1 == 4'd0) && 
		!(xpos3 - 4'd1 == 4'd0) && !(xpos4 - 4'd1 == 4'd0))
		begin
			grid[ypos1][xpos1] <= 1'b0;
			grid[ypos2][xpos2] <= 1'b0;
			grid[ypos3][xpos3] <= 1'b0;
			grid[ypos4][xpos4] <= 1'b0;
			grid[ypos1][xpos1-4'd1] <= 1'b1;
			grid[ypos2][xpos2-4'd1] <= 1'b1;
			grid[ypos3][xpos3-4'd1] <= 1'b1;
			grid[ypos4][xpos4-4'd1] <= 1'b1;
			shapexLoc <= shapexLoc - 4'd1;
			xpos1 <= xpos1 - 4'd1;
			xpos2 <= xpos2 - 4'd1;
			xpos3 <= xpos3 - 4'd1;
			xpos4 <= xpos4 - 5'd1;
		end
		
		if(rotate && rotateEnable)begin
			grid[ypos1][xpos1] <= 1'b0;
			grid[ypos2][xpos2] <= 1'b0;
			grid[ypos3][xpos3] <= 1'b0;
			grid[ypos4][xpos4] <= 1'b0;
			grid[nypos1][nxpos1] <= 1'b1;
			grid[nypos2][nxpos2] <= 1'b1;
			grid[nypos3][nxpos3] <= 1'b1;
			grid[nypos4][nxpos4] <= 1'b1;
			xpos1 <= nxpos1;
			xpos2 <= nxpos2;
			xpos3 <= nxpos3;
			xpos4 <= nxpos4;
			ypos1 <= nypos1;
			ypos2 <= nypos2;
			ypos3 <= nypos3;
			ypos4 <= nypos4;
		end
		
	end
	
endmodule

module moveBlock_testbench();
	logic clk, reset, rotate, setShape, move, moveLeft, moveRight, setUp, rotateEnable, start, generateShape;
	logic [1:10] line1, line2;
	logic [1:10] grid[1:20];
	logic genShape, newLines, doneSet, loser, clearLines, switch0, moveFast, s;
	logic [3:0] xpos1, xpos2, xpos3, xpos4, nxpos1, nxpos2, nxpos3, nxpos4, ixpos1, ixpos2, ixpos3, ixpos4, shapexLoc;
	logic [4:0] ypos1, ypos2, ypos3, ypos4, nypos1, nypos2, nypos3, nypos4,iypos1, iypos2, iypos3, iypos4, shapeyLoc;
	moveBlock dut(.*);
	parameter clk_PERIOD = 100;
	initial clk = 1;
	always begin
		#(clk_PERIOD/2); clk = ~clk;
	end
	
	initial begin
		@(posedge clk); reset <= 1;
		@(posedge clk); reset <= 0;
		@(posedge clk); 
		@(posedge clk); start <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop; 
	end
	
endmodule