`timescale 1ns/1ps

module testbench();
reg         clk;
reg         rst_n;
wire [31:0] x1;
wire [31:0] x2;
wire [31:0] y;

always #1 clk = ~clk;

Source source
(
	.clk(clk),
	.rst(rst_n),

	.x1(x1),
	.x2(x2),
	.over(over),
	.val(val)
);

FP32Adder adder
(
	.clk(clk),
	.en(1'b1),

	.x1(x1),
	.x2(x2),

	.y(y)
);

Verification verification
(
	.clk(clk),
	.rst(rst_n),

	.x1(x1),
	.x2(x2),
	.over(over),
	.val(val),

	.y(y)
);


initial begin
	clk = 0;
	rst_n = 0;
	if ($test$plusargs("debug")) begin
		$display("========== Dump fsdb wave ==========");
		$fsdbDumpfile("waveform.fsdb");
		$fsdbDumpvars("+all");
	end
	#1;
	rst_n = 1;
end

endmodule