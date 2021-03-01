module ALU_Design(
	LEDR,
	Datain,
	reset,
	readNext,
	clk
);


output reg [9:0] LEDR;
input wire [3:0] Datain;
input wire reset;
input wire readNext;
input wire clk;


//reg [11:0] Datain = 12'b010001010010;
wire ldA;
wire ldB;
wire aCmp;
wire aAdd;
wire aSub;
wire aDiv;
wire aMul;

//assign LEDR[9:8] = {readNext, reset};
wire [7:0] Y;

ALU_Control ALU_C( 
	ldA,
	ldB,
	aCmp,
	aAdd,
	aSub,
	aDiv,
	aMul,
	Datain,
	reset,
	readNext,
	clk
);

ALU_DataPath ALU_D(
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

always @(posedge clk) begin
	LEDR<= {readNext, reset,Y};
end


endmodule
