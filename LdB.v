module LdB(
	B,
	Datain,
	ldB,
	clk
);

output reg [3:0] B;
input wire [3:0] Datain;
input wire ldB;
input wire clk;

always @(posedge clk) begin
	if(ldB==1'b1)
		B <= Datain[3:0];
	/*else
		B <= 4'bzzzz;
	*/
end

endmodule