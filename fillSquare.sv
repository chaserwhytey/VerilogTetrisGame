module fillSquare(input logic clk, reset, input logic [10:0] refX, refY, 
output logic [10:0] x, y, output logic doneSq);
	logic [10:0] ycurr, xend, yend;
	logic drawNewLine, drawn;
	enum {idle, newLine, drawing, done} ps, ns;
	always_comb begin
		xend = refX+11'd22;
		yend = refY+11'd22;
		case(ps)
			idle:begin
				drawNewLine = 1'b0;
				doneSq = 1'b0;
				ns=idle;
			end
			
			newLine: begin
				drawNewLine = 1'b1;
				doneSq = 1'b0;
				ns = drawing;
			end	

			drawing:begin
				drawNewLine = 1'b0;
				doneSq = 1'b0;
				ns = drawing;
				if(drawn) 
					if(ycurr == (yend))
						ns = done;
					else
						ns = newLine;
			end	
			done:begin
				drawNewLine = 1'b0;
				doneSq = 1'b1;
				ns=idle;
			end
		endcase
	end
	
	always_ff@(posedge clk) begin
		if(reset) begin
			ycurr<=refY;
			ps<=newLine;
		end
		else begin
		ps<=ns;
		if(ycurr!=(yend)&&drawn) begin
			ycurr<=ycurr+11'd1;
		end
		end
	end
	line_drawer l1(.clk,.reset(drawNewLine),.x0(refX),.y0(ycurr),.x1(xend),.y1(ycurr),.x,.y,.drawn);
endmodule 

module fillSquare_testbench();
	logic [10:0] x, y, refX, refY;
	logic reset, clk,doneSq;
	fillSquare dut(.*);
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	
	int i;
	initial begin
	reset <= 1;	refX<=11'd25;refY<=11'd1;                              @(posedge clk);
   	reset<=0;                              	@(posedge clk);
                             

	for(i=0;i<580;i++)
		@(posedge clk);
	$stop;
	                            
end
															
endmodule