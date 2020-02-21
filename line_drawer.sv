
module line_drawer(
	input logic clk,reset,
	input logic [10:0]	x0,y0,x1,y1, //the end points of the line
	output logic [10:0]	x,y,	//outputs corresponding to the pair (x, y)
	output logic drawn
	);
	logic is_steep;
	logic signed [11:0] error,error_next;
	logic [10:0] temp, diffx, diffy, y_next, x_next, xcurr, ycurr, xend, yend;
	enum {starting,idle, drawing, done} ps, ns;
	always_comb begin	
		error_next=error+diffy;
		if(xcurr<xend)
			x_next=xcurr+1;
		else
			x_next=xcurr-1;
			
		y_next=ycurr;
		
		if((error_next)>=0) begin
			if(ycurr<yend)
				y_next=ycurr+1;
			else if(ycurr>yend)
				y_next=ycurr-1;
			error_next=error-diffx+diffy;
		end
	
			x=(is_steep) ? ycurr : xcurr;
			y=(is_steep) ? xcurr : ycurr;
	
		ns=drawing;
		case(ps)
			idle: ns=idle;
			starting:ns=drawing;
			done:ns=idle;
			drawing:if(xcurr == xend)
				ns=done;
				else ns=drawing;
		endcase
	end
	always_ff @(posedge clk) begin
		if(reset) begin
			ps<=starting;
			temp <= 11'd0;
			diffx <= (x0>x1) ? (x0-x1) : (x1-x0);
			diffy <= (y0>y1) ? (y0-y1) : (y1-y0);
			is_steep <= 1'b0;
			xcurr<=x0;
			ycurr<=y0;
			xend<=x1;
			yend<=y1;
			error<=-diffx/2;
		end
		else begin		
		if(diffy>diffx) begin
			is_steep<=1'b1;
			temp<=diffy;
			diffy<=diffx;
			diffx<=temp;
			xcurr<=ycurr;
			ycurr<=xcurr;
			xend<=y1;
			yend<=x1;
			error <= -diffy/2;
		end
		
		ps<=ns;
		if(xcurr!=xend && ps == drawing) begin
			xcurr<=x_next;
			ycurr<=y_next;
			error<=error_next;
		end
		end
	end 
	assign drawn=(ps==done);
endmodule

module line_drawer_testbench();
	logic clk, reset, drawn;
	logic [10:0] x0,x1,y0,y1,x,y;
	line_drawer dut (.*);
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	int i;
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	reset <= 1;x0<=200;y0<=0;y1 <= 480; x1<=200; @(posedge clk);
	reset <= 0;  @(posedge clk);
	for(i=0;i<215;i++)	@(posedge clk);	
	@(posedge clk);
	  @(posedge clk);   
	  @(posedge clk);
	for(i=0;i<700;i++)	@(posedge clk);	  
									

		$stop; // End the simulation.
	end
endmodule	
