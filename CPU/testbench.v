`timescale 10ns / 100ps
`include "connections.v"

module testbench ();
  reg clk, reset;
  wire [63:0]address;
  wire [63:0]ALUResult;
  wire [31:0]instruction;
  wire [4:0]ReadRegister1;
  wire [4:0]ReadRegister2;
  wire [4:0]WriteRegister;
  integer i;

  datapath data (.clk(clk), .reset(reset), .instruction(instruction));

  initial begin
    reset = 0;
    $dumpfile("resultado.vcd");
    $dumpvars;
    for(i=0; i<32; i=i+1) begin
			$dumpvars(0, data.registerM.register[i]);
		end
    clk = 0;
    #10000 $finish;
  end

  always begin
    #10 clk = ~clk;
  end

endmodule