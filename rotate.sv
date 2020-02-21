module rotate(input logic [1:10] grid [1:20], input logic [4:0] ypos1, ypos2, ypos3, ypos4, shapeyLoc,
input logic [3:0] xpos1, xpos2, xpos3, xpos4,shapexLoc, input logic setShape,
output logic rotateEnable, output logic [3:0] nxpos1, nxpos2, nxpos3, nxpos4, 
output logic [4:0] nypos1, nypos2, nypos3, nypos4
);
	logic [3:0] normx1;
	logic [3:0] normx2;
	logic [3:0] normx3;
	logic [3:0] normx4;
	logic [3:0] normy1;
	logic [3:0] normy2;
	logic [3:0] normy3;
	logic [3:0] normy4;
	logic isLine;
	always_comb begin
		if((xpos4-xpos1==4'd3) || (xpos1-xpos4==4'd3) || (ypos4-ypos1==5'd3) || (ypos1 - ypos4 == 5'd3))
			isLine = 1'b1;
		else 
			isLine = 1'b0;
		normx1 = xpos1 - shapexLoc + 4'd1;
		normx2 = xpos2 - shapexLoc + 4'd1;
		normx3 = xpos3 - shapexLoc + 4'd1;
		normx4 = xpos4 - shapexLoc + 4'd1;
		normy1 = ypos1 - shapeyLoc + 5'd1;
		normy2 = ypos2 - shapeyLoc + 5'd1;
		normy3 = ypos3 - shapeyLoc + 5'd1;
		normy4 = ypos4 - shapeyLoc + 5'd1;
	
		if(isLine) begin
			nxpos1 = shapexLoc + (normy1) - 4'd1;
			nxpos2 = shapexLoc + (normy2) - 4'd1;
			nxpos3 = shapexLoc + (normy3) - 4'd1;
			nxpos4 = shapexLoc + (normy4) - 4'd1;
			nypos1 = shapeyLoc + normx1 - 4'd1;
			nypos2 = shapeyLoc + normx2 - 4'd1;
			nypos3 = shapeyLoc + normx3 - 4'd1;
			nypos4 = shapeyLoc + normx4 - 4'd1;
		end
		else begin
			nxpos1 = shapexLoc + (4-normy1) - 4'd1;
			nxpos2 = shapexLoc + (4-normy2) - 4'd1;
			nxpos3 = shapexLoc + (4-normy3) - 4'd1;
			nxpos4 = shapexLoc + (4-normy4) - 4'd1;
			nypos1 = shapeyLoc + normx1 - 4'd1;
			nypos2 = shapeyLoc + normx2 - 4'd1;
			nypos3 = shapeyLoc + normx3 - 4'd1;
			nypos4 = shapeyLoc + normx4 - 4'd1;
		end
		if((grid[nypos1][nxpos1] == 1'b0 || ((nypos1 == ypos1 && nxpos1 == xpos1) || (nypos1 == ypos2 && nxpos1 == xpos2) 
		|| (nypos1 == ypos3 && nxpos1 == xpos3) || (nypos1 == ypos4 && nxpos1 == xpos4)))  && 
		(grid[nypos2][nxpos2] == 1'b0 || ((nypos2 == ypos1 && nxpos2 == xpos1) || (nypos2 == ypos2 && nxpos2 == xpos2) 
		|| (nypos2 == ypos3 && nxpos2 == xpos3) || (nypos2 == ypos4 && nxpos2 == xpos4))) && 
		(grid[nypos3][nxpos3] == 1'b0 || ((nypos3 == ypos1 && nxpos3 == xpos1) || (nypos3 == ypos2 && nxpos3 == xpos2) 
		|| (nypos3 == ypos3 && nxpos3 == xpos3) || (nypos3 == ypos4 && nxpos3 == xpos4))) && 
		(grid[nypos4][nxpos4] == 1'b0 || ((nypos4 == ypos1 && nxpos4 == xpos1) || (nypos4 == ypos2 && nxpos4 == xpos2) 
		|| (nypos4 == ypos3 && nxpos4 == xpos3) || (nypos4 == ypos4 && nxpos4 == xpos4)))
		&& !(shapexLoc == 4'd0) && !(shapeyLoc == 5'd0) && (nxpos1 >= 4'd1) && (nxpos1 <= 4'd10)  && 
		(nxpos2 >= 4'd1) && (nxpos2 <= 4'd10)  && (nxpos3 >= 4'd1) && (nxpos3 <= 4'd10)  && (nxpos4 >= 4'd1) && (nxpos4 <= 4'd10) &&
		(nypos1 >= 5'd1) && (nypos1 <= 5'd20) && (nypos2 >= 5'd1) && (nypos2 <= 5'd20) && (nypos3 >= 5'd1) && (nypos3 <= 5'd20) &&
		(nypos4 >= 5'd1) && (nypos4 <= 5'd20))
			rotateEnable = 1'b1;
		else
			rotateEnable = 1'b0;
	end
	
	
endmodule 