`timescale 1ns / 1ps

module mips(
    input logic clk,res,
    input logic [31:0]readdata,
    output logic memwrite,
    output logic [31:0]adr,writedata
    );
    
    

    logic [5:0] op,funct;
    logic zero;
    logic irwrite,regwrite,alusrca,iord,memtoreg,regdst,pcen,zeroext;
    logic [1:0] alusrcb,pcsrc;
    logic [2:0] alucontrol;
    
//    logic [31:0] adr, writedata;
    controlunit ControlUint(clk,res,op,funct,zero,memwrite,irwrite,regwrite,alusrca,
                            iord,memtoreg,regdst,pcen,zeroext,alusrcb,pcsrc,alucontrol);
    datapath DataPath(clk,res,iord,irwrite,zeroext,pcen,alusrca,regwrite,regdst,memtoreg,pcsrc,alusrcb,
                      alucontrol,readdata,adr, writedata,funct,op,zero);                   
    
endmodule
