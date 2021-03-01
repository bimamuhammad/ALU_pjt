module ALU_Control(
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

output reg ldA;
output reg ldB;
output reg aCmp;
output reg aAdd;
output reg aSub;
output reg aDiv;
output reg aMul;
input wire [3:0] Datain;
input wire reset;
input wire readNext;
input wire clk;

parameter LdA=4'b0000, CMP1=4'b0001, CMP=4'b0010, ADD=4'b0011, SUB=4'b0100, DIV=4'b0101, MUL=4'b0110, LdB=4'b0111, LdO=4'b1000;


reg [3:0] state;
reg [3:0] nextstate= LdA;
reg [3:0] opcode;
reg nextRead = 1'b0;

//assign nextRead = (!readNext)? 1'b1:1'b0;

always @(posedge clk or negedge reset) begin
	opcode <= Datain[3:0];
	
	if(!reset)
		state <= LdA;
	else
		state <= nextstate;

end


reg resetNxt =	1'b0;
reg predNxt = 1'b0;
always @(readNext or state) begin
	//if(resetNxt) begin
	if(state == CMP1) begin
		nextRead <= 1'b0;
	end else begin
		if(readNext==0) begin
			if(predNxt == 1) begin
				nextRead <= ~nextRead;
				predNxt <= 1'b0;
			end//predNxt == 0)
		end
		else begin
			predNxt <=1'b1;
		end
	end
end


always @(state or nextRead) begin
	case(state)
	
		LdA: begin  ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0;
			resetNxt = 0;
			if(nextRead) begin // 0 -> 1 -> ldB
				ldA =1'b1;
				nextstate=LdB;
			end
			else begin
				ldA =1'b0;
				nextstate=LdA;
			end
		end
		
		LdB: begin ldA =1'b0;  aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0;
			if(!nextRead) begin // 1 -> 0-> lDO
			//	if(!ldA) begin
						ldB=1'b1;
						nextstate=LdO;
			//	end
			end
			else begin
				ldB=1'b0;
				nextstate=LdB;			
			end
		end
		LdO: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0;
			if(nextRead) begin //0 -> 1 -> CMP1
				nextstate=CMP1;
			end else
				nextstate=LdO;			
		end
		
		CMP1: begin
			resetNxt = 1;
			ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0;
			case(opcode)
				4'b0001: nextstate=CMP;
				4'b0010: nextstate=ADD;
				4'b0011: nextstate=SUB;
				4'b0100: nextstate=DIV;
				4'b0101: nextstate=MUL;
				default: nextstate=LdA;
			endcase		
		end
		
		CMP: begin ldA =1'b0; ldB=1'b0; aCmp=1'b1; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0; nextstate=LdA; end
		
		ADD: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b1; aSub=1'b0; aDiv=1'b0; aMul=1'b0; nextstate=LdA;end
		
		SUB: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b1; aDiv=1'b0; aMul=1'b0; nextstate=LdA;end
		
		DIV: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b1; aMul=1'b0; nextstate=LdA;end
		
		MUL: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b1; nextstate=LdA; end
		
		default: begin ldA =1'b0; ldB=1'b0; aCmp=1'b0; aAdd=1'b0; aSub=1'b0; aDiv=1'b0; aMul=1'b0; nextstate=LdA;end
	
	endcase

end

/*
always @(state) begin
	if(state == CMP1)
		opcode <= Datain[3:0];
end
*/
endmodule
