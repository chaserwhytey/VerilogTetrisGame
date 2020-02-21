module getBlockPositions(input logic clk, input logic [1:10] grid [1:20], input logic getXandY, generateShape,
	output logic [4:0] iypos1, iypos2, iypos3, iypos4, output logic [3:0] ixpos1, ixpos2, ixpos3, ixpos4, 
output logic doneSet);
	logic [2:0] counter1;
	logic [2:0] counter2;
	enum {idle, setPos1, setPos2, setPos3, setPos4, setPositions} ps, ns;

	always_ff@(posedge clk) begin
		if(generateShape)begin
			ps <= setPos1;
			counter1 <= 3'd4;
			counter2 <= 3'd1;
			iypos1 <= 5'd0; 
			iypos2 <= 5'd0;
			iypos3 <= 5'd0; 
			iypos4 <= 5'd0;
			ixpos1 <= 5'd0; 
			ixpos2 <= 5'd0; 
			ixpos3 <= 4'd0;
			ixpos4 <= 4'd0;
		end
		else
		if(getXandY) begin
			counter1 <= counter1 + 3'd1;
			if(counter1 == 3'd7) begin
				counter2 <= counter2 + 3'd1;
				counter1 <= 3'd4;
			end
			case(ps)
			idle: begin 
			ps <= idle;
			
			end
			
			setPos1: begin
				if(getXandY && grid[counter2][counter1] == 1'b1)begin
					ixpos1 <= counter1;
					iypos1 <= counter2;
					ps <= setPos2;
				end
				else
					ps <= setPos1;
			end
			
			setPos2: begin
				if(getXandY && grid[counter2][counter1] == 1'b1)begin
					ixpos2 <= counter1;
					iypos2 <= counter2;
					ps <= setPos3;
				end
				else
					ps <= setPos2;
			end
			
			setPos3: begin
				if(getXandY && grid[counter2][counter1] == 1'b1)begin
					ixpos3 <= counter1;
					iypos3 <= counter2;
					ps <= setPos4;
				end
				else
				ps <= setPos3;
			end
			
			setPos4: begin
				if(getXandY && grid[counter2][counter1] == 1'b1)begin
					ixpos4 = counter1;
					iypos4 = counter2;
					ps <= setPositions;
				end
				else
					ps <= setPos4;
			end
		
			setPositions: ps <= idle;
			endcase
		end		
	end
	assign doneSet = (ps==setPositions);
endmodule 

module getBlockPositions_testbench();
	logic [1:10] grid [1:20];
	logic getXandY, gotPos, clk, genShape, doneSet, generateShape;
	logic [4:0] iypos1, iypos2, iypos3, iypos4;
	logic [3:0] ixpos1, ixpos2, ixpos3, ixpos4;
	getBlockPositions dut(.*);
	
	parameter clk_PERIOD = 100;
	initial clk = 1;
	always begin
		#(clk_PERIOD/2); clk = ~clk;
	end
	
	initial begin
		@(posedge clk); genShape <= 1;grid[1]<=10'd5;grid[2]<=10'd9;
		@(posedge clk); genShape <= 0;
		@(posedge clk); 
		@(posedge clk); 
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); 
		$stop; 
	end
	
endmodule