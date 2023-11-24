module Source
(
   input             clk,
   input             rst,

	output reg [31:0] x1,
	output reg [31:0] x2,
	output reg        over,
	output reg        val
);

always @(posedge clk or negedge rst)begin
	if (!rst)begin
		x1  = 0;
		x2  = 0;
		val = 0;
		over = 0;
	end
   else if ($test$plusargs("debug")) begin
		$value$plusargs("X1=%x", x1[31:0]);
		$value$plusargs("X2=%x", x2[31:0]);

		/*
		x1 = $shortrealtobits(1.0);
		x2 = $shortrealtobits(1.0);
		*/

		val  = 1;
		over = 1;
	end
   else if ($test$plusargs("smoke")) begin

		val = 1;
		x1[22:0] = {x1[21:0],1'b1};
		if (x1[22])begin
			x1[30:23] = x1[30:23] + 1;
			x1[22:0] = 0;
		end

		if (x1[30:23] == 255)begin
			x2[22:0] = {x2[21:0], 1'b1};
			x1[30:0] = 0;
			x1[31] = 1;
		end
		
		if (x2[22])begin
			x2[30:23] = x2[30:23] + 1;
			x2[22:0] = 0;
		end

		if (x2[30:23] == 255)begin
			//x2[30:23] =1;
			over = 1;
		end

	end
	else begin
		val = 1;
		x1[22:0] = x1[22:0] + 1;
		if (x1[22:0] == 23'h7FFFFF)begin
			x1[30:23] = x1[30:23] + 1;
			x1[22:0] = 0;
			$display ("+++++++++++++++++++++++++++++++++ %x %x %x++++++++++++++++++++\n", x1[31], x1[30:23], x1[22:0]);
		end

		if (x1[30:23] == 255)begin
			x2[22:0] = x2[22:0] + 1;
			x1[30:0] = 0;
			x1[31] = 1;
		end
		
		if (x2[22:0] == 23'h7FFFFF)begin
			x2[30:23] = x2[30:23] + 1;
			x2[22:0] = 0;
		end

		if (x2[30:23] == 255)begin
			//x2[30:23] =1;
			over = 1;
		end

	end
end

endmodule