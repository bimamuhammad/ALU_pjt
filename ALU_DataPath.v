module ALU_DataPath(
	Y, 
	Datain,
	ldA,
	ldB,
	aCmp,
	aAdd,
	aSub,
	aDiv,
	aMul,
//	readNext,
	clk
);

output wire [7:0]	Y;
input wire [3:0] Datain;
input wire	ldA;
input wire	ldB;
input wire	aCmp;
input wire	aAdd;
input wire	aSub;
input wire	aDiv;
input wire	aMul;
//input wire	readNext;
input wire	clk;


wire [3:0] A;
wire [3:0] B;

reg [11:0] X = 12'b0;
assign A= X[11:8];
assign B= X[7:4];


reg [3:0] Xdatain;
wire [7:0] M, N , O, P, Q;
reg status = 1'b0;



//LdA lda(A, X[11:8], ldA, clk);
//LdB ldb(B, X[7:4], ldB, clk);
CMP cmp(M, A, B, aCmp);
ADD add(N, A, B, aAdd);
SUB sub(O, A, B, aSub);
DIV div(P, A, B, aDiv);
MUL mul(Q, A, B, aMul);
RST rst(Y, A, B, M, N, O , P, Q, aCmp,aAdd,aSub,aDiv,aMul,clk);

always @(ldA or ldB) begin
	Xdatain<=Datain;
	status = ~status;
	if(ldA) begin
		X = {8'b00000000,Datain};
	end
	else if(ldB) begin
		X = (X<<4) + {8'b00000000,Datain};
		X = X<<4;
	end
end

endmodule
