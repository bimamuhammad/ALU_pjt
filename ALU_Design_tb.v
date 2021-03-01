module ALU_Design_tb();

reg [3:0] Datain;
reg reset;
reg clk;
reg readNext;

wire [7:0] Y;

ALU_Design  ALU(
	.LEDR(Y),
	.Datain(Datain),
	.reset(reset),
	.readNext(readNext),
	.clk(clk)
);


initial begin
	Datain = 4'b0100;
	readNext = 1;
	clk = 1;
	reset = 1;
end

always #2 clk=~clk;

initial begin
	//#50 Datain = 4'b0100;
	#51 readNext=0;
	#2 readNext=1;


	#20 Datain = 4'b0101;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0010;
	#1 readNext=0;
	#2 readNext=1;
	
	//Data2
	#20 Datain = 4'b0101;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0110;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0010;
	#1 readNext=0;
	#2 readNext=1;
	
	//Subtract
	#20 Datain = 4'b1101;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0111;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0011;
	#1 readNext=0;
	#2 readNext=1;
	
	//Compare
	#20 Datain = 4'b1101;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0111;
	#1 readNext=0;
	#2 readNext=1;
	
	#20 Datain = 4'b0001;
	#1 readNext=0;
	#2 readNext=1;

end

endmodule
