module RST(
	Y,
	A,
	B,
	M,
	N,
	O,
	P,
	Q,
	aCmp,
	aAdd,
	aSub,
	aDiv,
	aMul,
	clk
);

output reg [7:0] Y;
input wire [7:0] M;
input wire [7:0] N;
input wire [7:0] O;
input wire [7:0] P;
input wire [7:0] Q;
input wire [3:0] A;
input wire [3:0] B;
input wire	aCmp;
input wire	aAdd;
input wire	aSub;
input wire	aDiv;
input wire	aMul;
input wire	clk;

always @(posedge clk) begin
	
	if(aCmp)
	 Y<=M;
	else if(aAdd)
	 Y<=N;
	else if(aSub)
	 Y<=O;
	else if(aDiv)
	 Y<=P;
	else if(aMul)
	 Y<=Q;
	//else
	// Y <= {A,B};
	
end


endmodule
