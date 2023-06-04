module InstructionMemory (PC, instruction);
	input wire [31:0]PC;
  	output [31:0]instruction;
	reg [31:0]ROM[0:31]; 
    
	initial begin
		$readmemb("entrada/code.txt", ROM);
	end

    assign instruction = ROM[PC>>2];

endmodule