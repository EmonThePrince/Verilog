module fullAdder(S, Cout, A, B, Cin);
	input A, B, Cin;
	output S, Cout;
	halfAdder ha1(m, n, A, B);
	halfAdder ha2(S, K, m, Cin);
	or(Cout, n, K);
endmodule


