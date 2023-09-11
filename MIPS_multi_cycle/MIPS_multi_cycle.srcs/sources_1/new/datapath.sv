`timescale 1ns / 1ps

module datapath(
    input logic clk,res,
    input logic iord,irwr,zeroext,
                pcen,alusa,regwr,regdst,memtoreg,
    input logic [1:0] pcsrc,alusb,
    input logic [2:0] aluctr,
    input logic [31:0] readdata,
    output logic [31:0] adr, writedata,
    output logic [5:0]funct,op,
    output logic zero
    );
    
    logic [31:0] pc_next,pc,aluout,instr,data,wd3,rd1,
                 rd2,A,B,srcA,srcB,signimm,aluresult;
    logic [4:0] wa3;
    
    flopenr#(32) PcReg(clk,res,pcen,pc_next,pc);
    mux2#(32) AdrMux(iord,pc,aluout,adr);
    flopenr#(32) IR(clk,res,irwr,readdata,instr);
    flopenr#(32) DR(clk,res,1'b1,readdata,data);
    
    assign op=instr[31:26];
    assign funct=instr[5:0];
    mux2#(5) A3Mux(regdst,instr[20:16],instr[15:11],wa3);
    mux2#(32) Wd3Mux(memtoreg,aluout,data,wd3);
    
    regfile RegFile(clk,regwr,instr[25:21],instr[20:16],wa3,wd3,rd1,rd2);
    flopenr#(32) Rd1Reg(clk,res,1'b1,rd1,A);
    flopenr#(32) Rd2Reg(clk,res,1'b1,rd2,writedata);
//    assign writedata=B;
    
    signextend SignExtend(instr[15:0],zeroext,signimm);
    mux2#(32) AMux(alusa,pc,A,srcA);
    mux4#(32) BMux(alusb,writedata,32'h4,signimm,signimm<<2,srcB);
    alu ALU(aluctr,srcA,srcB,aluresult,zero);
    
    flopenr#(32) ALUoutR(clk,res,1'b1,aluresult,aluout);
    mux4#(32) PC_nextMux(pcsrc,aluresult,aluout,{pc[31:28],instr[25:0],2'b00},32'b0,pc_next);
    
endmodule
