`include "PC.v"
`include "InstructionMemory.v"
`include "Control.v"
`include "Registers.v"
`include "ImmediateGenerator.v"
`include "ALU.v"
`include "ALUCtrl.v"
`include "DataMemory.v"
`include "Adder.v"
`include "Multiplexador.v"

module datapath (clk, reset, instruction);
    input wire clk;
    input wire reset;
    wire [31:0]ReadData1, ReadData2, WriteData, ReadData;
    wire [31:0]PC;
    wire [31:0]imediato;
    wire [31:0]aluMuxResult;
    wire ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
    wire [1:0]ALUOperation; 
    wire zero;
    wire [31:0]PCQuatro;
    wire [31:0]PCJump;
    //wire [31:0]shiftResult;
    wire [3:0]ALUControl; 
    wire BranchResult;
    output wire [31:0]instruction;
    wire [31:0]address;
    wire [31:0]ALUResult;

    assign BranchResult = zero & Branch; //Check if there is a branch
    //PC Modules
    Adder pcMuxAdd(.a(PC), .b(32'd4), .c(PCQuatro)); //PC + 32'd4 = PC + 4
    Adder aluPCImm(.a(PC),.b(imediato),.c(PCJump)); // PC + ShiftedLeft ImmGen = Jump Address
    Multiplexador PCMux(.inputWire(BranchResult), .choice1(PCQuatro), .choice2(PCJump), .result(address));
    PC programCounter(.clk(clk), .reset(reset), .PC(PC), .address(address));
    // Instruction Memory
    InstructionMemory InstructionMemory (.PC(PC), .instruction(instruction));
    // ImmediateGenerator Modules
    ImmediateGenerator ImmGen (.instruction(instruction), .imediato(imediato));
    //shiftLeft shift(.ImmGenResult(ImmGenResult), .ImmGenShiftLeft(shiftResult));
    // Registers Modules
    RegisterModule registerM(.clk(clk),.ReadRegister1(instruction[19:15]), .ReadRegister2(instruction[24:20]), .WriteRegister(instruction[11:7]), .ReadData1(ReadData1), .ReadData2(ReadData2), .WriteSignal(RegWrite),.WriteData(WriteData), .Instruction(instruction));
    // ALU Modules
    Multiplexador muxRegToAlu(.inputWire(ALUSrc),.choice1(ReadData2),.choice2(imediato),.result(aluMuxResult));
    ALUCtrl AluCtrl (.Funct7(instruction[31:25]), .Funct3(instruction[14:12]), .ALUOperation(ALUOperation), .ALUControl(ALUControl));
    ALU MainALU (.ReadData1(ReadData1), .aluMuxResult(aluMuxResult), .ALUControl(ALUControl), .ALUResult(ALUResult), .zero(zero));
    // Data Memory
    DataMemory DataMemory(.clk(clk), .ALUResult(ALUResult), .WriteData(ReadData2), .ReadData(ReadData), .MemWrite(MemWrite), .MemRead(MemRead));
    Multiplexador muxDataMux(.inputWire(MemToReg),.choice1(ALUResult),.choice2(ReadData),.result(WriteData));
    // Control
    Control Controller (.OPCode(instruction[6:0]), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOperation));

endmodule