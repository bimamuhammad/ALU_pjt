module LdA(
	A,
	Datain,
	ldA,
	clk
);

output reg [3:0] A;
input wire [3:0] Datain;
input wire ldA;
input wire clk;

always @(posedge clk) begin
	if(ldA==1'b1)
		A <= Datain[3:0];
	/*else
		A <= 4'bzzzz;
	*/
end

endmodule
