module Adder(a,b,c);
input wire [31:0]a;
input wire [31:0]b;
output reg [31:0]c;

always @(*)begin
    c = a + b;
end

endmodule