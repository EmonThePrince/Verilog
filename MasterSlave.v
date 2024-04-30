module MasterSlave(Q, Qbar, J, K, clock, clear);

	input J, K, clock, clear;
	output Q, Qbar;
	wire y, ybar;
	nand(a, J, clock, clear, Qbar);
	nand(b, K, clock, Q);
	nand(y, a, ybar);
	nand(ybar, b, clear, y);
	not(inverseClock,clock);
	nand(c, inverseClock, y);
	nand(d, inverseClock, ybar);
	nand(Q, c, Qbar);
	nand(Qbar, d, Q, clear);
	
endmodule



