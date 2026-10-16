module adder_4bit_tb;
	reg [3:0] a, b;

	wire [3:0] sum;
	wire cout;

	integer i, error_count = 0, error = 0;
	reg [3:0] expected_sum;
	reg expected_cout;

	adder_4bit a4b (.a(a), .b(b), .sum(sum), .cout(cout));

	initial begin
		$dumpfile("adder_4bit.vcd"); // save waveform file
		$dumpvars(0, adder_4bit_tb);

		$display("Running 4-bit ripple-carry adder tests...");

		// 4-bit ripple-carry adder tests
		for (i = 0; i < 256; i = i + 1) begin
			{b, a} = i[7:0];

			#2; // 2 time units

			{expected_cout, expected_add} = a + b;

			if (result !== expected_add) begin
				$display("ERROR: %b + %b becomes sum=%b (expected sum = %b).", a, b, result, expected_add);
				error = 1;
			end

			if (cout !== expected_cout) begin
				$display("ERROR: %b + %b becomes cout=%b (expected cout = %b).", a, b, cout, expected_cout);
				error = 1;
			end

			if (error)
				error_count = error_count + 1;
			
			error = 0;
		end

		// error display section
		if (error_count > 0)
			$display("FAILED: %0d error(s).", error_count);
		else
			$display("SUCCESS: 0 errors.");

		$finish;
	end
endmodule