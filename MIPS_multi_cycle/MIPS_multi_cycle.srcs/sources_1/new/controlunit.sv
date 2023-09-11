`timescale 1ns / 1ps


module controlunit(
    input logic clk,res,
    input logic [5:0] op,funct,
    input logic zero,
    output logic memwrite,irwrite,regwrite,alusrca,iord,memtoreg,regdst,pcen,zeroext,
    output logic [1:0] alusrcb,pcsrc,
    output logic [2:0] alucontrol
    );
    
    logic [2:0]aluop;
    logic pcwrite,branch;
    maindec MainDec(clk,res,op,pcwrite,memwrite,irwrite,regwrite,
                    alusrca,branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop);
    aludec ALUDec(funct,aluop,alucontrol);
    
    assign pcen=branch&(zero!=op[0])|pcwrite;
    assign zeroext=(op==001101||op==001100)?1:0;
endmodule
