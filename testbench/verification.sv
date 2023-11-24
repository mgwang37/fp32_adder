module Verification
(
   input        clk,
   input        rst,

	input [31:0] x1,
	input [31:0] x2,
	input        over,
	input        val,

	input [31:0] y
);

reg [31:0] x1_1;
reg [31:0] x1_2;
reg [31:0] x1_3;
reg [31:0] x1_4;
reg [31:0] x1_5;

reg [31:0] x2_1;
reg [31:0] x2_2;
reg [31:0] x2_3;
reg [31:0] x2_4;
reg [31:0] x2_5;

reg        over_1;
reg        over_2;
reg        over_3;
reg        over_4;
reg        over_5;

reg        val_1;
reg        val_2;
reg        val_3;
reg        val_4;
reg        val_5;

always@(posedge clk or negedge rst)begin
	if (!rst)begin
		x1_1 <= 0;
		x1_2 <= 0;
		x1_3 <= 0;
		x1_4 <= 0;
		x1_5 <= 0;

		x2_1 <= 0;
		x2_2 <= 0;
		x2_3 <= 0;
		x2_4 <= 0;
		x2_5 <= 0;
		
		over_1 <= 0;
		over_2 <= 0;
		over_3 <= 0;
		over_4 <= 0;
		over_5 <= 0;
		
		val_1 <= 0;
		val_2 <= 0;
		val_3 <= 0;
		val_4 <= 0;
		val_5 <= 0;
	end
	else begin
		val_5 <= val_4;
		val_4 <= val_3;
		val_3 <= val_2;
		val_2 <= val_1;
		val_1 <= val;

		x1_5 <= x1_4;
		x1_4 <= x1_3;
		x1_3 <= x1_2;
		x1_2 <= x1_1;
		x1_1 <= x1;

		x2_5 <= x2_4;
		x2_4 <= x2_3;
		x2_3 <= x2_2;
		x2_2 <= x2_1;
		x2_1 <= x2;

		over_5 <= over_4;
		over_4 <= over_3;
		over_3 <= over_2;
		over_2 <= over_1;
		over_1 <= over;
	end
end

shortreal  x1_real,x2_real,y_real,result_real,threshold;
reg [31:0] bit_result;
reg [31:0] mistake;

always @(posedge clk)begin
	if (val_5)begin
		x1_real     = $bitstoshortreal(x1_5);
		x2_real     = $bitstoshortreal(x2_5);
		y_real      = $bitstoshortreal(y);
		result_real = $bitstoshortreal(x1_real + x2_real);
		mistake     = y_real - result_real;
		bit_result  = $shortrealtobits(result_real);

		if (bit_result > y)begin
			mistake = bit_result - y;
		end
		else begin
			mistake = y - bit_result;
		end

		if (mistake > 4)begin
			$display ("+++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
			$display ("x1=%E  x2=%E y=%E should=%E", x1_real, x2_real, y_real, result_real);
			$display ("x1=%x:%x:%x  x2=%x:%x:%x y=%x:%x:%x should=%x:%x:%x", x1_5[31],x1_5[30:23],x1_5[22:0], x2_5[31],x2_5[30:23],x2_5[22:0],y[31],y[30:23],y[22:0],      bit_result[31],bit_result[30:23],bit_result[22:0]);
			$display ("x1=%x  x2=%x", x1_5, x2_5);
			$display ("+++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
			//$finish;
		end
	end

	if (over_5)begin
	$finish;
	end
end

endmodule