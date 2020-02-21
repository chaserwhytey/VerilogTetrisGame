module metaStableIn(input logic clk, input logic reset, input logic KEY, output logic key);
	enum {idle, pressed, out} ps, ns;
	always_comb begin
		case(ps)
			idle: begin 
			ns = idle;
			if(~KEY)
				ns=pressed;
			end
			pressed: begin
			ns=pressed;
			if(KEY)
				ns=out;
			end
			out:ns=idle;
		endcase
	end
	always_ff@(posedge clk) begin
		if(reset) 
			ps <= idle;
		else begin
			ps <= ns;
		end
	end
	assign key = (ps==out);
endmodule
