module selXandY(input logic [10:0] x1, y1, x2, y2, input logic drawingBoard, color1, output logic [10:0] x, y, output logic color);
	assign x = drawingBoard ? x1: x2;
	assign y = drawingBoard ? y1: y2;
	always_comb begin
		if(drawingBoard)
			color = 1'b1;
		else 
			color = color1;
	end
endmodule 