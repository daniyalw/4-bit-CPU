module alu_4bit_tb;
	reg [3:0] a, b;
	reg [2:0] opcode;

	wire [3:0] result;
	wire cout, error_opcode;

	integer i, error_count = 0, error = 0;

	reg [3:0] expected_add, expected_and, expected_or;
	reg expected_cout;

	alu_4bit alu (.a(a), .b(b), .opcode(opcode), .result(result), .cout(cout), .error_opcode(error_opcode));

	initial begin
		$dumpfile("alu_4bit.vcd"); // save waveform file
		$dumpvars(0, alu_4bit_tb);

		$display("Running 4-bit ALU tests...");

		// 4-bit ripple-carry adder tests
		opcode = 3'b000;

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

			if (error_opcode !== 1'b0) begin
				$display("ERROR: opcode invalid. (opcode=%b)", opcode);
				error = 1;
			end

			if (error)
				error_count = error_count + 1;

			error = 0;
		end

		// 4-bit AND tests
		opcode = 3'b001;

		for (i = 0; i < 256; i = i + 1) begin
			{b, a} = i[7:0];

			#2; // 2 time units

			expected_and = a & b;

			if (result !== expected_and) begin
				$display("ERROR: %b & %b becomes %b (expected = %b)", a, b, result, expected_and);
				error = 1;
			end

			if (error_opcode !== 1'b0) begin
				$display("ERROR: invalid opcode error asserted incorrectly (opcode=%b)", opcode);
				error = 1;
			end

			if (error)
				error_count = error_count + 1;
			
			error = 0;
		end

		// 4-bit OR tests
		opcode = 3'b010;

		for (i = 0; i < 256; i = i + 1) begin
			{b, a} = i[7:0];

			#2; // 2 time units

			expected_or = a | b;

			if (result !== expected_or) begin
				$display("ERROR: %b | %b becomes %b (expected = %b)", a, b, result, expected_or);
				error = 1;
			end

			if (error_opcode !== 1'b0) begin
				$display("ERROR: invalid opcode error asserted incorrectly (opcode=%b)", opcode);
				error = 1;
			end

			if (error)
				error_count = error_count + 1;
			
			error = 0;
		end

		// invalid tests here
		for (i = 3; i < 8; i = i + 1) begin
			a = 4'b0100;
			b = 4'b1101;
			opcode = i;

			#2;

			if ((result !== 4'b0000) || (cout !== 1'b0) || (error_opcode !== 1'b1)) begin
				$display("ERROR: invalid opcode does not clear result or cout, or does not turn error_opcode to 1.");
				error_count = error_count + 1;
			end
		end
		
		// error display here
		if (error_count > 0)
			$display("FAILED: %0d error(s).", error_count);
		else
			$display("SUCCESS: 0 errors.");

		$finish;
	end
endmodule