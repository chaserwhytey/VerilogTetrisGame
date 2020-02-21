module generateShape(input logic [2:0] num, 
output logic [1:10] line1, line2);
	logic [2:0] shape;
	always_comb begin

		if(num==3'd0)
			shape = 3'd1;
		else
			shape = num;
		case(shape)
			3'b000:begin
				line1 = 10'd0;
				line2 = 10'd0;
			end
			3'b001:begin
				line2 = {1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};

			end
			3'b010:begin
				line2 = {1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
			end
			3'b011:begin
				line2 = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
			end
			3'b100:begin
				line2 = {1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0};
			end
			3'b101:begin
				line2 = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
				line1 = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0};
			end
			3'b110:begin
				line2 = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b1,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
			end
			3'b111:begin
				line2 = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b0,1'b0,1'b0};
				line1 =  {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
			end
		endcase 
		
	end
endmodule 