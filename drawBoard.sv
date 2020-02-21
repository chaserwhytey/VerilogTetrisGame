module drawBoard(input logic reset, clk, input logic [1:10] grid[1:20], output logic [10:0] x, y);
	logic [10:0] xcurr, ycurr,x0,y0,x1,y1;
	logic drawn;
	logic drawNewLine, drawX, drawY;
	enum {idle, newLine, drawing, donesies} ps, ns;
	always_comb begin
		if(drawY) begin
					y0=ycurr;
					y1=ycurr;
					x0=11'd200;
					x1=11'd440;
				end
			else begin
				y0=11'd0;
				y1=11'd479;
				x0=xcurr;
				x1=xcurr;
			end
		case(ps)
			idle:begin
				drawNewLine=1'b0;
				ns = idle;
			end
			
			newLine: begin
				drawNewLine=1'b1;
				ns=drawing;
			end	

			drawing:begin
				drawNewLine=1'b0;
				ns=drawing;
				if(drawn) 
					if(xcurr==11'd440&&ycurr==11'd456)
						ns=donesies;
					else
						ns=newLine;
			end	
			donesies:begin
				drawNewLine=1'b0;
				ns=idle;
			end
		endcase
	end
	
	always_ff@(posedge clk) begin
		if(reset) begin
			xcurr<=11'd200;
			ycurr<=11'd0;
			ps<=newLine;
			drawX<=1'b0;
			drawY<=1'b1;
		end
		else begin
		
		if((ycurr == 11'd456) && (xcurr == 11'd440) && drawn) begin
			drawY <= 1'b0;
			drawX <= 1'b0;
		end
		
		else if(ycurr == 11'd456 && drawn) begin
			drawY <= 1'b0;
			drawX <= 1'b1;
		end	
		ps<=ns;
		if(drawY&&drawn&&ycurr<11'd456) begin
			ycurr<=ycurr+11'd24;
		end
		else if(drawX&&drawn&&xcurr<11'd440) begin
			xcurr<=xcurr+11'd24;
	
		end
		end
	end
	line_drawer l1(.clk,.reset(drawNewLine),.x0,.y0,.x1,.y1,.x,.y,.drawn);
endmodule 

module drawBoard_testbench();
	logic [10:0] x, y;
	logic [1:10] grid[1:20];
	logic reset, clk,done;
	drawBoard dut(.*);
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	
	int i;
	initial begin
	reset <= 1;	                              @(posedge clk);
   	reset<=0;                              	@(posedge clk);
                             

	for(i=0;i<10000;i++)
		@(posedge clk);
	$stop;
	                            
end
															
endmodule
