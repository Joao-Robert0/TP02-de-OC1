module Multiplexador (inputWire, choice1, choice2, result);
  input wire inputWire;
  input wire [31:0]choice1;
  input wire [31:0]choice2;
  output reg [31:0]result;

  always@(*)begin //Caso seja verdadeiro, (1) ele vai para choice2, caso seja falso (0), vai para choice1
    if(inputWire) result = choice2;
    else result = choice1;
  end
  
endmodule