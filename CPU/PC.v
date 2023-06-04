module PC (clk, reset, PC, address);
  input wire clk, reset;
  input wire [31:0] address; 
  output reg [31:0] PC;
  
  initial begin
    PC = 32'b0;  
  end

  always @ (posedge clk) begin
      if(reset) PC <= 32'b0;
      else PC <= address;
  end
endmodule

