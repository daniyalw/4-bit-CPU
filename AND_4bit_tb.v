module AND_4bit_tb;
    reg [3:0] A, B;
    wire [3:0] Y;

    AND_4bit uut (
        .A(A),
        .B(B),
        .Y(Y)
    );

    initial begin
		$dumpfile("AND_4bit_tb.vcd");
		$dumpvars(0, AND_4bit_tb);

        // test case 1
        A = 4'b0000; B = 4'b0000; #10;
        $display("A=%b B=%b | Y=%b", A, B, Y);

        // test case 2
        A = 4'b0001; B = 4'b0010; #10;
        $display("A=%b B=%b | Y=%b", A, B, Y);

        // test case 3
        A = 4'b1111; B = 4'b1111; #10;
        $display("A=%b B=%b | Y=%b", A, B, Y);

        // test case 4
        A = 4'b1010; B = 4'b1100; #10;
        $display("A=%b B=%b | Y=%b", A, B, Y);

        // test case 5
        A = 4'b0110; B = 4'b0011; #10;
        $display("A=%b B=%b | Y=%b", A, B, Y);

        $finish;
    end
endmodule