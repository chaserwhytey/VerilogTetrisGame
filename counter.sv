	module counter #(parameter maxval=30)
(input logic clk, reset, output logic move, moveFast);
	logic [25:0] count;
	
	always_ff@(posedge clk)
		if(reset||count==maxval)
			count<=0;
		else
			count<=count+1;
	assign move=(count==maxval);
	assign moveFast = (count == 5000000);
endmodule
	
module counter_testbench();
	logic clk, reset;
	logic move;
	counter dut(clk,reset,move);
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
                             

	for(i=0;i<100;i++)
		@(posedge clk);
	$stop;
	                            
end
															
endmodule
