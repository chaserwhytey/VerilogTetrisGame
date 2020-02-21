module clearScreen(input logic clk, reset,output logic [10:0] x2,y2,output logic res);
	logic count;
	always_ff@(posedge clk) begin
		if(reset) begin
			x2<=0;
			y2<=0;
			count<=1'b1;
		end
		
		else if(count) begin
				y2<=y2+1;
				if(y2==480) begin
					x2<=x2+1;
					y2<=0;
				end
				else 
					x2<=x2;
				if(x2==640&&y2==480)begin
					x2<=0;
					y2<=0;
					count<=1'b0;
				end
					
		end
	end
assign res = (x2==640)&&(y2==480);
endmodule	

module clearScreen_testbench();
	logic clk, reset;
	logic [10:0]x2,y2;

	clearScreen dut(clk,reset,x2,y2);
	

	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	int i;
	initial begin
	reset<=1;@(posedge clk);
	reset<=0; @(posedge clk);
	for(i=0;i<310000;i++) @(posedge clk);
	$stop;
	end
endmodule 