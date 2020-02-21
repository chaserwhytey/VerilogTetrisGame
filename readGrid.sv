module readGrid (clk, reset, grid, x, y, color1);
	input logic [1:10] grid[1:20];
	input logic clk, reset;
	output logic [10:0] x, y;
	output logic color1;
	logic [10:0] refX, refY;
	
	logic [3:0] xCounter;
	logic [4:0] yCounter;
	logic doneSq, fillNextSquare;
	logic color2;
	assign refX = (xCounter*11'd24) + 11'd1 + 11'd200;
	assign refY = (yCounter*11'd24) + 11'd1;
	enum {idle, nextSquare, readSquare} ps, ns;
	
	always_comb begin
		
		case(ps)
		idle:begin
			ns= idle;
			
		end
		nextSquare: begin
			ns= readSquare;
		end
		readSquare: begin
			ns=readSquare;
			if(xCounter == 9 && yCounter == 19 && doneSq)
				ns=idle;
			else if(doneSq)
				ns = nextSquare;
		end
		endcase
	end
	always_ff @(posedge clk) begin
		if (reset) begin
			xCounter <= 0;
			yCounter <= 0;
			ps <= nextSquare;
		end
		else begin
			if(grid[yCounter+5'd1][xCounter+4'd1] == 1'b1)
			color2 <= 1'b1;
		else 
			color2 <= 1'b0;
			color1 <= color2;
			ps <= ns;
			if (xCounter != 9 && doneSq) begin
				xCounter <= xCounter + 5'd1;
			end
			else if (xCounter == 9 && doneSq && yCounter != 19) begin
				xCounter <= 4'd0;
				yCounter <= yCounter + 5'd1;
			end
		end
	end
	assign fillNextSquare = (ps == nextSquare);
	fillSquare check (.clk, .reset(fillNextSquare), .refX, .refY, .x, .y, .doneSq);

endmodule

module readGrid_testbench();
	logic clk, reset, color1;
	logic [10:0] x, y;
	logic [1:10] grid [1:20];
	
	readGrid dut (.*);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD/2); clk = ~clk;
	end
	integer i;
	initial begin
		@(posedge clk); reset <= 1;
		for (i = 1; i <= 20; i++) begin
		@(posedge clk); grid[i] <= i;
		end
		@(posedge clk); reset<=1'b0;
		for (i = 0; i <140000; i++) @(posedge clk);
		@(posedge clk); 
		$stop; 
	end
endmodule
