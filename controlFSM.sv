module controlFSM(input logic clk, reset, start, genShape, key1, key2, key, move, loser, doneSet, 
output logic rotate, setShape, moveLeft, moveRight, setUp, getXandY, drawingBoard, newLines, clearLines, generateShape);
	enum {idle, generatingShape, generating, setOrigin, falling, clearingLines, lost} ps, ns;
	logic [2:0] counter;
	logic [2:0] clearLinesCounter;
	assign drawingBoard = (ps==idle);
	always_comb begin
		case(ps)
			idle:begin
				ns=idle;
				if(start) 
					ns = generatingShape;
			end
			
			generatingShape: begin
				ns=generating;
			end
			generating: begin
				ns = generating;
				if(counter == 3'd2)
					ns = setOrigin;
			end
			
			setOrigin: begin
				ns=setOrigin;
				if(counter == 3'd3)
					ns = falling;
			end
			
			falling: begin
				ns = falling;
				if(loser)
					ns = lost;
				else if(genShape)
					ns = clearingLines;
			end
			
			clearingLines: begin
				ns=clearingLines;
				if(clearLinesCounter == 3'd4)
					ns=generatingShape;
			end
			
			
			lost:begin
				ns = lost;
			end
			
		endcase 
	end
	
	always_ff@(posedge clk) begin
		if(reset) begin
			ps<=idle;
			counter<=3'd0;
			getXandY <= 1'b0;
			clearLinesCounter <= 3'd0;
		end
		else begin
			ps<=ns;
		end
		if(ps==clearingLines)
			clearLinesCounter <= clearLinesCounter + 3'd1;
		if(clearLinesCounter == 3'd4)
			clearLinesCounter <= 3'd0;
		if(ps==falling && genShape)
			counter<=3'd0;
		if(move)
			counter<=counter+1;
		if(ps==generating && counter == 3'd2)
			getXandY <= 1'b1;
		if(doneSet)
			getXandY <= 1'b0;
	end 
	assign generateShape = (ps==generatingShape);
	assign clearLines = (ps==clearingLines);
	assign newLines = (ps==generating);
	assign setShape = (counter==3'd3 && ps==setOrigin);
	assign rotate = (ps==falling) && key;
	assign moveLeft = (ps==falling) && key1;
	assign moveRight = (ps==falling) && key2;
	assign setUp = (ps==generating);
endmodule 