module LSFR10bit(input logic clk,reset,move,output logic [2:0] num);
	logic [10:0] ps;
	logic no;
	xnor n1(no,ps[7],ps[5]);
	
	always_ff@(posedge clk) begin
		if (reset) begin
		ps <= 11'b11010101100;
		end
		else 
			ps <= {ps[9],ps[8],no,ps[6],ps[5],ps[4],ps[3],ps[2],ps[1],ps[0],ps[10]};

	end
	assign num = ps%8;
	

endmodule

module LSFR10bit_testbench();
logic [10:0] x0,x1,y0,y1;
logic clk, reset,move;

LSFR10bit dut(clk,reset,move,x0,x1,y0,y1);

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
                             

	for(i=0;i<100;i++)begin
		move<=1;@(posedge clk);
		move<=0;@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		end
	$stop;
	                            
end
															
endmodule
