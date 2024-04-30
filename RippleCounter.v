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

module RippleCounter(clock, clear,q, j0, k0);
	output [3:0]q ;
	input clock, clear, j0, k0;

	MasterSlave ms1 (q[0],q0bar, j0, k0, clock, clear);
	MasterSlave ms2 (q[1],q1bar, j0, k0, q[0], clear);
	MasterSlave ms3 (q[2],q2bar, j0, k0, q[1], clear);
	MasterSlave ms4 (q[3],q3bar, j0, k0, q[2], clear);
endmodule


module tb_ripplecounter;
    reg clock, clear, j0, k0;
    wire [3:0]q;

    RippleCounter ripplecounter_inst (clock, clear,q, j0, k0);

    initial begin
        clock = 1'b0;
        j0 = 1;
        k0 = 1;
        clear = 1;
        #10 clear = 0;
        #20 clear = 1;
    end

    always #10 clock = ~clock;

    always @(posedge clock) begin
        if (q[3] == 1 && q[2] == 0 && q[1] == 0 && q[0] == 1) begin
            #10 clear = 0;
            #20 clear = 1;
        end
    end
endmodule




